import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/response/capatin_offer_response.dart';
class CaptainsOffersModel extends DataModel {
  int id = -1;
  String status = '';
  num price=0;
  num carCount=0;
  num expired=0;

  List<CaptainsOffersModel> _model = [];


  CaptainsOffersModel({required this.id,required this.status,
      required this.price,required this.expired ,required this.carCount});

  CaptainsOffersModel.withData(List<CaptainOfferData> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(CaptainsOffersModel(
        id: element.id ?? -1,
        status: element.status ??S.current.unknown,
        carCount: element.carCount ?? 0,
        price: element.price ?? 0,
        expired: element.expired??0,
      ));
    }
  }
  List<CaptainsOffersModel> get data => _model;
}
