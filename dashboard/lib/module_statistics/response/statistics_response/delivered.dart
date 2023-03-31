import 'last_seven_days.dart';

class Delivered {
	LastSevenDays? lastSevenDays;

	Delivered({this.lastSevenDays});

	factory Delivered.fromJson(Map<String, dynamic> json) => Delivered(
				lastSevenDays: json['lastSevenDays'] == null
						? null
						: LastSevenDays.fromJson(json['lastSevenDays'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'lastSevenDays': lastSevenDays?.toJson(),
			};
}
