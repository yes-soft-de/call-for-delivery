import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bidorder/model/order/order_model.dart';
import 'package:c4d/module_bidorder/request/filter_bidorder_request.dart';
import 'package:c4d/module_bidorder/service/bidorder_service.dart';
import 'package:c4d/module_bidorder/ui/screens/open_bidorder_screen.dart';
import 'package:c4d/module_bidorder/ui/states/open_order_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OpenBidOrderStateManager {
  final BidOrderService _ordersService;

  final PublishSubject<States> _stateSubject = new PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  OpenBidOrderStateManager(this._ordersService);

  void getOpenOrdersFilters(
      OpenBidOrderScreenState screenState, FilterBidOrderRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _ordersService.getOpenOrders(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getOpenOrdersFilters(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getOpenOrdersFilters(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as BidOrderModel;
        _stateSubject
            .add(OpenOrdersLoaded(screenState, orders: value.data));
      }
    });
  }
}
