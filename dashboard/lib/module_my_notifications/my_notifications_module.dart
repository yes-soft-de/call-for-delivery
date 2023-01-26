import 'package:c4d/module_my_notifications/ui/screen/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_my_notifications/my_notifications_routes.dart';
import 'package:c4d/module_my_notifications/ui/screen/my_notifications_screen.dart';

@injectable
class MyNotificationsModule extends YesModule {
  final MyNotificationsScreen _myNotificationsScreen;
  final UpdateScreen _updateScreen;

  MyNotificationsModule(this._myNotificationsScreen, this._updateScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      MyNotificationsRoutes.MY_NOTIFICATIONS: (context) =>
          _myNotificationsScreen,
      MyNotificationsRoutes.UPDATES_SCREEN: (context) => _updateScreen,
    };
  }
}
