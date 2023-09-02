import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_stores/request/order_filter_request.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/order/order_top_active_store.dart';
import 'package:c4d/module_stores/ui/state/order/filter_orders_top_active_store.dart';
import 'package:injectable/injectable.dart';

@injectable
class FilterOrderTopStateManager extends StateManagerHandler {
  final StoresService _orderService;

  Stream<States> get stateStream => stateSubject.stream;

  FilterOrderTopStateManager(this._orderService);
  void getOrdersFilters(
      OrdersTopActiveStoreScreenState screenState, FilterOrderRequest request,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _orderService.getStoreOrdersFilter(request).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderModel;
        stateSubject.add(FilterOrderLoadedState(screenState, value.data));
      }
    });
  }
}
