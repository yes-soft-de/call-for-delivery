import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/model/cars/cars_model.dart';
import 'package:c4d/module_bid_orders/request/add_offer_request.dart';
import 'package:c4d/module_bid_orders/service/orders/orders.service.dart';
import 'package:c4d/module_bid_orders/ui/screens/add_offer_screen.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/order_details_screen.dart';
import 'package:c4d/module_bid_orders/ui/state/add_offer/add_offer_form.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

import '../../module_auth/service/auth_service/auth_service.dart';

@injectable
class AddOfferStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;


  AddOfferStateManager(
      this._ordersService,
      this._authService,
      );

  void getDeliveryCars(AddOfferScreenState screenState){
    _stateSubject.add(LoadingState(screenState));
    _ordersService.getDeliveryCar().then((value){
      if(value.hasError){
        _stateSubject.add(ErrorState(screenState,
            title: S.current.order,
            error: value.error ?? S.current.errorHappened, onPressed: () {
              getDeliveryCars(screenState);
            }));
      }else if(value.isEmpty){
        _stateSubject.add(EmptyState(screenState,
            title: S.current.addYourOffer,
            emptyMessage: S.current.homeDataEmpty, onPressed: () {
              getDeliveryCars(screenState);
            }));
      }
      else {
        value as CarsModel;
        _stateSubject.add(AddOfferLoadedState(screenState ,cars: value.data));

      }
    });
  }


  void addNewOrder(AddOfferScreenState screenState,AddOfferRequest request ){
    _stateSubject.add(LoadingState(screenState));
    _ordersService.addNewOffer(request).then((value) {
      if(value.hasError){
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      }else{
    Navigator.pop(screenState.context);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.addYourOffer)
            .show(screenState.context);
        getIt<GlobalStateManager>().update();
      }
    });
  }

}