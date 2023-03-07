import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_captain/request/captain_daily_finance_request.dart';
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
  int currentIndex = 0;
  late CaptainDailyFinanceRequest filter;
  @override
  void initState() {
    _currentState = LoadingState(this);
    widget._manager.stateSubject.listen((value) {
      _currentState = value;

      if (mounted) setState(() {});
    });
    filter = CaptainDailyFinanceRequest(isPaid: 176);
    widget._manager.getCaptainsFinanceDailyNew(this, filter);
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
    return Scaffold(
        appBar: CustomC4dAppBar.appBar(
          context,
          title: S.current.captainFinanceDaily,
          onTap: () {
            GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
          },
          icon: Icons.menu,
        ),
        body: _currentState?.getUI(context));
  }
}
