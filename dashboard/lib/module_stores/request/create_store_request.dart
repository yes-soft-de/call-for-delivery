class UpdateStoreRequest {
  int id;
  String? storeOwnerName;
  String? image;
  String? phone;
  String? closingTime;
  String? openingTime;
  String? status;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  String? employeeCount;
  String? city;

  UpdateStoreRequest(
      {
        required this.id,
        this.storeOwnerName,
      this.image,
      this.phone,
      this.closingTime,
      this.openingTime,
      this.status,
      this.stcPay,
      this.bankAccountNumber,this.city,
      this.bankName,this.employeeCount});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['storeOwnerName'] = storeOwnerName;
    map['phone'] = phone;
    map['images'] = image;
    map['closingTime'] = closingTime;
    map['openingTime'] = openingTime;
    map['status'] = status;
    map['stcPay'] = stcPay;
    map['bankAccountNumber'] = bankAccountNumber;
    map['bankName'] = bankName;
    map['employeeCount'] = employeeCount;
    map['city'] = city;
    return map;
  }
}
