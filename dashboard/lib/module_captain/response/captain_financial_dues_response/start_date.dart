import 'timezone.dart';

class StartDate {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  StartDate({this.timezone, this.offset, this.timestamp});

  factory StartDate.fromJson(Map<String, dynamic> json) => StartDate(
        timezone: json['timezone'] == null
            ? null
            : Timezone.fromJson(json['timezone'] as Map<String, dynamic>),
        offset: json['offset'] as int?,
        timestamp: json['timestamp'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'timezone': timezone?.toJson(),
        'offset': offset,
        'timestamp': timestamp,
      };
}
