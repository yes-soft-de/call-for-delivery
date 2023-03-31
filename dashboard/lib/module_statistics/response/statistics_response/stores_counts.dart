import 'last_three_stores_active.dart';

class StoresCounts {
	int? active;
	int? inactive;
	List<LastThreeStoresActive>? lastThreeActive;

	StoresCounts({this.active, this.inactive, this.lastThreeActive});

	factory StoresCounts.fromJson(Map<String, dynamic> json) => StoresCounts(
				active: json['active'] as int?,
				inactive: json['inactive'] as int?,
				lastThreeActive: (json['lastThreeActive'] as List<dynamic>?)
						?.map((e) => LastThreeStoresActive.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'active': active,
				'inactive': inactive,
				'lastThreeActive': lastThreeActive?.map((e) => e.toJson()).toList(),
			};
}
