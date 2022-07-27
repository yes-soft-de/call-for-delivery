import 'last_three_active_captain.dart';

class CountCaptains {
  int? active;
  int? inactive;
  List<LastThreeActiveCaptain>? lastThreeActiveCaptains;

  CountCaptains({this.active, this.inactive, this.lastThreeActiveCaptains});

  factory CountCaptains.fromJson(Map<String, dynamic> json) => CountCaptains(
        active: json['active'] as int?,
        inactive: json['inactive'] as int?,
        lastThreeActiveCaptains:
            (json['lastThreeActive'] as List<dynamic>?)
                ?.map((e) =>
                    LastThreeActiveCaptain.fromJson(e as Map<String, dynamic>))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'inactive': inactive,
        'lastThreeActive':
            lastThreeActiveCaptains?.map((e) => e.toJson()).toList(),
      };
}
