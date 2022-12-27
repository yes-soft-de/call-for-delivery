class PackageRequest {
  int? id;
  int? packageCategoryID;
  String? name;
  String? note;
  String? city;
  int? expired;
  String? status;
  num? cost;
  num? carCount;
  num? orderCount;
  num? extraCost;
  num? geographicalRange;
  num? type;
  PackageRequest(
      {this.id,
      this.packageCategoryID,
      this.name,
      this.city,
      this.status,
      this.carCount,
      this.cost,
      this.expired,
      this.note,
      this.orderCount,
      this.extraCost,
      this.geographicalRange,
      this.type});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['packageCategory'] = packageCategoryID;
    map['name'] = name;
    map['note'] = note;
    map['city'] = city;
    map['expired'] = expired;
    map['status'] = status;
    map['cost'] = cost;
    map['carCount'] = carCount;
    map['extraCost'] = extraCost;
    map['type'] = type;
    map['geographicalRange'] = geographicalRange;
    map['orderCount'] = orderCount;
    return map;
  }
}
