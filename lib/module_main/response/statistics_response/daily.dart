class Daily {
  String? date;
  int? count;

  Daily({this.date, this.count});

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        date: json['date'] as String?,
        count: json['count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'count': count,
      };
}
