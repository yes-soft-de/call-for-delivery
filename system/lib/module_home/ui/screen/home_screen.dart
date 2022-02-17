import 'dart:async';

import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_home/state_manager/check_api_state_manager.dart';
import 'package:c4d/module_home/ui/states/home_state_error.dart';
import 'package:c4d/module_home/ui/states/home_state_init.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeScreen extends StatefulWidget {
  final CheckApiStateManager _stateManager;

  HomeScreen(
      this._stateManager,
      );

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>  with SingleTickerProviderStateMixin {
  late StreamSubscription _streamSubscription;
  late States currentState;
  late AsyncSnapshot loadingSnapshot;

  final int delayedAmount = 100;
 late double scale;
late  AnimationController controller;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void checkApiHealth() {
    widget._stateManager.checkApiHealth(this);
  }

  @override
  void initState() {
    loadingSnapshot = AsyncSnapshot.nothing();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 50,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });

    currentState = HomeStateInit(this);
    _streamSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.loadingStream.listen((event) {
      if (this.mounted) {
        setState(() {
          loadingSnapshot = event;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - controller.value;
    return Scaffold(

      body: currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}