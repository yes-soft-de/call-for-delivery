import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/ui/screen/company_info/company_info_screen.dart';
import 'package:c4d/module_about/ui/states/company_info/company_info_loaded_state.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/model/company_info_model.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:c4d/module_orders/ui/state/owner_orders/orders.state.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_subscription/model/can_make_order_model.dart';
import 'package:c4d/module_subscription/service/subscription_service.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';

@injectable
class CompanyInfoStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;
  final ProfileService _profileService;

  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CompanyInfoStateManager(
    this._ordersService,
    this._authService,
    this._profileService,
  );
  void getCompanyInfo(CompanyInfoScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));

    _ordersService.getCompanyInfo().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getCompanyInfo(screenState);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getCompanyInfo(screenState);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as CompanyInfoModel;
        _stateSubject
            .add(CompanyInfoLoadedState(screenState,company:value.data));
      }
    });
  }
}
