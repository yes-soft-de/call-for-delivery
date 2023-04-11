import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/response/in_active_captain_response.dart';

class InActiveModel extends DataModel {
  int captainID = -1;
  int profileID = -1;
  String captainName = '';
  String image = '';
  late String phoneNumber;
  String? userID;
  late bool verificationStatus;
  List<InActiveModel> _model = [];

  InActiveModel(
      {required this.captainID,
      required this.image,
      required this.captainName,
      required this.phoneNumber,
      required this.userID,
      required this.verificationStatus,
      required this.profileID,
      });

  InActiveModel.withData(List<Data> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(InActiveModel(
          captainID: element.id ?? -1,
          image: element.image?.image ?? '',
          captainName: element.captainName ?? '',
          phoneNumber:
              element.phone ?? element.userId ?? S.current.notCompletedAccount,
          userID: element.userId,
          verificationStatus: element.verificationStatus == 1 ? true : false, profileID: element.captainID ?? -1));
    }
  }
  List<InActiveModel> get data => _model;
}
