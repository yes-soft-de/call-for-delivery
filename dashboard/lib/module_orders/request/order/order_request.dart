class CreateOrderRequest {
  int? storeId;
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
  int? orderID;
  bool? orderIsMain;
  int? id;
  String? distance;
  String? pdf;
  num? deliveryCost;
  int? cancel;

  CreateOrderRequest(
      {this.id,
      this.storeId,
      this.fromBranch,
      this.note,
      this.payment,
      this.recipientName,
      this.recipientPhone,
      this.date,
      this.destination,
      this.orderCost,
      this.image,
      this.detail,
      this.orderID,
      this.orderIsMain,
      this.distance,
      this.pdf,
      required this.deliveryCost,
      this.cancel});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.storeId != null) {
      data['storeOwner'] = this.storeId;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    data['branch'] = this.fromBranch;
    if (this.destination != null) {
      data['destination'] = this.destination?.toJson();
    }
    if (this.deliveryCost != null) {
      data['deliveryCost'] = this.deliveryCost;
    }
    if (this.note != null && this.note?.isNotEmpty == true) {
      data['note'] = this.note;
    }
    if (this.cancel != null) {
      data['cancel'] = this.cancel;
    }

    data['payment'] = this.payment;
    data['recipientName'] = this.recipientName;
    data['recipientPhone'] = this.recipientPhone;
    data['deliveryDate'] = this.date;
    data['orderIsMain'] = this.orderIsMain;

    if (this.image != null) {
      data['images'] = this.image;
    }
    if (this.orderCost != null) {
      data['orderCost'] = this.orderCost;
    }
    if (this.detail != null && this.detail?.isNotEmpty == true) {
      data['detail'] = this.detail;
    }
    if (this.orderID != null) {
      data['primaryOrder'] = this.orderID;
    }
    if (distance != null) {
      data['storeBranchToClientDistance'] =
          double.tryParse(this.distance!.replaceAll(',', ''));
    }
    if (this.pdf != null) {
      data['filePdf'] = this.pdf;
    }
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
