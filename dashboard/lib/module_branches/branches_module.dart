import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_branches/branches_routes.dart';
import 'package:c4d/module_branches/ui/screens/branches_list_screen/branches_list_screen.dart';
import 'package:c4d/module_branches/ui/screens/init_branches/init_branches_screen.dart';
import 'package:c4d/module_branches/ui/screens/update_branches_screen/update_branches_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class BranchesModule extends YesModule {
  BranchesModule(
  ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      BranchesRoutes.BRANCHES_LIST_SCREEN: (context) => BranchesListScreen(),
      BranchesRoutes.UPDATE_BRANCH_SCREEN: (context) => UpdateBranchScreen(),
      BranchesRoutes.INIT_BRANCHES: (context) => InitBranchesScreen()
    };
  }
}
