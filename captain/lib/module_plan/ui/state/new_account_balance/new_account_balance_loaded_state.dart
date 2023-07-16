import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/ui/screen/new_account_balance_screen.dart';
import 'package:flutter/material.dart';

class NewAccountBalanceStateLoaded extends States {
  CaptainAccountBalanceModel? balance;
  final NewAccountBalanceScreenState screenState;
  NewAccountBalanceStateLoaded(this.screenState, this.balance)
      : super(screenState) {
    try {
      _scrollController.addListener(() {
        first = false;
        screenState.refresh();
      });
    } catch (e) {
      //
    }
  }
  int currentIndex = 0;
  ScrollController _scrollController = ScrollController();
  bool first = true;
  @override
  Widget getUI(BuildContext context) {
    return const Placeholder();
  }
}
