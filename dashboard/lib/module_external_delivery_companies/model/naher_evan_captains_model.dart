import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_external_delivery_companies/response/naher_evan_captains_response/naher_evan_captains_response.dart';

class NaherEvanCaptainsModel extends DataModel {
  int captainID = -1;
  int profileID = -1;
  String captainName = '';
  String image = '';
  bool status = false;
  List<NaherEvanCaptainsModel> _model = [];

  NaherEvanCaptainsModel({
    required this.captainID,
    required this.image,
    required this.captainName,
    required this.profileID,
    required this.status,
  });

  NaherEvanCaptainsModel.withData(List<Data> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(NaherEvanCaptainsModel(
        captainID: element.captainID ?? -1,
        image: element.image?.image ?? '',
        captainName: element.captainName ?? '',
        profileID: element.id ?? -1,
        status: element.status ?? false,
      ));
    }
  }
  List<NaherEvanCaptainsModel> get data => _model;
}
