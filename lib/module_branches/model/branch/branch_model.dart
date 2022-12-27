import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/response/branches/branches_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BranchModel extends DataModel {
  late LatLng location;
  late String name;
  late String? phone;
  BranchModel(
      {required this.location, required this.name, required this.phone});
  List<BranchModel> _branches = [];

  BranchModel.withData(BranchListResponse response) {
    _branches = [];
    var data = response.data;
    data?.forEach((element) {
      _branches.add(BranchModel(
          location: LatLng(0, 0),
          name: element.brancheName ?? S.current.unknown,
          phone: element.branchPhone));
    });
  }
}
