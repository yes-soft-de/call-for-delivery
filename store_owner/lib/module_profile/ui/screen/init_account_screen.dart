import 'dart:async';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_profile/state_manager/init_account.state_manager.dart';
import 'package:c4d/module_profile/ui/states/init_account_profile_loaded.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class InitAccountScreen extends StatefulWidget {
  final InitAccountStateManager _stateManager;

  InitAccountScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => InitAccountScreenState();
}

class InitAccountScreenState extends State<InitAccountScreen> {
  late StreamSubscription _streamSubscription;
  late States currentState;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void moveNext() {
    
  }

  @override
  void initState() {
    _streamSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      currentState = InitAccountStateProfileLoaded(this);
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
