import 'package:c4d/module_profile/response/profile_response.dart';

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
  int? age;
  bool? isOnline;
  num? averageRating;
  String? roomID;
  ProfileModel(
      {this.image,
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
      this.roomID});

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
        age: data.age,
        mechanicLicense: data.mechanicLicense?.imageUrl,
        drivingLicence: data.drivingLicence?.imageUrl,
        identity: data.identity?.imageUrl,
        isOnline: data.isOnline,
        averageRating: data.rate ?? 0,
        roomID: data.roomID);
  }
  bool get hasError => _error != null;
  bool get empty => _empty;
  ProfileModel get data => _models ?? ProfileModel.empty();
  String get error => _error ?? '';
}
