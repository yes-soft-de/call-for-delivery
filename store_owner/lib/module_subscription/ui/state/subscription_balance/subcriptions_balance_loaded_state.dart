import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/model/subscription_balance_model.dart';
import 'package:c4d/module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart';
import 'package:c4d/module_subscription/ui/widget/single_package_card.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/subscription_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class SubscriptionBalanceLoadedState extends States {
  SubscriptionBalanceModel balance;
  final SubscriptionBalanceScreenState screenState;
  SubscriptionBalanceLoadedState(this.screenState, this.balance)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context, title: S.current.mySubscription),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SinglePackageCard(
              carsCount: balance.packageCarsCount.toString(),
              ordersCount: balance.packageOrdersCount.toString(),
              packageInfo: '',
              packageName: balance.packageName,
              active: true,
            ),
            // Subscription status
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
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
                              color: Theme.of(context).colorScheme.secondary),
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
                                  boxShadow: balance.status != 'inactive'
                                      ? [
                                          BoxShadow(
                                              color: Colors.green,
                                              spreadRadius: 0.1,
                                              blurRadius: 7,
                                              offset: Offset(-0.1, 0))
                                        ]
                                      : [],
                                  borderRadius: BorderRadius.circular(10),
                                  color: balance.status == 'inactive'
                                      ? Colors.green[100]
                                      : Colors.green),
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
                                  boxShadow: balance.status == 'inactive'
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
                                  color: balance.status == 'inactive'
                                      ? Theme.of(context).colorScheme.error
                                      : Theme.of(context)
                                          .colorScheme
                                          .error
                                          .withOpacity(0.3)),
                            ),
                          ),
                          Text(S.current.inactive),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      S.current.expirationData,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    Text(
                      intl.DateFormat.yMMMMEEEEd().format(balance.endDate),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).disabledColor),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            // status hint
            Visibility(
              visible: balance.status != 'active',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.yellow,
                      boxShadow: [
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
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).disabledColor,
                              fontSize: 14),
                        )),
                  ),
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }

  Widget _getOrderRow(BuildContext context, int filled, int empty,
      [bool danger = false]) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.primary),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.sync_alt_rounded,
                color: Theme.of(context).textTheme.button?.color,
              ),
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      height: 16,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).backgroundColor),
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: filled,
                          child: Container(
                            height: 16,
                            decoration: BoxDecoration(
                              color: danger == true
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: empty,
                          child: Container(
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              )),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          Container(
              width: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${balance.remainingOrders} / ',
                    style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${balance.packageOrdersCount}',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _getCarsRow(BuildContext context, int filled, int empty,
      [bool danger = false]) {
    var rtl = Directionality.of(context) == TextDirection.rtl;
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: danger
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.car_rental_rounded,
                color: Theme.of(context).textTheme.button?.color,
              ),
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      height: 16,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).backgroundColor),
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: filled,
                          child: Container(
                            height: 16,
                            decoration: BoxDecoration(
                              color: danger == true
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: empty,
                          child: Container(
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              )),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          Container(
              width: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${balance.remainingCars} / ',
                    style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${balance.packageCarsCount >= 999999999 ? '∞' : balance.packageCarsCount}',
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.9),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
