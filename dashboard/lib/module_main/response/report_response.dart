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

  Data({
    this.countOngoingOrders,
    this.inactiveStoresCount,
    this.activeStoresCount,
    this.allOrdersCount,
  });

  Data.fromJson(dynamic json) {
    countOngoingOrders = json['ongoingOrdersCount'];
    inactiveStoresCount = json['inactiveStoresCount'];
    activeStoresCount = json['activeStoresCount'];
    allOrdersCount = json['allOrdersCount'];
  }
}
