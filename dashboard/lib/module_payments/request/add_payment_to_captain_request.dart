// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum CaptainPaymentType {
  cash,
  bankTransfer;

  int get backendValue {
    switch (this) {
      case CaptainPaymentType.cash:
        return 0;
      case CaptainPaymentType.bankTransfer:
        return 1;
    }
  }
}

class AddPaymentToCaptainRequest {
  int captainId;
  num amount;
  String? note;
  CaptainPaymentType type;

  AddPaymentToCaptainRequest({
    required this.captainId,
    required this.amount,
    this.note,
    required this.type,
  });

  AddPaymentToCaptainRequest copyWith({
    int? captainId,
    num? amount,
    String? note,
    CaptainPaymentType? type,
  }) {
    return AddPaymentToCaptainRequest(
      captainId: captainId ?? this.captainId,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'captainId': captainId,
      'amount': amount,
      'note': note,
      'type': type.backendValue,
    };
  }

  String toJson() => json.encode(toMap());
}
