import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_captain/response/captain_order_control_response/captain_order_control_response.dart';

class CaptainOrderModel extends DataModel {
  int countOngoingOrders = 0;
  String captainName = '';
  String image = '';
  String id = '';
  late String captainID;
  bool chosen = false;
  List<CaptainOrderModel> _model = [];

  CaptainOrderModel(
      {required this.countOngoingOrders,
      required this.image,
      required this.captainName,
      required this.id,
      required this.captainID,
      this.chosen = false});

  CaptainOrderModel.withData(CaptainOrderControlResponse response)
      : super.withData() {
    _model = [];
    var data = response.data ?? [];
    for (var element in data) {
      _model.add(CaptainOrderModel(
          countOngoingOrders: element.countOngoingOrders ?? -1,
          image: element.images?.image ?? '',
          captainName: element.captainName ?? '',
          id: element.id?.toString() ?? '',
          captainID: element.captainId?.toString() ?? '0',
          chosen: false));
    }
  }
  List<CaptainOrderModel> get data => _model;
}
