import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/my_profit_model.dart';
import 'package:c4d/module_plan/state_manager/my_profits_state_manager.dart';
import 'package:c4d/module_plan/ui/state/my_profits/my_profits_state_loaded.dart';
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
    var model = MyProfitModel(
      orderCountSinceLastPayment: 123,
      ordersCountToday: 12,
      profitSinceLastPayment: 123.45,
      profitToday: 12.34
    );
    _currentState = MyProfitsStateLoaded(this, model);
    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    super.initState();
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
