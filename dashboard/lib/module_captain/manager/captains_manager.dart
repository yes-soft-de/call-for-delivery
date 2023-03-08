import 'package:c4d/module_captain/repository/captains_repository.dart';
import 'package:c4d/module_captain/request/assign_order_to_captain_request.dart';
import 'package:c4d/module_captain/request/captain_activities_filter_request.dart';
import 'package:c4d/module_captain/request/captain_daily_finance_request.dart';
import 'package:c4d/module_captain/request/captain_finance_request.dart';
import 'package:c4d/module_captain/request/captain_offer_request.dart';
import 'package:c4d/module_captain/request/enable_captain.dart';
import 'package:c4d/module_captain/request/enable_offer.dart';
import 'package:c4d/module_captain/request/update_captain_request.dart';
import 'package:c4d/module_captain/response/capatin_offer_response.dart';
import 'package:c4d/module_captain/response/captain_account_balance_response/captain_account_balance_response.dart';
import 'package:c4d/module_captain/response/captain_activity_response/captain_activity_response.dart';
import 'package:c4d/module_payments/response/captain_all_amounts.dart';
import 'package:c4d/module_captain/response/captain_finance_daily_response.dart';
import 'package:c4d/module_captain/response/captain_financial_dues_response/captain_financial_dues_response.dart';
import 'package:c4d/module_captain/response/captain_need_support_response/captain_need_support_response.dart';
import 'package:c4d/module_captain/response/captain_order_control_response/captain_order_control_response.dart';
import 'package:c4d/module_captain/response/captain_profile_response.dart';
import 'package:c4d/module_captain/response/captain_rating_response/captain_rating_response.dart';
import 'package:c4d/module_captain/response/in_active_captain_response.dart';
import 'package:c4d/module_captain/response/new_get_finance_daily_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';

import '../response/captain_activity_response/captain_activity_details_response.dart';
import '../response/captain_rating_response/captin_rating_details_response.dart';

@injectable
class CaptainsManager {
  final CaptainsRepository _repository;

  CaptainsManager(this._repository);

  Future<CaptainOfferResponse?> getCaptainOffer() =>
      _repository.getCaptainOffer();

  Future<ActionResponse?> addCaptainOffer(CaptainOfferRequest request) =>
      _repository.addCaptainOffer(request);

  Future<ActionResponse?> updateCaptainOffer(CaptainOfferRequest request) =>
      _repository.updateCaptainOffer(request);

  Future<ActionResponse?> enableCaptainOffer(EnableOfferRequest request) =>
      _repository.enableCaptainOffer(request);

  Future<CaptainResponse?> getCaptains() => _repository.getCaptains();
  Future<CaptainOrderControlResponse?> getCaptainsOrder() =>
      _repository.getCaptainsOrder();

  Future<CaptainResponse?> getInActiveCaptain() =>
      _repository.getInActiveCaptain();

  Future<CaptainProfileResponse?> getCaptainProfile(int id) =>
      _repository.getCaptainProfile(id);

  Future<ActionResponse?> enableCaptain(EnableCaptainRequest request) =>
      _repository.enableCaptain(request);
  Future<ActionResponse?> assignOrderToCaptain(
          AssignOrderToCaptainRequest request) =>
      _repository.assignOrderToCaptain(request);

  Future<ActionResponse?> updateCaptain(UpdateCaptainRequest request) =>
      _repository.updateCaptain(request);

  Future<CaptainNeedSupportResponse?> getCaptainSupport() =>
      _repository.getCaptainSupport();
  Future<CaptainAccountBalanceResponse?> getCaptainAccountBalance(
          int captainId) =>
      _repository.getCaptainAccountBalance(captainId);
  Future<ActionResponse?> captainFinancePlanStatus(
          CaptainFinanceRequest request) =>
      _repository.captainFinanceStatus(request);
  Future<CaptainFinancialDuesResponse?> getCaptainFinancialDues(
          int captainID) =>
      _repository.getCaptainFinancialDues(captainID);
  Future<ActionResponse?> deleteCaptain(String captainID) =>
      _repository.deleteCaptain(captainID);
  Future<CaptainRatingResponse?> getCaptainRating() =>
      _repository.getCaptainRating();
  Future<CaptinRatingDetailsResponse?> getCaptainRatingDetails(int captinID) =>
      _repository.getCaptainRatingDetails(captinID);
  Future<CaptainActivityResponse?> getCaptainActivity() =>
      _repository.getCaptainActivity();
  Future<CaptainActivityResponse?> getCaptainActivityWithFilter(
          CaptainActivityFilterRequest request) =>
      _repository.getCaptainActivityWithFilter(request);
  Future<CaptainActivityDetailsResponse?> getCaptainActivityDetails(
          int captainID) =>
      _repository.getCaptainActivityDetails(captainID);
  Future<CaptainFinanceDailyResponse?> getCaptainFinanceDaily() =>
      _repository.getCaptainFinanceDaily();
  Future<CaptainFinanceDailyNewResponse?> getCaptainFinanceDailyNew(
          CaptainDailyFinanceRequest request) =>
      _repository.getCaptainFinanceDailyNew(request);
}
