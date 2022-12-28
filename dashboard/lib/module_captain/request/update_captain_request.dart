import 'package:c4d/module_captain/response/captain_profile_response.dart';

class UpdateCaptainRequest {
  int id;
  String? captainName;
  Location? location;
  String? age;
  String? car;
  String? phone;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  String? images;
  String? mechanicLicense;
  String? identity;
  bool? isOnline;
  num? salary;
  num? bounce;
  String? drivingLicence;
  String? city;
  String? address;

  UpdateCaptainRequest({
    required this.id,
    this.captainName,
    this.location,
    this.age,
    this.car,
    this.phone,
    this.bankName,
    this.bankAccountNumber,
    this.stcPay,
    this.images,
    this.mechanicLicense,
    this.identity,
    this.isOnline,
    this.salary,
    this.bounce,
    this.drivingLicence,
    this.address,
    this.city,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['captainName'] = captainName;
    map['age'] = age;
    map['car'] = car;
    map['phone'] = phone;
    map['bankName'] = bankName;
    map['bankAccountNumber'] = bankAccountNumber;
    map['stcPay'] = stcPay;
    map['images'] = images;
    map['mechanicLicense'] = mechanicLicense;
    map['drivingLicence'] = drivingLicence;
    map['identity'] = identity;
    map['isOnline'] = isOnline;
    map['salary'] = salary;
    map['bounce'] = bounce;
    map['city'] = city;
    map['address'] = address;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    return map;
  }
}
