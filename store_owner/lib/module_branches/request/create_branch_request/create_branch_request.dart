import 'package:google_maps_flutter/google_maps_flutter.dart';
class CreateBrancheRequest {
  LatLng? location;
  String? city;
  String? userName;
  String? branchName;
  int? id;
  CreateBrancheRequest(
      {this.id, this.userName, this.location, this.city, this.branchName});

  Map<String, dynamic> toJson() {
    return {
      'city':this.city,
      'location': {
        'lat': this.location?.latitude,
        'lon': this.location?.longitude
      },
      'brancheName': this.branchName,
    };
  }
}
