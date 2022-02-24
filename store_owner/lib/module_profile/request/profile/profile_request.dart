class ProfileRequest {
  String? name;
  String? phone;
  String? image;
  String? city;
  String? bankAccountNumber;
  String? bankName;
  String? employeeSize;
  ProfileRequest.empty();

  ProfileRequest({
    this.name,
    this.phone,
    this.image,
    this.city,
    this.bankName,
    this.employeeSize,
    this.bankAccountNumber,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeOwnerName'] = this.name;
    data['phone'] = this.phone;
    if (this.image != null) {
      data['images'] = this.image;
    }
    //  data['city'] = this.city;
    data['bankName'] = this.bankName ?? '';
    data['bankAccountNumber'] = this.bankAccountNumber ?? '';
    data['employeeCount'] = this.employeeSize;
    return data;
  }
}
