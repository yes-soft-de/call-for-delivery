import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_chat/model/chat/chat_model.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_chat/repository/chat/chat_repository.dart';

@injectable
class ChatManager {
  final ChatRepository _chatRepository;

  ChatManager(this._chatRepository);

  Stream<QuerySnapshot> getMessages(String chatRoomID) {
    return _chatRepository.requestMessages(chatRoomID);
  }

  void sendMessage(String chatRoomID, ChatModel chatMessage) {
    _chatRepository.sendMessage(chatRoomID, chatMessage);
  }

  void sendNotification(ChatArgument chatArgument) {
    _chatRepository.sendNotification(chatArgument);
  }

  void needSupport() {
    //  _chatRepository.needSupport();
  }
}
