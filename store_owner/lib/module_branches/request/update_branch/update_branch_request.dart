import 'package:latlong2/latlong.dart';

class UpdateBranchesRequest {
  LatLng? location;
  String? city;
  String? branchName;
  int? id;
  String? phone;
  UpdateBranchesRequest(
      {this.id,
      this.location,
      this.city,
      this.branchName,
      required this.phone});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'location': {
        'lat': this.location?.latitude,
        'lon': this.location?.longitude
      },
      'city': this.city,
      'name': this.branchName,
      'branchPhone': this.phone
    };
  }
}
