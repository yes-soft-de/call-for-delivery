import 'count_captains.dart';

class Captains {
  CountCaptains? countCaptains;

  Captains({this.countCaptains});

  factory Captains.fromJson(Map<String, dynamic> json) => Captains(
        countCaptains: json['countCaptains'] == null
            ? null
            : CountCaptains.fromJson(
                json['countCaptains'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'countCaptains': countCaptains?.toJson(),
      };
}
