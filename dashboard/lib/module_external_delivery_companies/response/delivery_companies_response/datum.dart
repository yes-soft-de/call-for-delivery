class Datum {
  int? id;
  String? companyName;
  bool? status;

  Datum({
    this.id,
    this.companyName,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        companyName: json['companyName'] as String?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'companyName': companyName,
        'status': status,
      };
}
