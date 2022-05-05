import 'package:c4d/module_subscription/response/subscriptions_financial_response/payments_from_company.dart';
import 'end_date.dart';
import 'start_date.dart';
import 'total.dart';

class Datum {
  int? id;
  String? packageName;
  StartDate? startDate;
  EndDate? endDate;
  String? status;
  String? note;
  dynamic flag;
  List<PaymentsFromStore>? paymentsFromStore;
  Total? total;

  Datum({
    this.id,
    this.packageName,
    this.startDate,
    this.endDate,
    this.status,
    this.note,
    this.flag,
    this.paymentsFromStore,
    this.total,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        packageName: json['packageName'] as String?,
        startDate: json['startDate'] == null
            ? null
            : StartDate.fromJson(json['startDate'] as Map<String, dynamic>),
        endDate: json['endDate'] == null
            ? null
            : EndDate.fromJson(json['endDate'] as Map<String, dynamic>),
        status: json['status'] as String?,
        note: json['note'] as dynamic,
        flag: json['flag'] as dynamic,
        paymentsFromStore: (json['paymentsFromCompany'] as List<dynamic>?)
            ?.map((e) => PaymentsFromStore.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] == null
            ? null
            : Total.fromJson(json['total'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'packageName': packageName,
        'startDate': startDate?.toJson(),
        'endDate': endDate?.toJson(),
        'status': status,
        'note': note,
        'flag': flag,
        'paymentsFromStore': paymentsFromStore,
        'total': total?.toJson(),
      };
}
