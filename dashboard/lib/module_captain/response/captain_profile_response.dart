import 'package:c4d/module_stores/response/store_profile_response.dart';
import 'package:c4d/utils/logger/logger.dart';

class CaptainProfileResponse {
  String? statusCode;
  String? msg;
  Data? data;

  CaptainProfileResponse({this.statusCode, this.msg, this.data});

  CaptainProfileResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      Logger().error('Captain Profile', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    if (data != null) {
      map['Data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  int? id;
  int? captainID;
  String? captainName;
  Location? location;
  int? age;
  String? car;
  ImageUrl? drivingLicence;
  dynamic? salary;
  String? status;
  String? rating;
  dynamic? bounce;
  dynamic? roomID;
  ImageUrl? image;
  String? phone;
  bool? isOnline;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  dynamic? vacationStatus;
  ImageUrl? mechanicLicense;
  ImageUrl? identity;
  CreateDate? createDate;
  FinancialSystemCaptainDetails? financialSystemCaptainDetails;
  Data(
      {this.id,
      this.captainID,
      this.captainName,
      this.location,
      this.age,
      this.car,
      this.drivingLicence,
      this.salary,
      this.status,
      this.rating,
      this.bounce,
      this.roomID,
      this.image,
      this.phone,
      this.isOnline,
      this.bankName,
      this.bankAccountNumber,
      this.stcPay,
      this.vacationStatus,
      this.mechanicLicense,
      this.identity,
      this.createDate,
      this.financialSystemCaptainDetails});

  Data.fromJson(dynamic json) {
    id = json['id'];
    captainID = json['captainId'];
    captainName = json['captainName'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    age = json['age'];
    car = json['car'];
    drivingLicence = json['drivingLicence'] != null
        ? ImageUrl.fromJson(json['drivingLicence'])
        : null;
    salary = json['salary'];
    status = json['status'];
    rating = json['rating'];
    bounce = json['bounce'];
    roomID = json['roomId'];
    image = json['images'] != null ? ImageUrl.fromJson(json['images']) : null;
    phone = json['phone'];
    isOnline = json['isOnline'];
    bankName = json['bankName'];
    bankAccountNumber = json['bankAccountNumber'];
    stcPay = json['stcPay'];
    vacationStatus = json['vacationStatus'];
    financialSystemCaptainDetails =
        json['financialCaptainSystemDetails'] != null
            ? FinancialSystemCaptainDetails.fromJson(
                json['financialCaptainSystemDetails'])
            : null;
    mechanicLicense = json['mechanicLicense'] != null
        ? ImageUrl.fromJson(json['mechanicLicense'])
        : null;
    identity =
        json['identity'] != null ? ImageUrl.fromJson(json['identity']) : null;
    createDate = json['createDate'] != null
        ? CreateDate.fromJson(json['createDate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['captainID'] = captainID;
    map['captainName'] = captainName;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['age'] = age;
    map['car'] = car;
    map['drivingLicence'] = drivingLicence;
    map['salary'] = salary;
    map['status'] = status;
    map['bounce'] = bounce;
    map['roomID'] = roomID;
    map['image'] = image;
    map['phone'] = phone;
    map['isOnline'] = isOnline;
    map['bankName'] = bankName;
    map['bankAccountNumber'] = bankAccountNumber;
    map['stcPay'] = stcPay;
    map['vacationStatus'] = vacationStatus;
    map['mechanicLicense'] = mechanicLicense;
    map['identity'] = identity;
    return map;
  }
}

class Rating {
  dynamic? rate;

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

class Transitions {
  int? ts;
  String? time;
  int? offset;
  bool? isdst;
  String? abbr;

  Transitions({this.ts, this.time, this.offset, this.isdst, this.abbr});

  Transitions.fromJson(dynamic json) {
    ts = json['ts'];
    time = json['time'];
    offset = json['offset'];
    isdst = json['isdst'];
    abbr = json['abbr'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['ts'] = ts;
    map['time'] = time;
    map['offset'] = offset;
    map['isdst'] = isdst;
    map['abbr'] = abbr;
    return map;
  }
}

class CreateDate {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  CreateDate({this.timezone, this.offset, this.timestamp});

  CreateDate.fromJson(dynamic json) {
    timezone =
        json['timezone'] != null ? Timezone.fromJson(json['timezone']) : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (timezone != null) {
      map['timezone'] = timezone?.toJson();
    }
    map['offset'] = offset;
    map['timestamp'] = timestamp;
    return map;
  }
}

class Timezone {
  String? name;
  List<Transitions>? transitions;
  Location? location;

  Timezone({this.name, this.transitions, this.location});

  Timezone.fromJson(dynamic json) {
    name = json['name'];
    if (json['transitions'] != null) {
      transitions = [];
      json['transitions'].forEach((v) {
        transitions?.add(Transitions.fromJson(v));
      });
    }
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    if (transitions != null) {
      map['transitions'] = transitions?.map((v) => v.toJson()).toList();
    }
    if (location != null) {
      map['location'] = location?.toJson();
    }
    return map;
  }
}

class FinancialSystemCaptainDetails {
  int? id;
  CreateDate? createDate;
  CreateDate? updateDate;
  int? captainFinancialSystemType;
  bool? status;
  String? updatedBy;
  num? countHours;
  num? compensationForEveryOrder;
  num? salary;
  num? countOrdersInMonth;
  num? monthCompensation;
  num? bounceMaxCountOrdersInMonth;
  num? bounceMinCountOrdersInMonth;
  FinancialSystemCaptainDetails.fromJson(dynamic json) {
    id = json['id'];
    captainFinancialSystemType = json['captainFinancialSystemType'];
    status = json['status'];
    updatedBy = json['updatedBy'];
    countHours = json['countHours'];
    compensationForEveryOrder = json['compensationForEveryOrder'];
    salary = json['salary'];
    createDate = json['createdAt'] != null
        ? CreateDate.fromJson(json['createdAt'])
        : null;
    updateDate = json['updatedAt'] != null
        ? CreateDate.fromJson(json['updatedAt'])
        : null;
    countOrdersInMonth = json['countOrdersInMonth'];
    monthCompensation = json['monthCompensation'];
    bounceMaxCountOrdersInMonth = json['bounceMaxCountOrdersInMonth'];
    bounceMinCountOrdersInMonth = json['bounceMinCountOrdersInMonth'];
  }
}
