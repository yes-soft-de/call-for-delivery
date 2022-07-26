import 'last_three_active.dart';

class CountCaptains {
  int? active;
  int? inactive;
  List<LastThreeActive>? lastThreeActive;

  CountCaptains({this.active, this.inactive, this.lastThreeActive});

  factory CountCaptains.fromJson(Map<String, dynamic> json) => CountCaptains(
        active: json['active'] as int?,
        inactive: json['inactive'] as int?,
        lastThreeActive: (json['lastThreeActive'] as List<dynamic>?)
            ?.map((e) => LastThreeActive.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'inactive': inactive,
        'lastThreeActive': lastThreeActive?.map((e) => e.toJson()).toList(),
      };
}
