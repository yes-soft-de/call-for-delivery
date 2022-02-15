class ProfileModel {
  String? image;
  String name;
  String phone;
  String stcPay;
  String bankNumber;
  String bankName;
  String? drivingLicence;
  String city;
  String? identity;
  String? mechanicLicense;
  ProfileModel(
      {
      required this.image,
      required this.name,
      required this.phone,
      required this.stcPay,
      required this.bankNumber,
      required this.bankName,
       this.drivingLicence,
      required this.city,
       this.identity,
       this.mechanicLicense,
      });
}
