import 'package:c4d/module_branches/response/branches/branches_response.dart';

class CreateBranchRequest {
  String? name;
  GeoJson? location;

  CreateBranchRequest({
     this.name,
     this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location?.toJson(),
    };
  }
}
