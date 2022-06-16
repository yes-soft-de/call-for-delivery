import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_captain/response/captain_need_support_response/datum.dart';

class CaptainNeedSupportModel extends DataModel {
  String roomID = '';
  String captainName = '';
  String image = '';
  String id = '';
  late String userId;
  List<CaptainNeedSupportModel> _model = [];

  CaptainNeedSupportModel(
      {required this.roomID,
      required this.image,
      required this.captainName,
      required this.id,
      required this.userId});

  CaptainNeedSupportModel.withData(List<Datum> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(CaptainNeedSupportModel(
        roomID: element.roomId ?? '-1',
        image: element.image?.image ?? '',
        captainName: element.captainName ?? '',
        id: element.id?.toString() ?? '',
        userId: element.userId?.toString() ?? '0',
      ));
    }
  }
  List<CaptainNeedSupportModel> get data => _model;
}
