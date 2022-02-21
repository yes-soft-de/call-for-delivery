import 'package:c4d/module_branches/response/branches/branches_response.dart';

class CreateBranchRequest {
  String name;
  GeoJson location;

  CreateBranchRequest({
    required this.name,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'brancheName': name,
      'location': location.toJson(),
    };
  }
}
