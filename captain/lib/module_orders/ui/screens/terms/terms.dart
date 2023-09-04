import 'dart:async';

import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_orders/state_manager/terms/terms_state_manager.dart';
import 'package:c4d/module_orders/ui/state/terms/terms_state.dart';
import 'package:flutter/material.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen();

  @override
  TermsScreenState createState() => TermsScreenState();
}

class TermsScreenState extends State<TermsScreen> {
  late TermsListState currentState;
  late TermsStateManager _stateManager;
  late StreamSubscription _streamSubscription;

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _stateManager = getIt();
    _streamSubscription = _stateManager.termsStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    _stateManager.getTerms(this);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currentState.getUI(context),
      ),
    );
  }
}
