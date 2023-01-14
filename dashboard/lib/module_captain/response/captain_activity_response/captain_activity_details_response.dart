class CaptainActivityDetailsResponse {
  String? statusCode;
  String? msg;
  List<CaptainActivityData>? data;

  CaptainActivityDetailsResponse({this.statusCode, this.msg, this.data});

  CaptainActivityDetailsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = <CaptainActivityData>[];
      json['Data'].forEach((v) {
        data!.add(new CaptainActivityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['CaptainActivityData'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CaptainActivityData {
  int? id;
  String? state;
  String? payment;
  int? orderCost;
  int? orderType;
  String? note;
  DeliveryDate? deliveryDate;
  DeliveryDate? createdAt;
  DeliveryDate? updatedAt;
  int? storeOrderDetailsId;
  String? detail;
  int? captainOrderCost;
  Destination? destination;
  String? recipientName;
  String? recipientPhone;
  String? branchName;
  LocationLatLang? location;
  int? storeOwnerBranchId;
  bool? orderIsMain;

  CaptainActivityData(
      {this.id,
      this.state,
      this.payment,
      this.orderCost,
      this.orderType,
      this.note,
      this.deliveryDate,
      this.createdAt,
      this.updatedAt,
      this.storeOrderDetailsId,
      this.detail,
      this.captainOrderCost,
      this.destination,
      this.recipientName,
      this.recipientPhone,
      this.branchName,
      this.location,
      this.storeOwnerBranchId,
      this.orderIsMain});

  CaptainActivityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    payment = json['payment'];
    orderCost = json['orderCost'];
    orderType = json['orderType'];
    note = json['note'];
    deliveryDate = json['deliveryDate'] != null
        ? new DeliveryDate.fromJson(json['deliveryDate'])
        : null;
    createdAt = json['createdAt'] != null
        ? new DeliveryDate.fromJson(json['createdAt'])
        : null;
    updatedAt = json['updatedAt'] != null
        ? new DeliveryDate.fromJson(json['updatedAt'])
        : null;
    storeOrderDetailsId = json['storeOrderDetailsId'];
    detail = json['detail'];
    captainOrderCost = json['captainOrderCost'];
    destination = json['destination'] != null
        ? new Destination.fromJson(json['destination'])
        : null;
    recipientName = json['recipientName'];
    recipientPhone = json['recipientPhone'];
    branchName = json['branchName'];
    location = json['location'] != null
        ? new LocationLatLang.fromJson(json['location'])
        : null;
    storeOwnerBranchId = json['storeOwnerBranchId'];
    orderIsMain = json['orderIsMain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    data['payment'] = this.payment;
    data['orderCost'] = this.orderCost;
    data['orderType'] = this.orderType;
    data['note'] = this.note;
    if (this.deliveryDate != null) {
      data['deliveryDate'] = this.deliveryDate!.toJson();
    }
    if (this.createdAt != null) {
      data['createdAt'] = this.createdAt!.toJson();
    }
    if (this.updatedAt != null) {
      data['updatedAt'] = this.updatedAt!.toJson();
    }
    data['storeOrderDetailsId'] = this.storeOrderDetailsId;
    data['detail'] = this.detail;
    data['captainOrderCost'] = this.captainOrderCost;
    if (this.destination != null) {
      data['destination'] = this.destination!.toJson();
    }
    data['recipientName'] = this.recipientName;
    data['recipientPhone'] = this.recipientPhone;
    data['branchName'] = this.branchName;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['storeOwnerBranchId'] = this.storeOwnerBranchId;
    data['orderIsMain'] = this.orderIsMain;
    return data;
  }
}

class DeliveryDate {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  DeliveryDate({this.timezone, this.offset, this.timestamp});

  DeliveryDate.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'] != null
        ? new Timezone.fromJson(json['timezone'])
        : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timezone != null) {
      data['timezone'] = this.timezone!.toJson();
    }
    data['offset'] = this.offset;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Timezone {
  String? name;
  List<Transitions>? transitions;
  Location? location;

  Timezone({this.name, this.transitions, this.location});

  Timezone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['transitions'] != null) {
      transitions = <Transitions>[];
      json['transitions'].forEach((v) {
        transitions!.add(new Transitions.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.transitions != null) {
      data['transitions'] = this.transitions!.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Transitions {
  int? ts;
  String? time;
  int? offset;
  bool? isdst;
  String? abbr;

  Transitions({this.ts, this.time, this.offset, this.isdst, this.abbr});

  Transitions.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    time = json['time'];
    offset = json['offset'];
    isdst = json['isdst'];
    abbr = json['abbr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ts'] = this.ts;
    data['time'] = this.time;
    data['offset'] = this.offset;
    data['isdst'] = this.isdst;
    data['abbr'] = this.abbr;
    return data;
  }
}

class Location {
  String? countryCode;
  num? latitude;
  num? longitude;
  String? comments;

  Location({this.countryCode, this.latitude, this.longitude, this.comments});

  Location.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['comments'] = this.comments;
    return data;
  }
}

class Destination {
  double? lat;
  double? lon;
  String? link;

  Destination({this.lat, this.lon, this.link});

  Destination.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['link'] = this.link;
    return data;
  }
}

class LocationLatLang {
  double? lat;
  double? lon;

  LocationLatLang({this.lat, this.lon});

  LocationLatLang.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}
