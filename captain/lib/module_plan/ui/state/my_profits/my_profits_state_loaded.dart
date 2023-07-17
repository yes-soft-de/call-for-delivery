import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/ui/screen/my_profits_screen.dart';
import 'package:flutter/material.dart';

class MyProfitsStateLoaded extends States {
  CaptainAccountBalanceModel? balance;
  final MyProfitsScreenState screenState;
  MyProfitsStateLoaded(this.screenState, this.balance) : super(screenState) {
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
