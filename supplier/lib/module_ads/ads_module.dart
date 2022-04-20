import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_ads/ads_routes.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AdsModule extends YesModule {

  AdsModule() {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
    };
  }
}
