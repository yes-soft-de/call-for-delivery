import 'package:c4d/module_captain/repository/captains_repository.dart';
import 'package:c4d/module_captain/request/captain_offer_request.dart';
import 'package:c4d/module_captain/response/capatin_offer_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainsManager {
  final CaptainsRepository _repository;

  CaptainsManager(this._repository);



  Future<CaptainOfferResponse?> getCaptainOffer() =>
      _repository.getCaptainOffer();

  Future<ActionResponse?> addCaptainOffer(CaptainOfferRequest request) =>
      _repository.addCaptainOffer(request);

  Future<ActionResponse?> updateCaptainOffer(
      CaptainOfferRequest request) =>
      _repository.updateCaptainOffer(request);



}
