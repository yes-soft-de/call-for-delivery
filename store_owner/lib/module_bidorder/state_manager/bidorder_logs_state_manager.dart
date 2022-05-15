import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bidorder/model/order/order_model.dart';
import 'package:c4d/module_bidorder/request/filter_bidorder_request.dart';
import 'package:c4d/module_bidorder/service/bidorder_service.dart';
import 'package:c4d/module_bidorder/ui/screens/bidorder_logs_screen.dart';
import 'package:c4d/module_bidorder/ui/states/bidorder_logs_state/bidorder_logs_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class BidOrderLogsStateManager {
  final BidOrderService _myOrdersService;
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  BidOrderLogsStateManager(this._myOrdersService);

  void getOrdersFilters(
      BidOrderLogsScreenState screenState, FilterBidOrderRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _myOrdersService.getOpenOrders(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as BidOrderModel;
        _stateSubject.add(BidOrderLogsLoadedState(screenState, value.data));
      }
    });
  }
}
