import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_my_notifications/state_manager/my_notifications_state_manager.dart';
import 'package:c4d/utils/components/fixed_container.dart';

@injectable
class MyNotificationsScreen extends StatefulWidget {
  final MyNotificationsStateManager _stateManager;
  MyNotificationsScreen(this._stateManager);

  @override
  MyNotificationsScreenState createState() => MyNotificationsScreenState();
}

class MyNotificationsScreenState extends State<MyNotificationsScreen> {
  late States currentState;
  bool markerMode = false;
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNotifications() async {
    widget._stateManager.getNotifications(this);
  }

  void deleteNotification(String id) {
    widget._stateManager.deleteNotification(this, id);
  }

  void deleteNotifications(List<String> notification) {
    widget._stateManager.deleteNotifications(this, notification);
  }

  void goToLogin() {
    Navigator.of(context)
        .pushNamed(AuthorizationRoutes.LOGIN_SCREEN, arguments: 3);
  }

  @override
  void initState() {
    currentState = LoadingState(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget._stateManager.getNotifications(this);
    });
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
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
