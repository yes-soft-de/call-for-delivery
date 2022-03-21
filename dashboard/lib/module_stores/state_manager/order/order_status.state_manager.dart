import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_stores/model/order/order_details_model.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/order/order_details_screen.dart';
import 'package:c4d/module_stores/ui/state/order/order_details_state_owner_order_loaded.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OrderStatusStateManager {
  final StoresService _ordersService;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = new PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  OrderStatusStateManager(this._ordersService, this._authService);
  void getOrder(OrderDetailsScreenState screenState, int id,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _ordersService.getOrderDetails(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrder(screenState, id);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getOrder(screenState, id);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderDetailsModel;
        _stateSubject
            .add(OrderDetailsStateOwnerOrderLoaded(screenState, value.data));
        if (loading) {
          watcher(screenState, id);
        }
      }
    });
  }

  void rateCaptain(OrderDetailsScreenState screenState) {
//    _stateSubject.add(LoadingState(screenState));
//    _ordersService.ratingCaptain(request).then((value) {
//      if (value.hasError) {
//        getOrder(screenState, screenState.orderId);
//        CustomFlushBarHelper.createError(
//                title: S.current.warnning, message: value.error ?? '')
//            .show(screenState.context);
//      } else {
//        getOrder(screenState, screenState.orderId);
//        CustomFlushBarHelper.createSuccess(
//                title: S.current.warnning, message: S.current.captainRated)
//            .show(screenState.context);
//      }
//    });
  }

  void watcher(OrderDetailsScreenState screenState, int id) {
    FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
      getOrder(screenState, id, false);
    });
  }
}
