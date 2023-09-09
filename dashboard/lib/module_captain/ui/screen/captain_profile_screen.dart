import 'dart:async';

import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_captain/request/captain_finance_request.dart';
import 'package:c4d/module_captain/request/enable_captain.dart';
import 'package:c4d/module_captain/request/update_captain_request.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/state_manager/captain_profile_state_manager.dart';

class CaptainProfileScreen extends StatefulWidget {
  CaptainProfileScreen();

  @override
  CaptainProfileScreenState createState() => CaptainProfileScreenState();
}

class CaptainProfileScreenState extends State<CaptainProfileScreen> {
  late States currentState;
  late CaptainProfileStateManager _stateManager;
  late StreamSubscription _stateSubscription;
  late StreamSubscription _global;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    _global = getIt<GlobalStateManager>().stateStream.listen((event) {
      getCaptain();
    });
    super.initState();
  }

  void getCaptain() {
    _stateManager.getCaptainProfile(this, captainProfileId);
  }

  void enableCaptain(String status) {
    _stateManager.acceptCaptainProfile(this, captainProfileId,
        EnableCaptainRequest(id: captainProfileId, status: status), false);
  }

  void enableCaptainFinance(CaptainFinanceRequest request) {
    _stateManager.captainFinanceStatusPlan(this, captainProfileId, request);
  }

  void updateCaptainProfile(UpdateCaptainRequest request) {
    request.id = captainProfileId;
    _stateManager.updateCaptainProfile(this, request);
  }

  CaptainProfileStateManager get stateManager => _stateManager;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void changeCaptainFinancePlan(int financeId, int captainFinancialSystemId) {
    CaptainFinanceRequest request = CaptainFinanceRequest(
      id: financeId,
      status: true,
      planType: captainFinancialSystemId,
      planId: 0,
    );
    _stateManager.changeCaptainFinancePlan(this, request, captainProfileId);
  }

  int captainProfileId = -1;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (captainProfileId == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        captainProfileId = arg;
        _stateManager.getCaptainProfile(this, captainProfileId);
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.profile,
      ),
      body: currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _global.cancel();
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }
}
