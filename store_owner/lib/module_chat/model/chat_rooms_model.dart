import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_chat/response/order_chat_rooms_response/order_chat_rooms_response.dart';

class ChatRoomsModel extends DataModel {
  late int id;
  late String captainName;
  late int? usedAs;
  late String? images;
  late String roomId;
  late String? orderId;
  late bool marked;
  List<ChatRoomsModel> _data = [];
  ChatRoomsModel(
      {required this.id,
      required this.captainName,
      this.usedAs,
      required this.images,
      required this.roomId,
      required this.orderId,
      required this.marked});
  ChatRoomsModel.withData(OrderChatRoomsResponse response) {
    var list = response.data;
    list?.forEach((element) {
      _data.add(ChatRoomsModel(
          id: element.id ?? -1,
          captainName: element.captainName ?? S.current.unknown,
          roomId: element.roomId ?? '',
          images: element.images?.image,
          orderId: element.orderId,
          marked: false));
    });
  }

  List<ChatRoomsModel> get data => _data;
}
