import 'package:c4d/module_profile/ui/screen/account_balance_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_profile/ui/screen/activity_screen/activity_screen.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';

@injectable
class ProfileModule extends YesModule {
  final ActivityScreen activityScreen;
  final EditProfileScreen editProfileScreen;
  final AccountBalanceScreen accountBalanceScreen;
  ProfileModule(
      this.activityScreen, this.editProfileScreen, this.accountBalanceScreen) {
    YesModule.RoutesMap.addAll({
      ProfileRoutes.ACTIVITY_SCREEN: (context) => activityScreen,
      ProfileRoutes.EDIT_ACTIVITY_SCREEN: (context) => editProfileScreen,
      ProfileRoutes.ACCOUNT_BALANCE_SCREEN: (context) => accountBalanceScreen,
    });
  }
}
