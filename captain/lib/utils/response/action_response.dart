import 'package:c4d/utils/logger/logger.dart';

class ActionResponse {
  String? statusCode;
  String? msg;
  dynamic data;

  ActionResponse({this.statusCode, this.msg, this.data});

  ActionResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'];
    } catch (e) {
      Logger.error('Action Response', '${e.toString()}', StackTrace.current);
      statusCode = '-1';
    }
  }
}
