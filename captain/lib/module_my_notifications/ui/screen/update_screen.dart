import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_my_notifications/state_manager/update_state_manager.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen();

  @override
  UpdateScreenState createState() => UpdateScreenState();
}

class UpdateScreenState extends State<UpdateScreen> {
  late States currentState;
  late UpdatesStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _stateManager.getUpdates(this);
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  bool markerMode = false;
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNotices() async {
    _stateManager.getUpdates(this);
  }

  void deleteNotification(String id) {
    // _stateManager.deleteNotification(this, id);
  }

  void deleteNotifications(List<String> notification) {
    //   _stateManager.deleteNotifications(this, notification);
  }

  void goToLogin() {
    Navigator.of(context)
        .pushNamed(AuthorizationRoutes.LOGIN_SCREEN, arguments: 3);
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
        body: FixedContainer(child: currentState.getUI(context)),
      ),
    );
  }
}
