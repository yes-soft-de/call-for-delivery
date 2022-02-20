import 'dart:async';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_subscription/state_manager/init_subscription_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class InitSubscriptionScreen extends StatefulWidget {
  final InitSubscriptionStateManager _stateManager;

  InitSubscriptionScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => InitSubscriptionScreenState();
}

class InitSubscriptionScreenState extends State<InitSubscriptionScreen> {
  late StreamSubscription _streamSubscription;
  States? currentState;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void moveToInitBranch() {
    // navigator
  }

  @override
  void initState() {
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.getPackages(this);
    super.initState();
  }

  void subscribeToPackage(int packageId) {
    widget._stateManager
        .subscribePackage(this, packageId);
  }

  void getPackages() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: currentState == null ? SizedBox() : currentState?.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
