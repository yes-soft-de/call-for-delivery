import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_branches/branches_routes.dart';
import 'package:c4d/module_branches/ui/screens/branches_list_screen/branches_list_screen.dart';
import 'package:c4d/module_branches/ui/screens/init_branches/init_branches_screen.dart';
import 'package:c4d/module_branches/ui/screens/update_branches_screen/update_branches_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class BranchesModule extends YesModule {
  final BranchesListScreen _branchesListScreen;
  final UpdateBranchScreen _updateBranchScreen;
  final InitBranchesScreen _initBranchesScreen;
  BranchesModule(this._branchesListScreen, this._updateBranchScreen,
      this._initBranchesScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      BranchesRoutes.BRANCHES_LIST_SCREEN: (context) => _branchesListScreen,
      BranchesRoutes.UPDATE_BRANCH_SCREEN: (context) => _updateBranchScreen,
      BranchesRoutes.INIT_BRANCHES: (context) => _initBranchesScreen
    };
  }
}
