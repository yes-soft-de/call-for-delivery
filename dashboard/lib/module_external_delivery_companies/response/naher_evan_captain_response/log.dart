import 'package:c4d/utils/helpers/date_converter.dart';

class Log {
  int? id;
  int? captainProfileId;
  bool? isOnline;
  DateTime? createdAt;

  Log({
    this.id,
    this.captainProfileId,
    this.isOnline,
    this.createdAt,
  });

  factory Log.fromJson(Map<String, dynamic> json) => Log(
        id: json['id'] as int?,
        captainProfileId: json['captainProfileId'] as int?,
        isOnline: json['isOnline'] as bool?,
        createdAt: DateHelper.convert(json['createdAt']['timestamp'] as int?),
      );
}
