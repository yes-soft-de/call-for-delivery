import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/request/request_payment.dart';
import 'package:c4d/module_plan/state_manager/my_profits_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyProfitsScreen extends StatefulWidget {
  final MyProfitsStateManager _manager;

  const MyProfitsScreen(this._manager);

  @override
  State<StatefulWidget> createState() => MyProfitsScreenState();
}

class MyProfitsScreenState extends State<MyProfitsScreen> {
  States? _currentState;
  @override
  void initState() {
    _currentState = LoadingState(this);
    getMyProfit();
    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  void getMyProfit() {
    widget._manager.getMyProfit(this);
  }

  void requestPayment() {
    widget._manager.requestPayment(this, RequestPayment(status: 1));
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.myProfits,
      ),
      body: _currentState?.getUI(context) ?? Container(),
    );
  }
}
