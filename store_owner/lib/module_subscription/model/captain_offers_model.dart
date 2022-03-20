import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/response/captain_offers_response/captain_offers_response.dart';

class CaptainsOffersModel extends DataModel {
  late int id;
  late num cost;
  late num carCount;
  late int expired;

  CaptainsOffersModel(
      {required this.id,
      required this.cost,
      required this.carCount,
      required this.expired});

  List<CaptainsOffersModel> _offersList = [];
  CaptainsOffersModel.withData(CaptainOffersResponse response) {
    _offersList = [];
    var data = response.data;
    data?.forEach((element) {
      _offersList.add(CaptainsOffersModel(
        id: element.id ?? -1,
        carCount: element.carCount ?? 0,
        expired: element.expired ?? 0,
        cost: element.price ?? 0,
      ));
    });
  }
  List<CaptainsOffersModel> get data => _offersList;
}
