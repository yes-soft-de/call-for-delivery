import 'package:c4d/module_chat_v2/model/chat/chat_model.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_chat_v2/repository/chat/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class Chat2Manager {
  final Chat2Repository _chatRepository;

  Chat2Manager(this._chatRepository);

  Stream<QuerySnapshot<Object?>> getMessages(String chatRoomID) {
    return _chatRepository.listenToMessages(chatRoomID);
  }
  Stream<QuerySnapshot> listenToChanges(String chatRoomID) {
    return _chatRepository.listenToMessages(chatRoomID);
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
