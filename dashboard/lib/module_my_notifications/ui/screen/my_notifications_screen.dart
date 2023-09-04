import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_my_notifications/state_manager/my_notifications_state_manager.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';

class MyNotificationsScreen extends StatefulWidget {
  MyNotificationsScreen();

  @override
  MyNotificationsScreenState createState() => MyNotificationsScreenState();
}

class MyNotificationsScreenState extends State<MyNotificationsScreen> {
  late States currentState;
  late MyNotificationsStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  bool markerMode = false;
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNotifications() async {
    _stateManager.getNotifications(this);
  }

  void deleteNotification(String id) {
    _stateManager.deleteNotification(this, id);
  }

  void deleteNotifications(List<String> notification) {
    _stateManager.deleteNotifications(this, notification);
  }

  void goToLogin() {
    Navigator.of(context)
        .pushNamed(AuthorizationRoutes.LOGIN_SCREEN, arguments: 3);
  }

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _stateManager.getNotifications(this);
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
