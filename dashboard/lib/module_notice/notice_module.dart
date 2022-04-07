import 'package:c4d/module_notice/notice_routes.dart';
import 'package:c4d/module_notice/ui/screen/notice_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

@injectable
class NoticeModule extends YesModule {
  final NoticeScreen noticeScreen;
  NoticeModule(
    this.noticeScreen,
  ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      NoticeRoutes.NOTICE: (context) => noticeScreen,
    };
  }
}
