import 'package:injectable/injectable.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

import 'chat_routes.dart';
import 'ui/screens/chat_page/chat_page.dart';

@injectable
class Chat2Module extends YesModule {
  final Chat2Page _chatPage;
  final AuthService _authService;

  Chat2Module(this._chatPage, this._authService) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {Chat2Routes.chat2Route: (context) => _chatPage};
  }
}
