class CreateOrderRequest {
  int? fromBranch;
  String? note;
  String? payment;
  String? recipientName;
  String? recipientPhone;
  String? date;
  GeoJson? destination;
  num? orderCost;
  String? detail;
  String? image;
  CreateOrderRequest(
      {this.fromBranch,
      this.note,
      this.payment,
      this.recipientName,
      this.recipientPhone,
      this.date,
      this.destination,
      this.orderCost,
      this.image,
      this.detail});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch'] = this.fromBranch;
    if (this.destination != null) {
      data['destination'] = this.destination?.toJson();
    }
    data['note'] = this.note;
    data['payment'] = this.payment;
    data['recipientName'] = this.recipientName;
    data['recipientPhone'] = this.recipientPhone;
    data['deliveryDate'] = this.date;
    data['images'] = this.image;
    data['orderCost'] = this.orderCost;
    data['detail'] = this.detail ?? '';

    return data;
  }
}

class GeoJson {
  double? lat;
  double? lon;
  String? link;
  GeoJson({this.lat, this.lon, this.link});

  GeoJson.fromJson(dynamic data) {
    var json = <String, dynamic>{};
    if (data == null) {
      return;
    }
    if (data is List) {
      if (data.isEmpty) {
        return;
      }
      if (data.last is Map) {
        json = data.last;
      }
    }
    if (data != null) {
      if (data is Map<String, dynamic>) {
        json.addAll(data);
        lat = double.tryParse(json['lat'].toString());
        lon = double.tryParse(json['lon'].toString());
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['link'] = this.link;
    return data;
  }
}
