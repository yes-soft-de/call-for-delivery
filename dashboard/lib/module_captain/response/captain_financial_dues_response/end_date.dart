import 'timezone.dart';

class EndDate {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  EndDate({this.timezone, this.offset, this.timestamp});

  factory EndDate.fromJson(Map<String, dynamic> json) => EndDate(
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
