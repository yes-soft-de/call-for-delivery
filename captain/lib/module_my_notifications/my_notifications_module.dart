import 'package:c4d/module_my_notifications/ui/screen/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_my_notifications/my_notifications_routes.dart';
import 'package:c4d/module_my_notifications/ui/screen/my_notifications_screen.dart';

@injectable
class MyNotificationsModule extends YesModule {
  MyNotificationsModule() {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      MyNotificationsRoutes.MY_NOTIFICATIONS: (context) =>
          const MyNotificationsScreen(),
      MyNotificationsRoutes.UPDATES_SCREEN: (context) => const UpdateScreen(),
    };
  }
}
