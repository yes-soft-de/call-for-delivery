import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';

import 'package:c4d/module_home/ui/home_screen.dart';
import 'package:c4d/module_order/request/order_state_request.dart';
import 'package:c4d/module_order/service/orders_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OrdersStateManager {
  final OrdersService _service;

  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  OrdersStateManager(this._service);

  void updateStatus(HomeScreenState screenState,  UpdateOrderStateRequest request){
    _service.updateStatus(request).then((value) {
      if(value.hasError){
        Navigator.pop(screenState.context);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      }
      else{
        Navigator.pop(screenState.context);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.orderUpdatedSuccessfully)
          ..show(screenState.context);
      }
    });
  }
}