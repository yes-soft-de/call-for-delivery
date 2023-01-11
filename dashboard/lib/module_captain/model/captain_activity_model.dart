import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/response/captain_activity_response/captain_activity_response.dart';

class CaptainActivityModel extends DataModel {
  late int id;
  late int captainID;
  late String captainName;
  late String ordersCount;
  late String image;
  String? last24CountOrder;
  String? todayCountOrder;
  List<CaptainActivityModel> _data = [];
  CaptainActivityModel({
    required this.captainID,
    required this.id,
    required this.captainName,
    required this.ordersCount,
    required this.image,
    required this.last24CountOrder,
    required this.todayCountOrder,
  });
  CaptainActivityModel.withData(CaptainActivityResponse response) {
    var datum = response.data;
    datum?.forEach((element) {
      _data.add(CaptainActivityModel(
        id: element.id ?? -1,
        captainName: element.captainName ?? S.current.unknown,
        image: element.image?.image ?? '',
        ordersCount: element.ordersCount ?? '0',
        captainID: element.captainId ?? -1,
        last24CountOrder: element.lastTwentyFourOrdersCount,
        todayCountOrder: element.todayOrdersCount,
      ));
    });
  }
  List<CaptainActivityModel> get data => _data;
}
