import 'created_at.dart';
import 'images.dart';

class LastThreeCaptainsActive {
	int? id;
	String? captainName;
	Images? images;
	CreatedAt? createdAt;

	LastThreeCaptainsActive({this.id, this.captainName, this.images, this.createdAt});

	factory LastThreeCaptainsActive.fromJson(Map<String, dynamic> json) {
		return LastThreeCaptainsActive(
			id: json['id'] as int?,
			captainName: json['captainName'] as String?,
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
				'captainName': captainName,
				'images': images?.toJson(),
				'createdAt': createdAt?.toJson(),
			};
}
