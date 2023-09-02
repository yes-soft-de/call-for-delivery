import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/order/order_captain_not_arrived.dart';
import 'package:c4d/module_stores/request/captain_not_arrived_request.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/order/order_captain_not_arrived.dart';
import 'package:c4d/module_stores/ui/state/order/order_captain_not_arrived_loaded.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderCaptainNotArrivedStateManager extends StateManagerHandler {
  final StoresService _orderService;

  Stream<States> get stateStream => stateSubject.stream;

  OrderCaptainNotArrivedStateManager(this._orderService);

  void getOrdersFilters(OrderCaptainNotArrivedScreenState screenState,
      FilterOrderCaptainNotArrivedRequest request,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _orderService.getOrdersNotArrivedCaptainFilter(request).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderCaptainNotArrivedModel;
        stateSubject.add(OrderCaptainLoadedState(screenState, value.data));
      }
    });
  }
}
