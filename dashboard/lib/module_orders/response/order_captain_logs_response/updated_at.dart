import 'timezone.dart';

class UpdatedAt {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  UpdatedAt({this.timezone, this.offset, this.timestamp});

  factory UpdatedAt.fromJson(Map<String, dynamic> json) => UpdatedAt(
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
