import 'package:c4d/module_chat_v2/manager/chat/chat_manager.dart';
import 'package:c4d/module_chat_v2/model/chat/chat_model.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class Chat2Service {
  final Chat2Manager _chatManager;

  Chat2Service(this._chatManager);

  // This is Real Time, That is Why I went this way
  final PublishSubject<List<ChatModel>> _chatPublishSubject = PublishSubject();

  Stream<List<ChatModel>> get chatMessagesStream => _chatPublishSubject.stream;

  void requestMessages(String chatRoomID) async {
    _chatManager.getMessages(chatRoomID).listen((event) {
      List<ChatModel> chatMessagesList = [];
      event.docs.forEach((element) {
        chatMessagesList
            .add(ChatModel.fromJson(element.data() as Map<String, dynamic>));
      });

      _chatPublishSubject.add(chatMessagesList);
    });
  }

  void sendMessage(String chatRoomID, String msg, String username,
      int millisecond, String id,int messageType) async {
    ChatModel model = ChatModel(
      msg: msg,
      sender: username,
      sentDate: DateTime.fromMillisecondsSinceEpoch(millisecond).toIso8601String(),
      id: id,
      messageType: messageType
    );
    _chatManager.sendMessage(chatRoomID, model);
  }

  void dispose() {
    _chatPublishSubject.close();
  }

  void sendNotification(ChatArgument chatArgument) {
    _chatManager.sendNotification(chatArgument);
  }
}
