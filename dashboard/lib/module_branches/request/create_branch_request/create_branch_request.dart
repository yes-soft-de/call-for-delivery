import 'package:c4d/module_branches/response/branches/branches_response.dart';

class CreateBranchRequest {
  GeoJson? location;
  String? city;
  String? userName;
  String? branchName;
  String? phone;
  int? id;
  CreateBranchRequest(
      {this.id,
      this.userName,
      this.location,
      this.city,
      this.branchName,
      required this.phone});

  Map<String, dynamic> toJson() {
    return {
      // 'city': this.city,
      'location': {'lat': this.location?.lat, 'lon': this.location?.lon},
      'name': this.branchName,
      'branchPhone': this.phone
    };
  }
}
