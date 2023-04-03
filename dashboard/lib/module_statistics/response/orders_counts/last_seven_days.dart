import 'daily.dart';

class LastSevenDays {
  List<Daily>? daily;
  int? sum;
  int? minDeliveredCountPerDay;
  int? maxDeliveredCountPerDay;
  String? minDeliveredCountDayDate;
  String? maxDeliveredCountDayDate;

  LastSevenDays({
    this.daily,
    this.sum,
    this.minDeliveredCountPerDay,
    this.maxDeliveredCountPerDay,
    this.minDeliveredCountDayDate,
    this.maxDeliveredCountDayDate,
  });

  factory LastSevenDays.fromJson(Map<String, dynamic> json) => LastSevenDays(
        daily: (json['daily'] as List<dynamic>?)
            ?.map((e) => Daily.fromJson(e as Map<String, dynamic>))
            .toList(),
        sum: json['sum'] as int?,
        minDeliveredCountPerDay: json['minDeliveredCountPerDay'] as int?,
        maxDeliveredCountPerDay: json['maxDeliveredCountPerDay'] as int?,
        minDeliveredCountDayDate: json['minDeliveredCountDayDate'] as String?,
        maxDeliveredCountDayDate: json['maxDeliveredCountDayDate'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'daily': daily?.map((e) => e.toJson()).toList(),
        'sum': sum,
        'minDeliveredCountPerDay': minDeliveredCountPerDay,
        'maxDeliveredCountPerDay': maxDeliveredCountPerDay,
        'minDeliveredCountDayDate': minDeliveredCountDayDate,
        'maxDeliveredCountDayDate': maxDeliveredCountDayDate,
      };
}
