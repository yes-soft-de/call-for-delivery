import 'end_date.dart';
import 'payments_from_company.dart';
import 'start_date.dart';
import 'total.dart';

class Datum {
  int? id;
  num? status;
  num? amount;
  num? amountForStore;
  num? statusAmountForStore;
  StartDate? startDate;
  EndDate? endDate;
  List<PaymentsFromCompany>? paymentsFromCompany;
  Total? total;

  Datum({
    this.id,
    this.status,
    this.amount,
    this.amountForStore,
    this.statusAmountForStore,
    this.startDate,
    this.endDate,
    this.paymentsFromCompany,
    this.total,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        status: json['status'] as num?,
        amount: json['amount'] as num?,
        amountForStore: json['amountForStore'] as num?,
        statusAmountForStore: json['statusAmountForStore'] as num?,
        startDate: json['startDate'] == null
            ? null
            : StartDate.fromJson(json['startDate'] as Map<String, dynamic>),
        endDate: json['endDate'] == null
            ? null
            : EndDate.fromJson(json['endDate'] as Map<String, dynamic>),
        paymentsFromCompany: (json['paymentsToCaptain'] as List<dynamic>?)
            ?.map(
                (e) => PaymentsFromCompany.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] == null
            ? null
            : Total.fromJson(json['total'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'amount': amount,
        'amountForStore': amountForStore,
        'statusAmountForStore': statusAmountForStore,
        'startDate': startDate?.toJson(),
        'endDate': endDate?.toJson(),
        'paymentsToCaptain':
            paymentsFromCompany?.map((e) => e.toJson()).toList(),
        'total': total?.toJson(),
      };
}
