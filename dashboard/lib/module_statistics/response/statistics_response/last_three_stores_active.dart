import 'created_at.dart';
import 'images.dart';

class LastThreeStoresActive {
  int? id;
  String? storeOwnerName;
  Images? images;
  CreatedAt? createdAt;

  LastThreeStoresActive({
    this.id,
    this.storeOwnerName,
    this.images,
    this.createdAt,
  });

  factory LastThreeStoresActive.fromJson(Map<String, dynamic> json) {
    return LastThreeStoresActive(
      id: json['id'] as int?,
      storeOwnerName: json['storeOwnerName'] as String?,
      images:
          json['images'] == null ? null : Images.fromJson(json['images'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeOwnerName': storeOwnerName,
        'images': images?.toJson(),
        'createdAt': createdAt?.toJson(),
      };
}
