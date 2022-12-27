import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captain_financial_dues.dart';
import 'package:c4d/module_captain/state_manager/captain_financial_dues_details_state_manager.dart';
import 'package:c4d/module_captain/ui/state/captain_financial_dues_details/captain_financial_dues_details_state.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';

@injectable
class CaptainFinancialDuesDetailsScreen extends StatefulWidget {
  final CaptainFinancialDuesDetailsStateManager _manager;
  const CaptainFinancialDuesDetailsScreen(
    this._manager,
  );
  @override
  State<StatefulWidget> createState() =>
      CaptainFinancialDuesDetailsScreenState();
}

class CaptainFinancialDuesDetailsScreenState
    extends State<CaptainFinancialDuesDetailsScreen> {
  late States currentState;
  @override
  void initState() {
    currentState = CaptainFinancialDuesDetailsStateLoaded(this);
    manager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  CaptainFinancialDuesDetailsStateManager get manager => widget._manager;
  void refresh() {
    if (mounted) setState(() {});
  }

  late CaptainFinancialDuesModel model;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is CaptainFinancialDuesModel && flag) {
      model = args;
      flag = false;
    }
    return Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.financialDuesDetails),
        body: currentState.getUI(context));
  }
}
