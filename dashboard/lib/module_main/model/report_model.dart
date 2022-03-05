import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_main/response/report_response.dart';

class ReportModel extends DataModel {
  int countCompletedOrders = 0;
  int countOngoingOrders = 0;
  int countCaptains = 0;
  int countStores = 0;
  int countOrdersInToday = 0;

  ReportModel(
      {required this.countCompletedOrders,
      required this.countOngoingOrders,
      required this.countCaptains,
      required this.countStores,});

  ReportModel.withData(Data data) : super.withData() {
    countCompletedOrders = int.parse(data.countCompletedOrders ?? '0');
    countOngoingOrders = int.parse(data.countOngoingOrders ?? '0');
    countCaptains = int.parse(data.countCaptains ?? '0');
    countStores = int.parse(data.countStores ?? '0');
    countOrdersInToday = int.parse(data.countOrdersInToday ?? '0');
  }
}
