import 'created_at.dart';
import 'images.dart';

class LastThreeActiveCaptain {
  int? id;
  String? captainName;
  CreatedAt? createdAt;
  Images? images;

  LastThreeActiveCaptain({
    this.id,
    this.captainName,
    this.createdAt,
    this.images,
  });

  factory LastThreeActiveCaptain.fromJson(Map<String, dynamic> json) {
    return LastThreeActiveCaptain(
      id: json['id'] as int?,
      captainName: json['captainName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      images: json['images'] == null
          ? null
          : Images.fromJson(json['images'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'captainName': captainName,
        'createdAt': createdAt?.toJson(),
        'images': images?.toJson(),
      };
}
