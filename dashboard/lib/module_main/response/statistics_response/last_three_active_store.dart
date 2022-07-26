import 'created_at.dart';
import 'images.dart';

class LastThreeActiveStore {
  int? id;
  String? storeOwnerName;
  Images? images;
  CreatedAt? createdAt;

  LastThreeActiveStore({
    this.id,
    this.storeOwnerName,
    this.images,
    this.createdAt,
  });

  factory LastThreeActiveStore.fromJson(Map<String, dynamic> json) {
    return LastThreeActiveStore(
      id: json['id'] as int?,
      storeOwnerName: json['storeOwnerName'] as String?,
      images: json['images'] == null
          ? null
          : Images.fromJson(json['images'] as Map<String, dynamic>),
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
