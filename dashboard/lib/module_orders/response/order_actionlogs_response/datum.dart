import 'package:c4d/module_captain/response/captain_order_control_response/images.dart';

import 'created_at.dart';

class Datum {
  int? id;
  int? type;
  int? action;
  int? state;
  CreatedAt? createdAt;
  String? createdBy;
  int? createdByUserType;
  dynamic isCaptainArrivedConfirmation;
  int? storeOwnerBranchId;
  int? storeOwnerProfileId;
  int? captainProfileId;
  dynamic supplierProfileId;
  int? isHide;
  bool? orderIsMain;
  dynamic primaryOrderId;
  Images? image;
  String? userJobDescription;

  Datum({
    this.id,
    this.type,
    this.action,
    this.state,
    this.createdAt,
    this.createdBy,
    this.createdByUserType,
    this.isCaptainArrivedConfirmation,
    this.storeOwnerBranchId,
    this.storeOwnerProfileId,
    this.captainProfileId,
    this.supplierProfileId,
    this.isHide,
    this.orderIsMain,
    this.primaryOrderId,
    this.image,
    this.userJobDescription,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        type: json['type'] as int?,
        action: json['action'] as int?,
        state: json['state'] as int?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        createdBy: json['createdBy'] as String?,
        createdByUserType: json['createdByUserType'] as int?,
        isCaptainArrivedConfirmation:
            json['isCaptainArrivedConfirmation'] as dynamic,
        storeOwnerBranchId: json['storeOwnerBranchId'] as int?,
        storeOwnerProfileId: json['storeOwnerProfileId'] as int?,
        captainProfileId: json['captainProfileId'] as int?,
        supplierProfileId: json['supplierProfileId'] as dynamic,
        isHide: json['isHide'] as int?,
        orderIsMain: json['orderIsMain'] as bool?,
        primaryOrderId: json['primaryOrderId'] as dynamic,
        image: json['images'] == null
            ? null
            : Images.fromJson(json['images'] as Map<String, dynamic>),
        userJobDescription: json['userJobDescription'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'action': action,
        'state': state,
        'createdAt': createdAt?.toJson(),
        'createdBy': createdBy,
        'createdByUserType': createdByUserType,
        'isCaptainArrivedConfirmation': isCaptainArrivedConfirmation,
        'storeOwnerBranchId': storeOwnerBranchId,
        'storeOwnerProfileId': storeOwnerProfileId,
        'captainProfileId': captainProfileId,
        'supplierProfileId': supplierProfileId,
        'isHide': isHide,
        'orderIsMain': orderIsMain,
        'primaryOrderId': primaryOrderId,
      };
}
