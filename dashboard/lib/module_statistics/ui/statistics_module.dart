import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_statistics/ui/screen/statistics_screen.dart';
import 'package:c4d/module_statistics/ui/statistics_route.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class StatisticsModule extends YesModule {

  StatisticsModule() {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      StatisticsRoutes.STATISTICS_SCREEN: (context) => StatisticsScreen(),
    };
  }
}
