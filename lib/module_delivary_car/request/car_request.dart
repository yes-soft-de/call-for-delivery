class CarRequest {
  int? carId;
  int? id;
  String? carModel;
  String? details;
  num? deliveryCost;

  CarRequest({this.id, this.carModel, this.details, this.deliveryCost});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['carModel'] = carModel;
    map['details'] = details;
    map['deliveryCost'] = deliveryCost;
    return map;
  }
}
