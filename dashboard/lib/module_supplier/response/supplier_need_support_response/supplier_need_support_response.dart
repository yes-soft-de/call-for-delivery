import 'datum.dart';

class SupplierNeedSupportResponse {
  String? statusCode;
  String? msg;
  List<DatumSupplier>? data;

  SupplierNeedSupportResponse({this.statusCode, this.msg, this.data});

  factory SupplierNeedSupportResponse.fromJson(Map<String, dynamic> json) {
    return SupplierNeedSupportResponse(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      data: (json['Data'] as List<dynamic>?)
          ?.map((e) => DatumSupplier.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'msg': msg,
        'Data': data?.map((e) => e.toJson()).toList(),
      };
}
