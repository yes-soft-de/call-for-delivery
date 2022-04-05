import 'created_at.dart';

class OrderCaptainNotArrivedData {
  int? id;
  String? storeOwnerName;
  String? branchName;
  String? captainName;
  CreatedAt? createdAt;
  OrderCaptainNotArrivedData(
      {this.id,
      this.createdAt,
      this.branchName,
        this.storeOwnerName,this.captainName
});

  factory OrderCaptainNotArrivedData.fromJson(Map<String, dynamic> json) => OrderCaptainNotArrivedData(
      id: json['id'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      branchName: json['branchName'] as String?,
    storeOwnerName: json['storeOwnerName'] as String?,
    captainName: json['captainName'] as String?,
  );

}
