import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_check_api/ui/screen/check_api_screen.dart';
import 'package:c4d/module_users/users_routes.dart';
import 'package:injectable/injectable.dart';

import 'ui/screen/users_screen.dart';

@injectable
class UsersModule extends YesModule {
  final UsersScreen usersScreen;
  UsersModule(this.usersScreen) {
    YesModule.RoutesMap.addAll({
      UsersRoutes.VIEW_ALL: (context) => usersScreen,
    });
  }
}
