import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_categories/categories_routes.dart';
import 'package:c4d/module_categories/ui/screen/categories_screen.dart';
import 'package:c4d/module_categories/ui/screen/packages_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesModule extends YesModule {
  CategoriesModule() {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CategoriesRoutes.PACKAGE_CATEGORIES: (context) => CategoriesScreen(),
      CategoriesRoutes.PACKAGES: (context) => PackagesScreen(),
    };
  }
}
