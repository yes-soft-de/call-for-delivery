import 'package:c4d/utils/logger/logger.dart';

class OrderActionResponse {
  String? statusCode;
  String? msg;
  dynamic data;

  OrderActionResponse({this.statusCode, this.msg, this.data});

  OrderActionResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'];
    } catch (e) {
      Logger().error('Response routes', '${e.toString()}', StackTrace.current);
      statusCode = '-1';
    }
  }
}
