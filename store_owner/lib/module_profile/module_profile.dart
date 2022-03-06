import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_profile/ui/screen/account_balance_screen.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/screen/init_account_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileModule {
  final ProfileScreen editProfileScreen;
  final InitAccountScreen initAccountScreen;
  final AccountBalanceScreen accountBalanceScreen;
  ProfileModule(this.editProfileScreen, this.initAccountScreen,
      this.accountBalanceScreen) {
    YesModule.RoutesMap.addAll({
      ProfileRoutes.PROFILE_SCREEN: (context) => editProfileScreen,
      ProfileRoutes.INIT_ACCOUNT: (context) => initAccountScreen,
      ProfileRoutes.ACCOUNT_BALANCE_SCREEN: (context) => accountBalanceScreen
    });
  }
}
