class Datum {
  int? id;
  String? carModel;
  String? details;
  num? deliveryCost;

  Datum({this.id, this.carModel, this.deliveryCost, this.details});
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as int?,
      details: json['details'] as String?,
      carModel: json['carModel'] as String?,
      deliveryCost: json['deliveryCost'] as num?);
}
