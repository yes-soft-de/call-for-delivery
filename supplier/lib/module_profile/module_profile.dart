import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/screen/init_account_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileModule {
  final ProfileScreen editProfileScreen;
  final InitAccountScreen initAccountScreen;
  ProfileModule(this.editProfileScreen, this.initAccountScreen) {
    YesModule.RoutesMap.addAll({
      ProfileRoutes.PROFILE_SCREEN: (context) => editProfileScreen,
      ProfileRoutes.INIT_ACCOUNT: (context) => initAccountScreen,
    });
  }
}
