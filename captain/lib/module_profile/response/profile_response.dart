import 'package:c4d/module_orders/response/order_details_response/product_image.dart';
import 'package:c4d/utils/logger/logger.dart';

class ProfileResponse {
  String? statusCode;
  String? msg;
  ProfileResponseModel? data;

  ProfileResponse({this.statusCode, this.msg, this.data});

  ProfileResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null
        ? ProfileResponseModel.fromJson(json['Data'])
        : null;
    // try {} catch (e) {
    //   Logger().error('Profile Response', e.toString(), StackTrace.current);
    //   statusCode = '-1';
    // }
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

class ProfileResponseModel {
  int? id;
  String? captainID;
  String? captainName;
  dynamic location;
  int? age;
  String? car;
  ProductImage? drivingLicence;
  String? drivingLicenceURL;
  num? salary;
  String? status;
  List<CountOrdersDeliverd>? countOrdersDeliverd;
  String? rating;
  dynamic state;
  num? bounce;
  dynamic totalBounce;
  String? roomID;
  ProductImage? image;
  String? imageURL;
  String? baseURL;
  String? phone;
  bool? isOnline;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  dynamic vacationStatus;
  dynamic newMessageStatus;
  ProductImage? mechanicLicense;
  ProductImage? identity;

  ProfileResponseModel(
      {this.id,
      this.captainID,
      this.captainName,
      this.location,
      this.age,
      this.car,
      this.drivingLicence,
      this.drivingLicenceURL,
      this.salary,
      this.status,
      this.countOrdersDeliverd,
      this.rating,
      this.state,
      this.bounce,
      this.totalBounce,
      this.roomID,
      this.image,
      this.imageURL,
      this.baseURL,
      this.phone,
      this.isOnline,
      this.bankName,
      this.bankAccountNumber,
      this.stcPay,
      this.vacationStatus,
      this.newMessageStatus,
      this.mechanicLicense,
      this.identity});

  ProfileResponseModel.fromJson(dynamic json) {
    id = json['id'];
    captainID = json['captainID'];
    captainName = json['captainName'];
    location = json['location'];
    age = json['age'];
    car = json['car'];
    // drivingLicence = json['drivingLicence'] != null
    //     ? ProductImage.fromJson(json['drivingLicence'])
    //     : null;
    drivingLicenceURL = json['drivingLicenceURL'];
    salary = json['salary'];
    status = json['status'];
    if (json['countOrdersDeliverd'] != null) {
      countOrdersDeliverd = [];
      json['countOrdersDeliverd'].forEach((v) {
        countOrdersDeliverd?.add(CountOrdersDeliverd.fromJson(v));
      });
    }
    rating = json['rating'];
    state = json['state'];
    bounce = json['bounce'];
    totalBounce = json['totalBounce'];
    roomID = json['roomID'];
    // image = json['image'] != null
    //     ? ProductImage.fromJson(json['image'])
    //     : null;
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
    phone = json['phone'];
    isOnline = json['isOnline'];
    bankName = json['bankName'];
    bankAccountNumber = json['bankAccountNumber'];
    stcPay = json['stcPay'];
    vacationStatus = json['vacationStatus'];
    newMessageStatus = json['newMessageStatus'];
    // mechanicLicense = json['mechanicLicense'] != null
    //     ? ProductImage.fromJson(json['mechanicLicense'])
    //     : null;
    // identity = json['identity'] != null
    //     ? ProductImage.fromJson(json['identity'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['captainID'] = captainID;
    map['captainName'] = captainName;
    map['location'] = location;
    map['age'] = age;
    map['car'] = car;
    map['drivingLicence'] = drivingLicence;
    map['drivingLicenceURL'] = drivingLicenceURL;
    map['salary'] = salary;
    map['status'] = status;
    if (countOrdersDeliverd != null) {
      map['countOrdersDeliverd'] =
          countOrdersDeliverd?.map((v) => v.toJson()).toList();
    }
    // if (rating != null) {
    //   map['rating'] = rating?.toJson();
    // }
    map['state'] = state;
    if (bounce != null) {
    }
    map['totalBounce'] = totalBounce;
    map['roomID'] = roomID;
    map['image'] = image;
    map['imageURL'] = imageURL;
    map['baseURL'] = baseURL;
    map['phone'] = phone;
    map['isOnline'] = isOnline;
    map['bankName'] = bankName;
    map['bankAccountNumber'] = bankAccountNumber;
    map['stcPay'] = stcPay;
    map['vacationStatus'] = vacationStatus;
    map['newMessageStatus'] = newMessageStatus;
    map['mechanicLicense'] = mechanicLicense;
    map['identity'] = identity;
    return map;
  }
}

class Bounce {
  int? bounce;
  int? sumPayments;
  int? netProfit;
  int? total;
  int? countOrdersDelivered;
  List<dynamic>? payments;

  Bounce(
      {this.bounce,
      this.sumPayments,
      this.netProfit,
      this.total,
      this.countOrdersDelivered,
      this.payments});

  Bounce.fromJson(dynamic json) {
    bounce = json['bounce'];
    sumPayments = json['sumPayments'];
    netProfit = json['NetProfit'];
    total = json['total'];
    countOrdersDelivered = json['countOrdersDelivered'];
    if (json['payments'] != null) {
      payments = [];
      json['payments'].forEach((v) {
        //payments?.add(dynamic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['bounce'] = bounce;
    map['sumPayments'] = sumPayments;
    map['NetProfit'] = netProfit;
    map['total'] = total;
    map['countOrdersDelivered'] = countOrdersDelivered;
    if (payments != null) {
      map['payments'] = payments?.map((v) => v.toJson()).toList();
    }
    return map;
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

class CountOrdersDeliverd {
  int? countOrdersDelivered;

  CountOrdersDeliverd({this.countOrdersDelivered});

  CountOrdersDeliverd.fromJson(dynamic json) {
    countOrdersDelivered = json['countOrdersDelivered'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['countOrdersDelivered'] = countOrdersDelivered;
    return map;
  }
}
