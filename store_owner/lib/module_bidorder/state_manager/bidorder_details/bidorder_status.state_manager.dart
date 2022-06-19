import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_bidorder/model/order/bidorder_details_model.dart';
import 'package:c4d/module_bidorder/service/bidorder_service.dart';
import 'package:c4d/module_bidorder/ui/screens/bidorder_details/bidorder_details_screen.dart';
import 'package:c4d/module_bidorder/ui/states/bidorder_details/bidorder_details_state_loaded.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class BidOrderStatusStateManager {
  final BidOrderService _ordersService;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = new PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  BidOrderStatusStateManager(this._ordersService, this._authService);
  void getOrder(BidOrderDetailsScreenState screenState, int id,
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
        value as BidOrderDetailsModel;
        _stateSubject.add(BidOrderDetailsStateLoaded(screenState, value.data));
      }
    });
  }
}
