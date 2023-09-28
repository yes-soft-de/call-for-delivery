// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../abstracts/data_model/data_model.dart';
import '../response/profile_release_response/profile_release_response.dart';

class VersionInfoModel extends DataModel {
  late bool newVersionExist;
  late bool isCritical;

  VersionInfoModel({
    required this.newVersionExist,
    required this.isCritical,
  });

  VersionInfoModel.withData(ProfileReleaseResponse response) {
    var data = response.data;

    if (data == null) return;

    _data = VersionInfoModel(
      isCritical: data.isCritical ?? false,
      newVersionExist: data.newVersionExist ?? false,
    );
  }

  late VersionInfoModel _data;
  VersionInfoModel get data => _data;
}
