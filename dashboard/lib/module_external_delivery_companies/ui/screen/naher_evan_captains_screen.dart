import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_external_delivery_companies/state_manager/naher_evan_captains_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class NaherEvanCaptainsScreen extends StatefulWidget {
  const NaherEvanCaptainsScreen();

  @override
  State<NaherEvanCaptainsScreen> createState() =>
      NaherEvanCaptainsScreenState();
}

class NaherEvanCaptainsScreenState extends State<NaherEvanCaptainsScreen> {
  late States currentState;
  late NaherEvanCaptainsStateManger _stateManager;
  late StreamSubscription _stateSubscription;

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
    getNaherEvanCaptains();
  }

  Future<void> getNaherEvanCaptains() async {
    _stateManager.getNaherEvanCaptains(this);
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

  @override
  Widget build(BuildContext context) {
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
          title: S.current.naherEvanCaptains,
          icon: Icons.menu,
          onTap: () {
            GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
          },
        ),
        body: Center(child: currentState.getUI(context)),
      ),
    );
  }
}
