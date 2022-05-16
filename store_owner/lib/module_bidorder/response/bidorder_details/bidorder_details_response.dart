import 'data.dart';

class BidOrderDetailsResponse {
  String? statusCode;
  String? msg;
  Data? data;

  BidOrderDetailsResponse({this.statusCode, this.msg, this.data});

  factory BidOrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return BidOrderDetailsResponse(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      data: json['Data'] == null
          ? null
          : Data.fromJson(json['Data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'msg': msg,
        'Data': data?.toJson(),
      };
}
