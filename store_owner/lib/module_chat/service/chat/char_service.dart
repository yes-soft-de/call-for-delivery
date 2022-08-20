import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_chat/model/chat_rooms_model.dart';
import 'package:c4d/module_chat/response/order_chat_rooms_response/order_chat_rooms_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_chat/manager/chat/chat_manager.dart';
import 'package:c4d/module_chat/model/chat/chat_model.dart';

@injectable
class ChatService {
  final ChatManager _chatManager;

  ChatService(this._chatManager);

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

  void sendMessage(String chatRoomID, String msg, String username) async {
    ChatModel model = ChatModel(
      msg: msg,
      sender: username,
      sentDate: DateTime.now().toString(),
    );
    _chatManager.sendMessage(chatRoomID, model);
  }

  void dispose() {
    _chatPublishSubject.close();
  }

  void sendNotification(ChatArgument chatArgument) {
    _chatManager.sendNotification(chatArgument);
  }

  Future<DataModel> getOrderChatRooms() async {
    OrderChatRoomsResponse? response = await _chatManager.getOrderChatRooms();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return ChatRoomsModel.withData(response);
  }

  Future<DataModel> getOngoingOrderChat() async {
    OrderChatRoomsResponse? response = await _chatManager.getOngoingOrderChat();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return ChatRoomsModel.withData(response);
  }
}
