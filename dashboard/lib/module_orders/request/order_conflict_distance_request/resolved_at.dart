import 'timezone.dart';

class ResolvedAt {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  ResolvedAt({this.timezone, this.offset, this.timestamp});

  factory ResolvedAt.fromJson(Map<String, dynamic> json) => ResolvedAt(
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
