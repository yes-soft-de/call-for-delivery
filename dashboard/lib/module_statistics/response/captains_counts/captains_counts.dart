import 'captain.dart';

class CaptainsCounts {
  int? active;
  int? inactive;
  List<Captain>? lastThreeActive;
  List<Captain>? lastFiveDeliveredOrdersCaptains;

  CaptainsCounts({
    this.active,
    this.inactive,
    this.lastThreeActive,
    this.lastFiveDeliveredOrdersCaptains,
  });

  factory CaptainsCounts.fromJson(Map<String, dynamic> json) {
    return CaptainsCounts(
      active: json['active'] as int?,
      inactive: json['inactive'] as int?,
      // lastThreeActive: (json['lastThreeActive'] as List<dynamic>?)
      //     ?.map((e) => Captain.fromJson(e as Map<String, dynamic>))
      //     .toList(),
      lastFiveDeliveredOrdersCaptains:
          (json['lastFiveDeliveredOrdersCaptains'] as List<dynamic>?)
              ?.map((e) => Captain.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'active': active,
        'inactive': inactive,
        'lastThreeActive': lastThreeActive?.map((e) => e.toJson()).toList(),
        'lastFiveDeliveredOrdersCaptains':
            lastFiveDeliveredOrdersCaptains?.map((e) => e.toJson()).toList(),
      };
}
