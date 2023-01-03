class CreateCaptainProfileRequest {
  String? image;
  String? drivingLicence;
  String? mechanicLicence;
  String? identity;
  String? car;
  int? age;
  String? name;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  bool? isOnline;
  String? phone;
  String? city;
  String? address;

  CreateCaptainProfileRequest({
    this.image,
    this.drivingLicence,
    this.age,
    this.car,
    this.name,
    this.identity,
    this.mechanicLicence,
    this.address,
    this.city,
  });

  Uri? mechanic;
  Uri? captainImage;
  Uri? driving;
  Uri? idImage;

  CreateCaptainProfileRequest.withUriImages({
    this.name,
    this.age,
    this.car,
    this.mechanic,
    this.captainImage,
    this.driving,
    this.idImage,
    this.bankName,
    this.bankAccountNumber,
    this.phone,
    this.stcPay,
    this.address,
    this.city,
  });

  Map<String, dynamic> toJSON() {
    var data = {
      'captainName': name,
      'image': image,
      'drivingLicence': drivingLicence,
      'age': age,
      'mechanicLicense': mechanicLicence,
      'identity': identity,
      'car': car,
      'isOnline': 'active',
      'phone': phone,
      'stcPay': stcPay,
      'bankAccountNumber': bankAccountNumber,
      'bankName': bankName,
      'city': city,
      'address': address
    };
    if (data['age'] == null) {
      data.remove('age');
    }
    if (data['drivingLicence'] == null) {
      data.remove('drivingLicence');
    }
    if (data['identity'] == null) {
      data.remove('identity');
    }
    if (data['mechanicLicense'] == null) {
      data.remove('mechanicLicense');
    }
    return data;
  }
}
