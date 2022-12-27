import 'package:c4d/module_orders/response/orders_cash_finances_for_captain_response/payment_cash_response/finished_payment.dart';
import 'detail.dart';
import 'total.dart';

class Data {
  List<Detail>? detail;
  Total? total;
  List<FinishedPayment>? payments;

  Data({this.detail, this.total, required this.payments});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        detail: (json['detail'] as List<dynamic>?)
            ?.map((e) => Detail.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] == null
            ? null
            : Total.fromJson(json['total'] as Map<String, dynamic>),
        payments: (json['finishedPayments'] as List<dynamic>?)
            ?.map((e) => FinishedPayment.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'detail': detail?.map((e) => e.toJson()).toList(),
        'total': total?.toJson(),
      };
}
