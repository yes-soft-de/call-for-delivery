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
  int? orderType;
  int? orderID;
  bool? orderIsMain;
  int? cancel;
  int? order;
  String? pdf;
  String? distance;
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
      this.detail,
      this.orderID,
      this.orderType,
      this.orderIsMain,
      this.order,
      this.cancel,
      this.pdf,
      this.distance});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch'] = this.fromBranch;
    if (this.destination != null) {
      data['destination'] = this.destination?.toJson();
    }
    if (this.note != null && this.note?.isNotEmpty == true) {
      data['note'] = this.note;
    }
    data['payment'] = this.payment;
    if (this.recipientName != null && this.recipientName != '') {
      data['recipientName'] = this.recipientName;
    }
    data['recipientPhone'] = this.recipientPhone;
    data['deliveryDate'] = this.date;
    if (this.image != null) {
      data['images'] = this.image;
    }
    if (this.orderCost != null) {
      data['orderCost'] = this.orderCost;
    }
    if (this.pdf != null) {
      data['filePdf'] = this.pdf;
    }
    if (this.detail != null && this.detail?.isNotEmpty == true) {
      data['detail'] = this.detail;
    }
    if (this.orderType != null) {
      data['orderType'] = this.orderType;
    }
    if (this.orderID != null) {
      data['primaryOrder'] = this.orderID;
    }
    if (this.order != null) {
      data['id'] = this.order;
    }
    if (this.cancel != null) {
      data['cancel'] = this.cancel;
    }
    if (orderIsMain != null) {
      data['orderIsMain'] = this.orderIsMain;
    }
    if (distance != null) {
      data['storeBranchToClientDistance'] =
          double.tryParse(this.distance!.replaceAll(',', ''));
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
