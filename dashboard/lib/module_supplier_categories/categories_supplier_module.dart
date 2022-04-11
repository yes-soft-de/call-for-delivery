import 'package:c4d/module_supplier_categories/categories__supplier_routes.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'ui/screen/supplier_categories_screen.dart';

@injectable
class SupplierCategoriesModule extends YesModule {
  final SupplierCategoriesScreen categoriesScreen;

  SupplierCategoriesModule(
    this.categoriesScreen,
  ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      SupplierCategoriesRoutes.SUPPLIER_CATEGORIES: (context) => categoriesScreen,
    };
  }
}
