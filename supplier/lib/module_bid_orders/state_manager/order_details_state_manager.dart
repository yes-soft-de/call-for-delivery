import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_bid_orders/model/order_details/order_details_model.dart';
import 'package:c4d/module_bid_orders/request/add_offer_request.dart';
import 'package:c4d/module_bid_orders/service/orders/orders.service.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/order_details_screen.dart';
import 'package:c4d/module_bid_orders/ui/state/order_details/details_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@injectable
class OrderDetailsStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;


  OrderDetailsStateManager(
      this._ordersService,
      this._authService,
      );

  void getOrderDetails(OrderDetailsScreenState screenState,int orderId ){
    _stateSubject.add(LoadingState(screenState));
    _ordersService.getOrderDetails(orderId).then((value) {
      if(value.hasError){
        _stateSubject.add(ErrorState(screenState,
            title: S.current.order,
            error: value.error ?? S.current.errorHappened, onPressed: () {
              getOrderDetails(screenState,orderId);
            }));
      }else if(value.isEmpty){
        _stateSubject.add(EmptyState(screenState,
            title: S.current.order,
            emptyMessage: S.current.homeDataEmpty, onPressed: () {
              getOrderDetails(screenState,orderId);
            }));
      }
      value as OrderDetailsModel;
      _stateSubject
          .add(OrderDetailsStateLoaded(screenState,model: value.data));
    });

  }


  void addNewOrder(OrderDetailsScreenState screenState,AddOfferRequest request ){
    _stateSubject.add(LoadingState(screenState));
    _ordersService.addNewOffer(request).then((value) {
      if(value.hasError){
        getOrderDetails(screenState, request.bidOrder ?? -1);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      }else{
        getOrderDetails(screenState, request.bidOrder ?? -1);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.addYourOffer)
            .show(screenState.context);
      }
    });
  }
}