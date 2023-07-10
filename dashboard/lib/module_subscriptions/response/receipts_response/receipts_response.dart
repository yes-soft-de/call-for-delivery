import 'data.dart';

class ReceiptsResponse {
  String? statusCode;
  String? msg;
  Data? data;

  ReceiptsResponse({this.statusCode, this.msg, this.data});

  factory ReceiptsResponse.fromJson(Map<String, dynamic> json) {
    return ReceiptsResponse(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      data: json['Data'] == null
          ? null
          : Data.fromJson(json['Data'] as Map<String, dynamic>),
    );
  }
}
