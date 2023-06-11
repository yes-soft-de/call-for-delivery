import 'datum.dart';

class DeliveryCompanyCriteriaResponse {
	String? statusCode;
	String? msg;
	List<Datum>? data;

	DeliveryCompanyCriteriaResponse({this.statusCode, this.msg, this.data});

	factory DeliveryCompanyCriteriaResponse.fromJson(Map<String, dynamic> json) {
		return DeliveryCompanyCriteriaResponse(
			statusCode: json['status_code'] as String?,
			msg: json['msg'] as String?,
			data: (json['Data'] as List<dynamic>?)
						?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toJson() => {
				'status_code': statusCode,
				'msg': msg,
				'Data': data?.map((e) => e.toJson()).toList(),
			};
}
