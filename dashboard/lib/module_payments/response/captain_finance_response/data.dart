import 'package:c4d/utils/helpers/date_converter.dart';

class Data {
  int? id;
  num? amount;
  DateTime? startDate;
  num? amountForStore;
  num? finalAmount;
  num? state;
  num? lastPaymentId;
  num? lastPaymentAmount;
  DateTime? lastPaymentDate;

  Data({
    this.id,
    this.amount,
    this.startDate,
    this.amountForStore,
    this.finalAmount,
    this.state,
    this.lastPaymentId,
    this.lastPaymentAmount,
    this.lastPaymentDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        amount: json['amount'] as num?,
        startDate: json['startDate'] == null
            ? null
            : DateHelper.convert(json['startDate']['timestamp'] as int?),
        amountForStore: json['amountForStore'] as num?,
        finalAmount: json['finalAmount'] as num?,
        state: json['state'] as num?,
        lastPaymentId: json['lastPaymentId'] as num?,
        lastPaymentAmount: json['lastPaymentAmount'] as num?,
        lastPaymentDate: json['lastPaymentDate'] == null
            ? null
            : DateHelper.convert(json['lastPaymentDate']['timestamp'] as int?),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'startDate': startDate?.toIso8601String(),
        'amountForStore': amountForStore,
        'finalAmount': finalAmount,
        'state': state,
        'lastPaymentId': lastPaymentId,
        'lastPaymentAmount': lastPaymentAmount,
        'lastPaymentDate': lastPaymentDate?.toIso8601String(),
      };
}
