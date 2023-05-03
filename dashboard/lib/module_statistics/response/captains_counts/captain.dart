import '../created_at/created_at.dart';
import 'image.dart';

class Captain {
  int? id;
  String? captainName;
  Image? images;
  CreatedAt? createdAt;

  Captain({this.id, this.captainName, this.images, this.createdAt});

  factory Captain.fromJson(Map<String, dynamic> json) {
    return Captain(
      id: json['id'] as int?,
      captainName: json['captainName'] as String?,
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
        'captainName': captainName,
        'images': images?.toJson(),
        'orderCreatedAt': createdAt?.toJson(),
      };
}
