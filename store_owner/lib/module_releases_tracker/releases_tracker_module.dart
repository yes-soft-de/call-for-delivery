import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReleasesTrackerModule extends YesModule {
  ReleasesTrackerModule() {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {};
  }
}
