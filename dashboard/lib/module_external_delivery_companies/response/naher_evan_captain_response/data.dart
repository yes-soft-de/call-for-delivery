import 'log.dart';

class Data {
  List<Log>? logs;
  num? onlineHoursCount;
  num? createdOrderCount;
  num? deliveredOrderCount;

  Data({
    this.logs,
    this.onlineHoursCount,
    this.createdOrderCount,
    this.deliveredOrderCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        logs: (json['logs'] as List<dynamic>?)
            ?.map((e) => Log.fromJson(e as Map<String, dynamic>))
            .toList(),
        onlineHoursCount: json['onlineHoursCount'] as num?,
        createdOrderCount: json['createdOrderCount'] as num?,
        deliveredOrderCount: json['deliveredOrderCount'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'logs': logs?.map((e) => e.toJson()).toList(),
        'onlineHoursCount': onlineHoursCount,
        'createdOrderCount': createdOrderCount,
        'deliveredOrderCount': deliveredOrderCount,
      };
}
