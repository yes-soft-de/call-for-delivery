import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/response/naher_evan_captains_response/naher_evan_captains_response.dart';

class NaherEvanCaptainsModel extends DataModel {
  int captainID = -1;
  int profileID = -1;
  String captainName = '';
  String image = '';
  late String phoneNumber;
  String? userID;
  late bool verificationStatus;
  List<NaherEvanCaptainsModel> _model = [];

  NaherEvanCaptainsModel({
    required this.captainID,
    required this.image,
    required this.captainName,
    required this.phoneNumber,
    required this.userID,
    required this.verificationStatus,
    required this.profileID,
  });

  NaherEvanCaptainsModel.withData(List<Data> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(NaherEvanCaptainsModel(
        captainID: element.captainID ?? -1,
        image: element.image?.image ?? '',
        captainName: element.captainName ?? '',
        phoneNumber:
            element.phone ?? element.userId ?? S.current.notCompletedAccount,
        userID: element.userId,
        verificationStatus: element.verificationStatus == 1 ? true : false,
        profileID: element.id ?? -1,
      ));
    }
  }
  List<NaherEvanCaptainsModel> get data => _model;
}
