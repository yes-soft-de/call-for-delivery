import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/model/captain_offer_model.dart';
import 'package:c4d/module_captain/request/captain_offer_request.dart';
import 'package:c4d/module_captain/request/enable_offer.dart';
import 'package:c4d/module_captain/service/captains_service.dart';
import 'package:c4d/module_captain/ui/screen/captains_offer_screen.dart';
import 'package:c4d/module_captain/ui/state/offers/captaines_offer_loaded_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class CaptainOfferStateManager {
  final CaptainsService _service;

  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  CaptainOfferStateManager(this._service);

  void getCaptainOffer(CaptainOffersScreenState screenState,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _service.getCaptainOffer().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            CaptainOffersLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(
            CaptainOffersLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        CaptainsOffersModel model = value as CaptainsOffersModel;
        _stateSubject.add(CaptainOffersLoadedState(screenState, model.data));
      }
    });
  }

  void addCaptainOffer(
      CaptainOffersScreenState screenState, CaptainOfferRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _service.addCaptainOffer(request).then((value) {
      if (value.hasError) {
        getCaptainOffer(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
      } else {
        getCaptainOffer(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.addOfferSuccessfully);
      }
    });
  }

  void updateCaptainOffer(
      CaptainOffersScreenState screenState, CaptainOfferRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _service.updateCaptainOffer(request).then((value) {
      if (value.hasError) {
        getCaptainOffer(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
      } else {
        getCaptainOffer(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.updateOfferSuccessfully);
      }
    });
  }

  void enableCaptainOffer(
      CaptainOffersScreenState screenState, EnableOfferRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _service.enableCaptainOffer(request).then((value) {
      if (value.hasError) {
        getCaptainOffer(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
      } else {
        getCaptainOffer(screenState, false);
        Fluttertoast.showToast(msg: S.current.updateOfferSuccessfully);
      }
    });
  }
}
