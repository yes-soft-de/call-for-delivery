import 'created_at.dart';
import 'delivery_date.dart';

class Datum {
  int? id;
  int? bidDetailsId;
  String? state;
  String? payment;

  String? note;
  String? title;
  String? description;
  DeliveryDate? deliveryDate;
  CreatedAt? createdAt;
  int? storeOwnerBranchId;
  String? branchName;

  Datum({
    this.id,
    this.state,
    this.payment,
    this.note,
    this.deliveryDate,
    this.createdAt,
    this.storeOwnerBranchId,
    this.branchName,
    this.description,
    this.title,
    this.bidDetailsId
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        state: json['state'] as String?,
        payment: json['payment'] as String?,
        note: json['note'] as String?,
        deliveryDate: json['deliveryDate'] == null
            ? null
            : DeliveryDate.fromJson(
                json['deliveryDate'] as Map<String, dynamic>),
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        storeOwnerBranchId: json['storeOwnerBranchId'] as int?,
        branchName: json['branchName'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        bidDetailsId: json['bidDetailsId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'state': state,
        'payment': payment,
        'note': note,
        'deliveryDate': deliveryDate?.toJson(),
        'createdAt': createdAt?.toJson(),
        'storeOwnerBranchId': storeOwnerBranchId,
        'branchName': branchName,
      };
}
