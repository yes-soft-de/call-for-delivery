import 'package:c4d/module_chat_v2/ui/screens/chat_page/chat_page.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

import 'chat_routes.dart';
import 'ui/screens/chat_page/chat_page.dart';

@injectable
class ChatModule extends YesModule {
  final ChatPage _chatPage;
  final Chat2Page _chat2Page;

  ChatModule(this._chatPage, this._chat2Page) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      ChatRoutes.chatRoute: (context) => _chatPage,
      ChatRoutes.chat2Route: (context) => _chat2Page,
    };
  }
}
