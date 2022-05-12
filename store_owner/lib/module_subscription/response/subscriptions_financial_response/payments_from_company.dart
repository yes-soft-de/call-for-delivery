import 'package:c4d/module_subscription/response/subscription_balance_response/start_date.dart';

class PaymentsFromStore {
  int? id;
  num? amount;
  StartDate? createdAt;
  String? note;

  PaymentsFromStore({this.id, this.amount, this.createdAt, this.note});

  factory PaymentsFromStore.fromJson(Map<String, dynamic> json) {
    return PaymentsFromStore(
      id: json['id'] as int?,
      amount: json['amount'] as num?,
      createdAt: json['createdAt'] == null
          ? null
          : StartDate.fromJson(json['createdAt'] as Map<String, dynamic>),
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'createdAt': createdAt?.toJson(),
        'note': note,
      };
}
