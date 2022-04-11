class UpdateSupplierRequest {
  int id;
  String? captainName;
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

  UpdateSupplierRequest(
      {required this.id,
      this.captainName,
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
      this.bounce});

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
    map['identity'] = identity;
    map['isOnline'] = isOnline;
    map['salary'] = salary;
    map['bounce'] = bounce;
    return map;
  }
}
