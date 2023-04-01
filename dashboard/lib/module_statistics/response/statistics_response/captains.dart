import 'captains_counts.dart';

class Captains {
  CaptainsCounts? count;

  Captains({this.count});

  factory Captains.fromJson(Map<String, dynamic> json) => Captains(
        count: json['count'] == null
            ? null
            : CaptainsCounts.fromJson(json['count'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'counts': count?.toJson(),
      };
}
