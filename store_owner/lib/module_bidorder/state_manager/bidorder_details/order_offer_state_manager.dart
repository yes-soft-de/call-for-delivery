import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bidorder/model/offer/offers_model.dart';
import 'package:c4d/module_bidorder/request/offer_state_request.dart';
import 'package:c4d/module_bidorder/service/bidorder_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import '../../ui/screens/bidorder_details/order_offer_details_screen.dart';
import 'package:c4d/module_bidorder/ui/states/bidorder_details/order_offer_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@injectable
class OrderOffersDetailsStateManager {
  final BidOrderService _ordersService;

  final PublishSubject<States> _stateSubject = new PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  OrderOffersDetailsStateManager(this._ordersService);

  void getOrderOffers(OrderOfferDetailsScreenState screenState, int id) {
    _ordersService.getOrderOffers(id).then((offers) {
      if (offers.hasError) {
        _stateSubject.add(ErrorState(screenState,
            onPressed: () {},
            title: '',
            error: offers.error,
            hasAppbar: false));
      } else if (offers.isEmpty) {
        _stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getOrderOffers(screenState, id);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        offers as OfferModel;
        _stateSubject.add(
            OrderOfferDetailsStateLoaded(screenState, offers: offers.data));
      }
    });
  }


  void updateOfferState(OrderOfferDetailsScreenState screenState , OfferStateRequest request){
    _stateSubject.add(LoadingState(screenState));
    _ordersService.updateOfferState(request).then((value) {
      getOrderOffers(screenState , request.bidOrderId ?? -1);
      if(value.hasError){
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      }else {
        getOrderOffers(screenState , request.bidOrderId ?? -1);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message:S.current.offerStatusUpdatedSuccessfully)
            .show(screenState.context);
      }
    });
  }
}
