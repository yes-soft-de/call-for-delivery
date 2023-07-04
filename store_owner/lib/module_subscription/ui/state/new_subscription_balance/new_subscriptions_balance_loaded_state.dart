import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/request/payment/paymnet_status_request.dart';
import 'package:c4d/module_subscription/model/new_subscription_balance_model.dart';
import 'package:c4d/module_subscription/ui/screens/new_subscription_balance_screen/new_subscription_balance_screen.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/payment_gateway.dart';
import 'package:c4d/utils/models/payment_gateway_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewSubscriptionBalanceLoadedState extends States {
  NewSubscriptionBalanceModel balance;
  final NewSubscriptionBalanceScreenState screenState;
  NewSubscriptionBalanceLoadedState(this.screenState, this.balance)
      : super(screenState) {}
  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.accountBalance,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PaymentCard(
                onPayNowButtonPressed: () {
                  if (balance.hasToPay) {
                    showTapPayment(
                        context: context,
                        paymentModel: PaymentGatewayModel(
                          amount: balance.toBePayed,
                        ),
                        callback: (success, resID, trxID, err) {
                          if (success) {
                            screenState.makePayment(PaymentStatusRequest(
                              status: PaymentStatus.paidSuccess,
                              paymentId: trxID,
                              amount: balance.toBePayed,
                              paymentFor: PaymentFor.unifiedSubscription,
                              paymentGetaway: PaymentGetaway.tapPayment,
                              paymentType: PaymentType.realPaymentByStore,
                            ));
                            CustomFlushBarHelper.createSuccess(
                              title: S.current.warnning,
                              message: S.current.paymentSuccess,
                            ).show(screenState.context);
                          } else {
                            CustomFlushBarHelper.createError(
                              title: S.current.warnning,
                              message: S.current.paymentFailed,
                            ).show(screenState.context);
                          }
                        });
                  } else {
                    CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.youDontHaveToPayYet,
                    ).show(screenState.context);
                  }
                },
                balance: balance,
              ),
              SizedBox(height: 10),
              PlanDetailsCard(
                balance: balance,
              ),
              SizedBox(height: 20),
              PlanStatusCard(
                balance: balance,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final void Function()? onPayNowButtonPressed;
  final NewSubscriptionBalanceModel balance;

  const PaymentCard({
    super.key,
    required this.onPayNowButtonPressed,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: green,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.toBePayed,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white),
            ),
            SizedBox(height: 10),
            Flexible(
              fit: FlexFit.loose,
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Flexible(
                      flex: 7,
                      fit: FlexFit.loose,
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.error_outline),
                                  Text(
                                    S.current.currentCycleDetails,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                              Text(S.current.packageStartDate),
                              Text(
                                DateFormat('dd, MMMM')
                                    .format(balance.startDate),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: green,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: 10),
                              Divider(endIndent: 10, indent: 10),
                              Text(S.current.numberOfOrder),
                              Text(
                                balance.orderCount.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: green,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      fit: FlexFit.loose,
                      flex: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Card(
                              margin: EdgeInsets.zero,
                              color: Color.fromARGB(70, 255, 255, 255),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    balance.toBePayed.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      Text(
                                        S.current.saudiRiyal,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                              ),
                              onPressed: onPayNowButtonPressed,
                              child: Text(
                                S.current.payNow,
                                style: greenLargeText(context),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextStyle? greenLargeText(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyLarge
      ?.copyWith(color: green, fontSize: 18);
  Color get green => Color(0xff004D3F);
}

class PlanDetailsCard extends StatelessWidget {
  final NewSubscriptionBalanceModel balance;

  const PlanDetailsCard({
    super.key,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        color: Color(0xffF2F4E6),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15),
              RowItem(
                icon: Icons.shopping_cart_outlined,
                title: S.current.openedPrice,
                value: '${balance.openPriceOrder} ريال',
              ),
              SizedBox(height: 10),
              Divider(indent: 20, endIndent: 20),
              SizedBox(height: 10),
              RowItem(
                icon: Icons.local_shipping_outlined,
                title: S.current.every1KM,
                value: '${balance.costPerKM} ريال',
              ),
              SizedBox(height: 10),
              Divider(indent: 20, endIndent: 20),
              SizedBox(height: 10),
              Text(
                S.current
                    .youHaveToPayWhen(balance.subscriptionCostLimit.toString()),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: green),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color get green => Color(0xff004D3F);
}

class RowItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const RowItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          icon,
        ),
        SizedBox(width: 7),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Spacer(),
        Container(
          constraints: BoxConstraints(minHeight: 30, minWidth: 70),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value),
          ),
        ),
      ],
    );
  }
}

class PlanStatusCard extends StatelessWidget {
  final NewSubscriptionBalanceModel balance;

  const PlanStatusCard({
    super.key,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 30),
              Card(
                color: Color(0xffF2F4E6),
                margin: EdgeInsets.zero,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    children: [
                      SizedBox(height: 25, width: double.maxFinite),
                      Text(
                        balance.status.getTitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(balance.status.getDescription),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Card(
                margin: EdgeInsets.zero,
                color: green,
                child: SizedBox(
                  height: 56,
                  child: Center(
                    child: Text(
                      S.current.subscriptionStatus,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color get green => Color(0xff004D3F);
}
