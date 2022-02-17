import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/response/branches/branches_response.dart';
import 'package:latlong2/latlong.dart';

class BranchesModel extends DataModel {
  late LatLng location;
  late String city;
  late String userName;
  late String branchName;
  late int id;
  BranchesModel({
    required this.location,
    required this.branchName,
    required this.id,
    required this.city,
    required this.userName,
  });
  List<BranchesModel> _branches = [];

  BranchesModel.withData(BranchListResponse response) {
    _branches = [];
    var data = response.data;
    data?.forEach((element) {
      _branches.add(BranchesModel(
          location: LatLng(0, 0),
          branchName: element.brancheName ?? S.current.unknown,
          city: element.city ?? '',
          id: element.id ?? -1,
          userName: element.userName ?? S.current.unknown));
    });
  }
  BranchesModel.empty();
}
