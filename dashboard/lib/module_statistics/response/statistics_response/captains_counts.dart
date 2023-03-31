
import 'last_three_captains_active.dart';

class CaptainsCounts {
	int? active;
	int? inactive;
	List<LastThreeCaptainsActive>? lastThreeActive;

	CaptainsCounts({this.active, this.inactive, this.lastThreeActive});

	factory CaptainsCounts.fromJson(Map<String, dynamic> json) => CaptainsCounts(
				active: json['active'] as int?,
				inactive: json['inactive'] as int?,
				lastThreeActive: (json['lastThreeActive'] as List<dynamic>?)
						?.map((e) => LastThreeCaptainsActive.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'active': active,
				'inactive': inactive,
				'lastThreeActive': lastThreeActive?.map((e) => e.toJson()).toList(),
			};
}
