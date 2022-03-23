import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_orders/response/enquery_response/enquery_response.dart';

class RoomId extends DataModel {
  late int id;
  late String? roomId;
  RoomId({required this.id, required this.roomId});
  factory RoomId.withData(EnquiryResponse response) =>
      RoomId(id: response.data?.id ?? -1, roomId: response.data?.roomId);
}
