import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:c4d/module_chat/model/chat/chat_model.dart';

@injectable
class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ApiClient _apiClient;
  final AuthService _authService;
  ChatRepository(this._apiClient, this._authService);
  Stream<QuerySnapshot> requestMessages(String chatRoomID) {
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('sentDate', descending: false)
        .snapshots(includeMetadataChanges: false);
  }

  void sendMessage(String chatRoomID, ChatModel chatMessage) {
    _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(chatMessage.toJson());
  }

  Future<void> sendNotification(ChatArgument chatArgument) async {
    var token = await _authService.getToken();
    if (token != null) {
      if (chatArgument.guest) {
        await _apiClient.post(
          Urls.NOTIFICATIONNEWCHAT_ANYN_API,
          chatArgument.userID == null
              ? {'anonymousChatID': ''}
              : {'anonymousChatID': chatArgument.userID},
          headers: {'Authorization': 'Bearer ' + '$token'},
        );
      } else {
        await _apiClient.post(
          Urls.NOTIFICATIONNEWCHAT_API,
          chatArgument.userID == null
              ? {'otherUserID': '', 'roomId': chatArgument.roomID}
              : {
                  'otherUserID': chatArgument.userID,
                  'roomId': chatArgument.roomID
                },
          headers: {'Authorization': 'Bearer ' + '$token'},
        );
      }
    }
  }

  // Future<void> needSupport() async {
  //   if (_authService.isLoggedIn == false) {
  //     await _apiClient.post(
  //       Urls.NEEDFORSUPPORT_ANYNAMOUS,
  //       {
  //         'needSupport': true,
  //         'name': '${_authService.username}',
  //         'roomID': '${getIt<FavoriteHiveHelper>().getRoomID()}',
  //       },
  //     );
  //     return;
  //   }
  //   var token = await _authService.getToken();
  //   await _apiClient.put(
  //     Urls.NEEDFORSUPPORT,
  //     {"needSupport": true},
  //     headers: {'Authorization': 'Bearer ' + token!},
  //   );
  // }
}
