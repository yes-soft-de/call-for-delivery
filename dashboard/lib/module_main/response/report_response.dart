import 'package:c4d/utils/logger/logger.dart';

class ReportResponse {
  String? statusCode;
  String? msg;
  Data? data;

  ReportResponse({this.statusCode, this.msg, this.data});

  ReportResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      statusCode = '-1';
      Logger().error('Report Response', e.toString(), StackTrace.current);
    }
  }
}

class Data {
  int? countOngoingOrders;
  int? inactiveStoresCount;
  int? activeStoresCount;
  int? allOrdersCount;

  int? pendingOrdersCount;
  int? todayDeliveredOrdersCount;
  int? previousWeekDeliveredOrdersCount;
  int? activeCaptainsCount;
  int? inactiveCaptainsCount;

  Data(
      {this.countOngoingOrders,
      this.inactiveStoresCount,
      this.activeStoresCount,
      this.allOrdersCount,
      this.activeCaptainsCount,
      this.inactiveCaptainsCount,
      this.pendingOrdersCount,
      this.previousWeekDeliveredOrdersCount,
      this.todayDeliveredOrdersCount});

  Data.fromJson(dynamic json) {
    countOngoingOrders = json['ongoingOrdersCount'];
    inactiveStoresCount = json['inactiveStoresCount'];
    activeStoresCount = json['activeStoresCount'];
    allOrdersCount = json['allOrdersCount'];

    inactiveCaptainsCount = json['inactiveCaptainsCount'];
    activeCaptainsCount = json['activeCaptainsCount'];
    previousWeekDeliveredOrdersCount = json['previousWeekDeliveredOrdersCount'];
    todayDeliveredOrdersCount = json['todayDeliveredOrdersCount'];
    pendingOrdersCount = json['pendingOrdersCount'];
  }
}
