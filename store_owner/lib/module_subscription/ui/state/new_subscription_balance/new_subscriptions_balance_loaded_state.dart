import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/model/new_subscription_balance_model.dart';
import 'package:c4d/module_subscription/ui/screens/new_subscription_balance_screen/new_subscription_balance_screen.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              PaymentCard(
                onPayNowButtonPressed: () {},
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
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.22,
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.error_outline),
                                Expanded(
                                  child: Text(
                                    S.current.currentCycleDetails,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Text(S.current.packageStartDate),
                            Text(
                              DateFormat('dd, MMMM').format(balance.startDate),
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
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.22,
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
                ),
              ],
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
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.3,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            top: 10,
            child: Card(
              color: Color(0xffF2F4E6),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
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

                    // TODO: you must edit this if it was from backend
                    Text(
                      S.current.youHaveToPayWhen,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: green),
                    ),
                  ],
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
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.sizeOf(context).height * 0.15,
      child: Stack(
        children: [
          Positioned.fill(
            top: 30,
            child: Card(
              color: Color(0xffF2F4E6),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Text(
                      S.current.subscriptionIsActivate,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    // TODO: but plan status message here
                    Text(S.current.youHaveNotExceededTheLimitYet),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Card(
                margin: EdgeInsets.zero,
                color: green,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.6,
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
