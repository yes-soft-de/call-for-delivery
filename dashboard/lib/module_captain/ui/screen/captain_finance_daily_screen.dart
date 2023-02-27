import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/state_manager/captain_finance_daily_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainFinanceDailyScreen extends StatefulWidget {
  final CaptainFinanceDailyStateManager _manager;

  const CaptainFinanceDailyScreen(this._manager);

  @override
  State<StatefulWidget> createState() => CaptainFinanceDailyScreenState();
}

class CaptainFinanceDailyScreenState extends State<CaptainFinanceDailyScreen> {
  States? _currentState;
  @override
  void initState() {
    _currentState = LoadingState(this);
    widget._manager.stateSubject.listen((value) {
      _currentState = value;

      if (mounted) setState(() {});
    });
    widget._manager.getCaptainsFinanceDaily(this);
    super.initState();
  }

  CaptainFinanceDailyStateManager get manager => widget._manager;
  void refresh() {
    if (mounted) setState(() {});
  }

  void getAccount() {
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    // }
    return Scaffold(
        appBar: CustomC4dAppBar.appBar(
          context,
          title: 'Captain Finance Daily',
        ),
        body: _currentState?.getUI(context));
  }
}
