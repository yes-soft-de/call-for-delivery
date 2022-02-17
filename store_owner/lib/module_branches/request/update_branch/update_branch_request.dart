import 'package:latlong2/latlong.dart';

class UpdateBranchesRequest {
  LatLng? location;
  String? city;
  String? branchName;
  int? id;
  UpdateBranchesRequest(
      {this.id, this.location, this.city, this.branchName});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'location': {
        'lat': this.location?.latitude,
        'lon': this.location?.longitude
      },
      'city': this.city,
      'brancheName': this.branchName,
    };
  }
}
