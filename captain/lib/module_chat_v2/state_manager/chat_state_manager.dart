import 'package:c4d/module_chat_v2/model/chat/chat_model.dart';
import 'package:c4d/module_chat_v2/model/chat_argument.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../service/chat/char_service.dart';

@injectable
class Chat2StateManager {
  bool tryToGettingMessages = true;
  final Chat2Service _chatService;

  Chat2StateManager(
    this._chatService,
  );

  final PublishSubject<List<ChatModel>> _chatBlocSubject = PublishSubject();

  Stream<List<ChatModel>> get chatBlocStream => _chatBlocSubject.stream;

  // We Should get the UUID of the ChatRoom, as such we should request the data here
  void getMessages(String chatRoomID) {
    _chatService.chatMessagesStream.listen((event) {
      tryToGettingMessages = false;
      if (event.isEmpty) {
        _chatBlocSubject.add(event);
      } else {
        _chatBlocSubject.add(event);
      }
    });
    _chatService.requestMessages(chatRoomID);
  }

  void sendMessage(String chatRoomID, String chat, String username,
      int millisecond, ChatArgument chatArgument, String id,int messageType) {
    _chatService.sendMessage(chatRoomID, chat, username, millisecond, id,messageType);
    _chatService.sendNotification(chatArgument);
  }
}
