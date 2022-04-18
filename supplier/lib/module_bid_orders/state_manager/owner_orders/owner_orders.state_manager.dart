import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_bid_orders/model/order/order_model.dart';
import 'package:c4d/module_bid_orders/request/order_filter_request.dart';
import 'package:c4d/module_bid_orders/service/orders/orders.service.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/my_offer_order_screen.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:c4d/module_bid_orders/ui/state/offer_orders/offer_order_state_loaded.dart';
import 'package:c4d/module_bid_orders/ui/state/owner_orders/orders.state.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OwnerOrdersStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;


  OwnerOrdersStateManager(
    this._ordersService,
    this._authService,
  );

  void getOrdersFilters(
      OwnerOrdersScreenState screenState, FilterBidOrderRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _ordersService.getMyOrdersFilter(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderModel;
        _stateSubject
            .add(OrdersListStateOrdersLoaded(screenState, orders: value.data));
      }
    });
  }

  void watcher(OwnerOrdersScreenState screenState, [bool loading = false]) {
    FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
      getOrdersFilters(
          screenState,
          FilterBidOrderRequest(),
          loading);
    });
  }

  void getOfferOrdersFilters(
      OfferOrdersScreenState screenState, FilterBidOrderRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _ordersService.getMyOrdersFilter(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getOfferOrdersFilters(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getOfferOrdersFilters(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderModel;
        _stateSubject
            .add(OfferOrdersListStateLoaded(screenState, orders: value.data));
      }
    });
  }
}
