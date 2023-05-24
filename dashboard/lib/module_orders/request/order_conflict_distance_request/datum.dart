import 'created_at.dart';
import 'new_destination.dart';
import 'old_destination.dart';
import 'resolved_at.dart';
import 'updated_at.dart';

class Datum {
  int? id;
  int? orderId;
  CreatedAt? createdAt;
  UpdatedAt? updatedAt;
  int? conflictResolvedBy;
  int? conflictResolvedByUserType;
  ResolvedAt? resolvedAt;
  bool? isResolved;
  String? conflictNote;
  String? adminNote;
  double? oldDistance;
  double? newDistance;
  OldDestination? oldDestination;
  NewDestination? newDestination;
  String? proposedDestinationOrDistance;
  int? resolveType;
  String? captainName;
  int? captainProfileId;
  String? storeOwnerName;
  int? storeOwnerProfileId;

  Datum({
    this.id,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.conflictResolvedBy,
    this.conflictResolvedByUserType,
    this.resolvedAt,
    this.isResolved,
    this.conflictNote,
    this.adminNote,
    this.oldDistance,
    this.newDistance,
    this.oldDestination,
    this.newDestination,
    this.proposedDestinationOrDistance,
    this.resolveType,
    this.captainName,
    this.captainProfileId,
    this.storeOwnerName,
    this.storeOwnerProfileId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        orderId: json['orderId'] as int?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        updatedAt: json['updatedAt'] == null
            ? null
            : UpdatedAt.fromJson(json['updatedAt'] as Map<String, dynamic>),
        conflictResolvedBy: json['conflictResolvedBy'] as int?,
        conflictResolvedByUserType: json['conflictResolvedByUserType'] as int?,
        resolvedAt: json['resolvedAt'] == null
            ? null
            : ResolvedAt.fromJson(json['resolvedAt'] as Map<String, dynamic>),
        isResolved: json['isResolved'] as bool?,
        conflictNote: json['conflictNote'] as String?,
        adminNote: json['adminNote'] as String?,
        oldDistance: (json['oldDistance'] as num?)?.toDouble(),
        newDistance: (json['newDistance'] as num?)?.toDouble(),
        oldDestination: json['oldDestination'] == null
            ? null
            : OldDestination.fromJson(
                json['oldDestination'] as Map<String, dynamic>),
        newDestination:
            (json['newDestination'] == null || json['newDestination'] is List)
                ? null
                : NewDestination.fromJson(
                    json['newDestination'] as Map<String, dynamic>),
        proposedDestinationOrDistance:
            json['proposedDestinationOrDistance'] as String?,
        resolveType: json['resolveType'] as int?,
        captainName: json['captainName'] as String?,
        captainProfileId: json['captainProfileId'] as int?,
        storeOwnerName: json['storeOwnerName'] as String?,
        storeOwnerProfileId: json['storeOwnerProfileId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderId': orderId,
        'createdAt': createdAt?.toJson(),
        'updatedAt': updatedAt?.toJson(),
        'conflictResolvedBy': conflictResolvedBy,
        'conflictResolvedByUserType': conflictResolvedByUserType,
        'resolvedAt': resolvedAt?.toJson(),
        'isResolved': isResolved,
        'conflictNote': conflictNote,
        'adminNote': adminNote,
        'oldDistance': oldDistance,
        'newDistance': newDistance,
        'oldDestination': oldDestination?.toJson(),
        'newDestination': newDestination?.toJson(),
        'proposedDestinationOrDistance': proposedDestinationOrDistance,
        'resolveType': resolveType,
        'captainName': captainName,
        'captainProfileId': captainProfileId,
        'storeOwnerName': storeOwnerName,
        'storeOwnerProfileId': storeOwnerProfileId,
      };
}
