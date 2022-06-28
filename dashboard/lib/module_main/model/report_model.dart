import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_main/response/report_response.dart';

class ReportModel extends DataModel {
  int activeStoresCount = 0;
  int inactiveStoresCount = 0;
  int ongoingOrdersCount = 0;
  int allOrdersCount = 0;

  int pendingOrdersCount = 0;
  int todayDeliveredOrdersCount = 0;
  int previousWeekDeliveredOrdersCount = 0;
  int activeCaptainsCount = 0;
  int inactiveCaptainsCount = 0;

  ReportModel({
    required this.allOrdersCount,
    required this.activeStoresCount,
    required this.ongoingOrdersCount,
    required this.inactiveStoresCount,
    required this.activeCaptainsCount,
    required this.inactiveCaptainsCount,
    required this.pendingOrdersCount,
    required this.previousWeekDeliveredOrdersCount,
    required this.todayDeliveredOrdersCount,
  });

  ReportModel.withData(Data data) : super.withData() {
    activeStoresCount = data.activeStoresCount ?? 0;
    inactiveStoresCount = data.inactiveStoresCount ?? 0;
    ongoingOrdersCount = data.countOngoingOrders ?? 0;
    allOrdersCount = data.allOrdersCount ?? 0;

    inactiveCaptainsCount = data.inactiveCaptainsCount ?? 0;
    activeCaptainsCount = data.activeCaptainsCount ?? 0;
    previousWeekDeliveredOrdersCount = data.previousWeekDeliveredOrdersCount ?? 0;
    todayDeliveredOrdersCount = data.todayDeliveredOrdersCount ?? 0;
    pendingOrdersCount = data.pendingOrdersCount ?? 0;

  }
}
