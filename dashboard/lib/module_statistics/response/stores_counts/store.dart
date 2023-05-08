import '../created_at/created_at.dart';
import 'image.dart';

class Store {
  int? id;
  String? storeOwnerName;
  Image? images;
  CreatedAt? createdAt;

  Store({
    this.id,
    this.storeOwnerName,
    this.images,
    this.createdAt,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] as int?,
      storeOwnerName: json['storeOwnerName'] as String?,
      images: json['images'] == null
          ? null
          : Image.fromJson(json['images'] as Map<String, dynamic>),
      createdAt: json['orderCreatedAt'] == null
          ? null
          : CreatedAt.fromJson(json['orderCreatedAt'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeOwnerName': storeOwnerName,
        'images': images?.toJson(),
        'orderCreatedAt': createdAt?.toJson(),
      };
}
