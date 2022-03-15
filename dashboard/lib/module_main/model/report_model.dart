import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_main/response/report_response.dart';

class ReportModel extends DataModel {
  int activeStoresCount = 0;
  int inactiveStoresCount = 0;
  int ongoingOrdersCount = 0;
  int allOrdersCount = 0;

  ReportModel(
      {required this.allOrdersCount,
      required this.activeStoresCount,
      required this.ongoingOrdersCount,
      required this.inactiveStoresCount,});

  ReportModel.withData(Data data) : super.withData() {
    activeStoresCount = data.activeStoresCount ?? 0;
    inactiveStoresCount = data.inactiveStoresCount ?? 0;
    ongoingOrdersCount = data.countOngoingOrders ?? 0;
    allOrdersCount = data.allOrdersCount ?? 0;
  }
}
