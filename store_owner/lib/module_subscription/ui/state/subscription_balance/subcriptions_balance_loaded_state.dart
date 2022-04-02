import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/balance_status.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/model/captain_offers_model.dart';
import 'package:c4d/module_subscription/model/subscription_balance_model.dart';
import 'package:c4d/module_subscription/subscriptions_routes.dart';
import 'package:c4d/module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart';
import 'package:c4d/module_subscription/ui/widget/capicity_widget.dart';
import 'package:c4d/module_subscription/ui/widget/captain_offer_card.dart';
import 'package:c4d/module_subscription/ui/widget/custom_text_button.dart';
import 'package:c4d/module_subscription/ui/widget/single_package_card.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/subscription_status_helper.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;

class SubscriptionBalanceLoadedState extends States {
  SubscriptionBalanceModel balance;
  final SubscriptionBalanceScreenState screenState;
  SubscriptionBalanceLoadedState(this.screenState, this.balance)
      : super(screenState) {
    balanceStatusEnum = SubscriptionsStatusHelper.getStatusEnum(balance.status);
  }
  late BalanceStatus balanceStatusEnum;
  @override
  Widget getUI(BuildContext context) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();
    return Scaffold(
      appBar: CustomC4dAppBar
          .appBar(context, title: S.current.mySubscription, actions: [
        CustomC4dAppBar.actionIcon(context, onTap: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // buttons
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              // extend subscription
                              CustomTextButton(
                                label: S.current.packageExtend,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  screenState.extendSubscriptions();
                                },
                              ),
                              Divider(
                                indent: 16,
                                endIndent: 16,
                                color: Theme.of(context).backgroundColor,
                                thickness: 2.5,
                              ),
                              // renew new subscription
                              CustomTextButton(
                                label: S.current.renewNewPlan,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushNamed(
                                      SubscriptionsRoutes
                                          .INIT_SUBSCRIPTIONS_SCREEN,
                                      arguments: S.current.renewSubscription);
                                },
                              ),
                              Divider(
                                indent: 16,
                                endIndent: 16,
                                color: Theme.of(context).backgroundColor,
                                thickness: 2.5,
                              ),
                              // renew current subscription
                              CustomTextButton(
                                label: S.current.renewOldPlan,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  screenState
                                      .renewSubscription(balance.packageID);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // close button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder()),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                S.current.close,
                                style: Theme.of(context).textTheme.button,
                              ),
                            )),
                      ),
                    )
                  ],
                );
              });
        }, icon: Icons.restart_alt_rounded)
      ]),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // status hint
            Visibility(
              visible: balanceStatusEnum != BalanceStatus.ACTIVE,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: isDark ? Colors.amber : Colors.yellow,
                      boxShadow: isDark
                          ? []
                          : [
                              BoxShadow(
                                  color: Colors.yellow,
                                  spreadRadius: 0.1,
                                  blurRadius: 7,
                                  offset: Offset(-0.1, 0))
                            ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        leading: Icon(
                          Icons.info,
                        ),
                        title: Text(
                          SubscriptionsStatusHelper.getStatusMessage(
                              balance.status),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        )),
                  ),
                ),
              ),
            ),
            // package card
            SinglePackageCard(
              carsCount: balance.packageCarsCount.toString(),
              ordersCount: balance.packageOrdersCount.toString(),
              packageInfo: '',
              packageName: balance.packageName,
              active: true,
              expired: balance.expired.toString(),
            ),
            // Subscription status
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: isDark
                      ? []
                      : [
                          BoxShadow(
                              color: Theme.of(context).backgroundColor,
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(-0.2, 0)),
                        ],
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).backgroundColor,
                ),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.current.subscriptionStatus,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? null
                                  : Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  boxShadow: balanceStatusEnum !=
                                              BalanceStatus.INACTIVE &&
                                          balanceStatusEnum !=
                                              BalanceStatus.EXPIRED
                                      ? [
                                          BoxShadow(
                                              color: Colors.green,
                                              spreadRadius: 0.1,
                                              blurRadius: 7,
                                              offset: Offset(-0.1, 0))
                                        ]
                                      : [],
                                  borderRadius: BorderRadius.circular(10),
                                  color: balanceStatusEnum ==
                                              BalanceStatus.INACTIVE ||
                                          balanceStatusEnum ==
                                              BalanceStatus.EXPIRED
                                      ? Theme.of(context).disabledColor
                                      : Colors.green),
                              child: Visibility(
                                visible: balanceStatusEnum !=
                                        BalanceStatus.INACTIVE &&
                                    balanceStatusEnum != BalanceStatus.EXPIRED,
                                child: Icon(
                                  Icons.check_rounded,
                                  color:
                                      Theme.of(context).textTheme.button?.color,
                                ),
                              ),
                            ),
                          ),
                          Text(S.current.active),
                          //
                          Spacer(),
                          //
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: balanceStatusEnum ==
                                                BalanceStatus.INACTIVE ||
                                            balanceStatusEnum ==
                                                BalanceStatus.EXPIRED
                                        ? [
                                            BoxShadow(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error,
                                                spreadRadius: 0.1,
                                                blurRadius: 7,
                                                offset: Offset(-0.1, 0))
                                          ]
                                        : [],
                                    color: balanceStatusEnum ==
                                                BalanceStatus.INACTIVE ||
                                            balanceStatusEnum ==
                                                BalanceStatus.EXPIRED
                                        ? Theme.of(context).colorScheme.error
                                        : Theme.of(context).disabledColor),
                                child: Visibility(
                                  visible: balanceStatusEnum ==
                                          BalanceStatus.INACTIVE ||
                                      balanceStatusEnum ==
                                          BalanceStatus.EXPIRED,
                                  child: Icon(
                                    Icons.check_rounded,
                                    color: Theme.of(context)
                                        .textTheme
                                        .button
                                        ?.color,
                                  ),
                                )),
                          ),
                          Text(S.current.inactive),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              S.current.subscriptionDate,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? null
                                      : Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                            Text(
                              intl.DateFormat.yMMMMEEEEd()
                                  .format(balance.startDate),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).disabledColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          children: [
                            Text(
                              S.current.expirationData,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? null
                                      : Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                            Text(
                              intl.DateFormat.yMMMMEEEEd()
                                  .format(balance.endDate),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).disabledColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            // capacity bar
            _getOrderRow(
              context,
              balance.remainingOrders,
              (balance.packageOrdersCount - balance.remainingOrders).abs(),
              (balance.remainingOrders / balance.packageOrdersCount < 0.7),
            ),
            _getCarsRow(
                context,
                balance.remainingCars,
                (balance.packageCarsCount - balance.remainingCars).abs(),
                (balance.remainingCars / balance.packageCarsCount) < 0.7),
            // Captain ads
            Visibility(
              visible: screenState.snapshot.hasData,
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  ListTile(
                    title: Text(S.current.captainPackageExtra),
                    leading: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).backgroundColor),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(Icons.local_taxi_rounded),
                        )),
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: getCaptains(context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 75,
            )
          ],
        ),
      ),
    );
  }

  Widget _getOrderRow(BuildContext context, int filled, int empty,
      [bool danger = false]) {
    return CapacityBar(
      danger: danger,
      empty: empty,
      filled: filled,
      remainingCount: balance.remainingOrders,
      totalCount: balance.packageOrdersCount,
      icon: Icons.sync_alt_rounded,
    );
  }

  Widget _getCarsRow(BuildContext context, int filled, int empty,
      [bool danger = false]) {
    return CapacityBar(
        danger: danger,
        empty: empty,
        filled: filled,
        remainingCount: balance.remainingCars,
        totalCount: balance.packageCarsCount,
        icon: Icons.car_rental_rounded);
  }

  List<Widget> getCaptains(BuildContext context) {
    List<Widget> widgets = [];
    List<CaptainsOffersModel> offers = screenState.snapshot.data ?? [];
    offers.forEach((element) {
      widgets.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: CaptainOfferCard(
            captainNumber: element.carCount.toString(),
            price: element.cost.toStringAsFixed(1),
            title: '',
            expired: element.expired.toString(),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                        onPressed: () {
                          Navigator.of(context).pop();
                          screenState.subscribedToCaptainOffer(element.id);
                        },
                        content: S.current.confirmationCaptainOffers);
                  });
            },
          )));
    });

    return widgets;
  }
}
