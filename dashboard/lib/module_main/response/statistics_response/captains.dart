import 'count_captains.dart';

class Captains {
  CountCaptains? countCaptains;

  Captains({this.countCaptains});

  factory Captains.fromJson(Map<String, dynamic> json) => Captains(
        countCaptains: json['count'] == null
            ? null
            : CountCaptains.fromJson(
                json['count'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'count': countCaptains?.toJson(),
      };
}
