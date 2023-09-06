import 'package:c4d/module_stores/response/store_profile_response.dart';
import 'package:c4d/utils/logger/logger.dart';

class NaherEvanCaptainsResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  NaherEvanCaptainsResponse({this.statusCode, this.msg, this.data});

  NaherEvanCaptainsResponse.fromJson(dynamic json) {
    try {} catch (e) {
      statusCode = '-1';
      Logger.error('InActiveCaptainResponse', e.toString(), StackTrace.current);
    }
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    if (data != null) {
      map['Data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  int? id;
  int? captainID;
  String? captainName;
  ImageUrl? image;
  Location? location;
  String? age;
  String? car;
  ImageUrl? drivingLicence;
  num? salary;
  String? status;
  dynamic state;
  num? bounce;
  String? roomID;
  dynamic specialLink;
  String? phone;
  dynamic isOnline;
  dynamic newMessageStatus;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  ImageUrl? mechanicLicense;
  ImageUrl? identity;
  String? userId;
  int? verificationStatus;
  Data(
      {this.id,
      this.captainID,
      this.captainName,
      this.image,
      this.location,
      this.age,
      this.car,
      this.drivingLicence,
      this.salary,
      this.status,
      this.state,
      this.bounce,
      this.roomID,
      this.specialLink,
      this.phone,
      this.isOnline,
      this.newMessageStatus,
      this.bankName,
      this.bankAccountNumber,
      this.stcPay,
      this.mechanicLicense,
      this.identity,
      this.userId,
      this.verificationStatus});

  Data.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    verificationStatus = json['verificationStatus'];
    captainID = json['captainId'];
    captainName = json['captainName'];
    image = json['images'] != null ? ImageUrl.fromJson(json['images']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    age = json['age']?.toString();
    car = json['car'];
    drivingLicence = json['drivingLicence'] != null
        ? ImageUrl.fromJson(json['drivingLicence'])
        : null;
    salary = json['salary'];
    status = json['status'];
    state = json['state'];
    bounce = json['bounce'];
    roomID = json['roomId'];
    specialLink = json['specialLink'];
    phone = json['phone'];
    isOnline = json['isOnline'];
    newMessageStatus = json['newMessageStatus'];
    bankName = json['bankName'];
    bankAccountNumber = json['bankAccountNumber'];
    stcPay = json['stcPay'];
    mechanicLicense = json['mechanicLicense'] != null
        ? ImageUrl.fromJson(json['mechanicLicense'])
        : null;
    identity =
        json['identity'] != null ? ImageUrl.fromJson(json['identity']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['captainID'] = captainID;
    map['captainName'] = captainName;
    map['image'] = image;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['age'] = age;
    map['car'] = car;
    map['drivingLicence'] = drivingLicence;
    map['salary'] = salary;
    map['status'] = status;
    map['state'] = state;
    map['bounce'] = bounce;
    map['roomID'] = roomID;
    map['specialLink'] = specialLink;
    map['phone'] = phone;
    map['isOnline'] = isOnline;
    map['newMessageStatus'] = newMessageStatus;
    map['bankName'] = bankName;
    map['bankAccountNumber'] = bankAccountNumber;
    map['stcPay'] = stcPay;
    map['mechanicLicense'] = mechanicLicense;
    map['identity'] = identity;
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
