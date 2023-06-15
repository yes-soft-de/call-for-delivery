import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileRequest {
  String? name;
  String? phone;
  String? image;
  String? city;
  String? bankAccountNumber;
  String? bankName;
  String? employeeSize;
  String? openingTime;
  String? closingTime;
  LatLng? location;

  ProfileRequest.empty();

  ProfileRequest({
    this.name,
    this.phone,
    this.image,
    this.city,
    this.bankName,
    this.employeeSize,
    this.bankAccountNumber,
    this.closingTime,
    this.openingTime,
    this.location,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeOwnerName'] = this.name;
    data['phone'] = this.phone;
    if (this.image != null) {
      data['images'] = this.image;
    }
    data['city'] = this.city;
    data['bankName'] = this.bankName ?? '';
    data['bankAccountNumber'] = this.bankAccountNumber ?? '';
    data['employeeCount'] = this.employeeSize;
    data['closingTime'] = this.closingTime;
    data['openingTime'] = this.openingTime;
    data['location'] = {'lat': this.location?.latitude, 'lon': this.location?.longitude};

    return data;
  }
}
