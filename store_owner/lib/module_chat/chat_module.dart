import 'package:c4d/module_chat/ui/screens/chat_rooms_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/module/yes_module.dart';

import 'chat_routes.dart';
import 'ui/screens/chat_page/chat_page.dart';

@injectable
class ChatModule extends YesModule {
  final ChatPage _chatPage;
  final OrderChatRoomsScreen _chatRoomsScreen;

  ChatModule(this._chatPage, this._chatRoomsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      ChatRoutes.chatRoute: (context) => _chatPage,
      ChatRoutes.roomChatList: (context) => _chatRoomsScreen,
    };
  }
}
