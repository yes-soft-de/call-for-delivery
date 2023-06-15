import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_subscription/model/subscription_balance_model.dart';
import 'package:c4d/module_subscription/ui/screens/new_subscription_balance_screen/new_subscription_balance_screen.dart';
import 'package:flutter/material.dart';

class NewSubscriptionBalanceLoadedState extends States {
  SubscriptionBalanceModel balance;
  final NewSubscriptionBalanceScreenState screenState;
  NewSubscriptionBalanceLoadedState(this.screenState, this.balance)
      : super(screenState) {}
  @override
  Widget getUI(BuildContext context) {
    return Placeholder();
  }
}
