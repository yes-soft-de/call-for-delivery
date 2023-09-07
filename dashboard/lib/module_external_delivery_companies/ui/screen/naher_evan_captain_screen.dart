import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_external_delivery_companies/request/naher_evan_captain_request/naher_evan_captain_request.dart';
import 'package:c4d/module_external_delivery_companies/state_manager/naher_evan_captain_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class NaherEvanCaptainScreen extends StatefulWidget {
  const NaherEvanCaptainScreen();

  @override
  State<NaherEvanCaptainScreen> createState() => NaherEvanCaptainScreenState();
}

class NaherEvanCaptainScreenState extends State<NaherEvanCaptainScreen> {
  late States currentState;
  late NaherEvanCaptainStateManger _stateManager;
  late StreamSubscription _stateSubscription;

  late NaherEvanCaptainRequest filter;

  late String captainName;

  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this);

    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<void> getNaherEvanCaptain() async {
    _stateManager.getNaherEvanCaptain(this, filter);
  }

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is List) {
        if (arg.length == 2 && arg[0] is int && arg[1] is String) {
          filter = NaherEvanCaptainRequest(captainProfileId: arg[0]);
          captainName = arg[1];
        }
        getNaherEvanCaptain();
      }
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(
          context,
          title: captainName,
        ),
        body: Center(child: currentState.getUI(context)),
      ),
    );
  }
}
