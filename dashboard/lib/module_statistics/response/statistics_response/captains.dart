import 'package:c4d/module_statistics/response/captains_counts/captains_counts.dart';

class Captains {
  CaptainsCounts? count;

  Captains({this.count});

  factory Captains.fromJson(Map<String, dynamic> json) => Captains(
        count: json['count'] == null
            ? null
            : CaptainsCounts.fromJson(json['count'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'count': count?.toJson(),
      };
}
