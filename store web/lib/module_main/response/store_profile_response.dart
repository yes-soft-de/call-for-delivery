

class StoreProfileResponse {
  String? statusCode;
  String? msg;
  Data? data;

  StoreProfileResponse({this.statusCode, this.msg, this.data});

  StoreProfileResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    try {} catch (e) {
      statusCode = '-1';
    }
  }
}

class Data {
  int? id;
  String? storeOwnerName;
  ImageUrl? image;
  dynamic phone;
  String? userId;


  String? status;
  String? city;
  String? employeeCount;
  String? bankName;
  String? bankAccountNumber;
  num? profitMargin;
  String? storeId;
  String? roomId;
  bool? openingSubscriptionWithoutPayment;

  Data({
    this.id,
    this.storeOwnerName,
    this.image,
    this.phone,
    this.userId,

    this.status,
    this.city,
    this.bankAccountNumber,
    this.bankName,
    this.employeeCount,
    this.profitMargin,
    this.storeId,
    this.roomId,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    storeId = json['storeOwnerId'];
    storeOwnerName = json['storeOwnerName'];
    roomId = json['roomId'];
    image = json['images'] != null ? ImageUrl.fromJson(json['images']) : null;
    phone = json['phone'];
    userId = json['userId'];

    status = json['status'];
    city = json['city'];
    bankAccountNumber = json['bankAccountNumber'];
    bankName = json['bankName'];
    employeeCount = json['employeeCount'];
    profitMargin = json['profitMargin'];
    openingSubscriptionWithoutPayment  = json['openingSubscriptionWithoutPayment '];
  }
}

class Rating {
  dynamic rate;

  Rating({this.rate});

  Rating.fromJson(dynamic json) {
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['rate'] = rate;
    return map;
  }
}

class Branches {
  int? id;
  int? storeOwnerProfileID;
  Location? location;
  dynamic city;
  String? branchName;
  bool? free;
  String? storeOwnerName;
  bool? isActive;

  Branches(
      {this.id,
      this.storeOwnerProfileID,
      this.location,
      this.city,
      this.branchName,
      this.free,
      this.storeOwnerName,
      this.isActive});

  Branches.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    city = json['city'];
    branchName = json['branchName'];
    free = json['free'];
    storeOwnerName = json['storeOwnerName'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['city'] = city;
    map['branchName'] = branchName;
    map['free'] = free;
    map['storeOwnerName'] = storeOwnerName;
    map['isActive'] = isActive;
    return map;
  }
}

class Location {
  double? lat;
  double? lon;

  Location({this.lat, this.lon});

  Location.fromJson(dynamic json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['lat'] = lat;
    map['lon'] = lon;
    return map;
  }
}

class ImageUrl {
  String? image;
  String? imageURL;
  String? baseURL;
  ImageUrl({this.image, this.imageURL, this.baseURL});

  ImageUrl.fromJson(dynamic json) {
    if (json != null) {
      image = json['image'];
      imageURL = json['imageURL'];
      baseURL = json['baseURL'];
    }
  }
}
