import 'package:c4d/module_profile/response/profile_response.dart';
import 'package:c4d/utils/components/fixed_numbers.dart';

class ProfileModel {
  String? image;
  String? name;
  String? phone;
  String? stcPay;
  String? bankNumber;
  String? bankName;
  String? drivingLicence;
  String? car;
  String? identity;
  String? mechanicLicense;
  String? age;
  bool? isOnline;
  num? averageRating;
  String? roomID;
  String? address;
  String? city;
  ProfileModel({
    this.image,
    this.name,
    this.phone,
    this.stcPay,
    this.bankNumber,
    this.bankName,
    this.drivingLicence,
    this.car,
    this.identity,
    this.mechanicLicense,
    this.age,
    this.isOnline,
    this.averageRating,
    this.roomID,
    required this.address,
    required this.city,
  });

  String? _error;
  bool _empty = false;
  ProfileModel? _models;
  ProfileModel.error(this._error);
  ProfileModel.empty() {
    _empty = true;
  }
  ProfileModel.withData(ProfileResponseModel data) {
    _models = ProfileModel(
      image: data.image?.imageUrl,
      name: data.captainName,
      phone: data.phone,
      stcPay: data.stcPay,
      bankName: data.bankName,
      bankNumber: data.bankAccountNumber,
      car: data.car,
      age: data.age?.toString() ?? '',
      mechanicLicense: data.mechanicLicense?.imageUrl,
      drivingLicence: data.drivingLicence?.imageUrl,
      identity: data.identity?.imageUrl,
      isOnline: data.isOnline,
      averageRating: num.tryParse(FixedNumber.getFixedNumber(data.rate ?? 0)),
      roomID: data.roomID,
      address: data.address,
      city: data.city,
    );
  }
  bool get hasError => _error != null;
  bool get empty => _empty;
  ProfileModel get data => _models ?? ProfileModel.empty();
  String get error => _error ?? '';
}
