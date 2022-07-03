import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_captain/state_manager/captain_order_assign_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';

import '../../../utils/global/global_state_manager.dart';

@injectable
class CaptainAssignOrderScreen extends StatefulWidget {
  final CaptainAssignOrderStateManager _stateManager;

  CaptainAssignOrderScreen(this._stateManager);

  @override
  CaptainAssignOrderScreenState createState() =>
      CaptainAssignOrderScreenState();
}

class CaptainAssignOrderScreenState extends State<CaptainAssignOrderScreen> {
  late States currentState;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    getIt<GlobalStateManager>().stateStream.listen((event) {
      getCaptains();
    });
    widget._stateManager.getCaptains(this);
    super.initState();
  }

  void getCaptains() {
    widget._stateManager.getCaptains(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  int? orderID;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is int) {
      orderID = args;
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).captains, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}
