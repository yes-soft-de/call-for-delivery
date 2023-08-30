import 'dart:async';

import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_captain/state_manager/captain_order_assign_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';

import '../../../utils/global/global_state_manager.dart';

@injectable
class CaptainAssignOrderScreen extends StatefulWidget {
  CaptainAssignOrderScreen();

  @override
  CaptainAssignOrderScreenState createState() =>
      CaptainAssignOrderScreenState();
}

class CaptainAssignOrderScreenState extends State<CaptainAssignOrderScreen> {
  late States currentState;
  late CaptainAssignOrderStateManager _stateManager;
  late StreamSubscription _stateSubscription;
  late StreamSubscription _globalStateSubscription;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    _globalStateSubscription =
        getIt<GlobalStateManager>().stateStream.listen((event) {
      getCaptains();
    });
    _stateManager.getCaptains(this);
    super.initState();
  }

  void getCaptains() {
    _stateManager.getCaptains(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _globalStateSubscription.cancel();
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  int? orderID;
  CaptainAssignOrderStateManager get manager => _stateManager;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is int) {
      orderID = args;
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.of(context).assignCaptain,
      ),
      body: currentState.getUI(context),
    );
  }
}
