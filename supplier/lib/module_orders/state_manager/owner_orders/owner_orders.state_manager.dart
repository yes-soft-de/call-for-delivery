import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/model/company_info_model.dart';
import 'package:c4d/module_about/service/about_service/about_service.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:c4d/module_orders/ui/state/owner_orders/orders.state.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';

@injectable
class OwnerOrdersStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;
  final ProfileService _profileService;
  final AboutService _aboutService;

  final PublishSubject<States> _stateSubject = PublishSubject();
  final PublishSubject<ProfileModel> _profileSubject = PublishSubject();
  final PublishSubject<CompanyInfoModel> _companySubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  Stream<ProfileModel> get profileStream => _profileSubject.stream;

  Stream<CompanyInfoModel> get companyStream => _companySubject.stream;

  OwnerOrdersStateManager(
    this._ordersService,
    this._authService,
    this._profileService, this._aboutService,
  );
  void getOrders(OwnerOrdersScreenState screenState, [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _ordersService.getMyOrders().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrders(screenState);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getOrders(screenState);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderModel;
        _stateSubject
            .add(OrdersListStateOrdersLoaded(screenState, orders: value.data));
        if (loading) {
          watcher(screenState);
        }
      }
    });
  }

  void getOrdersFilters(
      OwnerOrdersScreenState screenState, FilterOrderRequest request,
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

  Future<void> initDrawerData() async {
    await getProfile();
    await getCompanyInfo();
  }

  Future<void> getProfile() async {
    try {
      // profile
      var profile = await _profileService.getProfile();
      if (profile.hasError) {
        Fluttertoast.showToast(
          msg: profile.error ?? S.current.errorHappened,
          backgroundColor: Colors.red,
        );
      } else {
        profile as ProfileModel;
        _profileSubject.add(profile.data);
      }
    } catch (e) {
      return;
    }
  }

  Future<void> getCompanyInfo() async {
    try {
      // company info
      var company = await _aboutService.getCompanyInfo();
      if (company.hasError) {
        Fluttertoast.showToast(
          msg: company.error ?? S.current.errorHappened,
          backgroundColor: Colors.red,
        );
      } else {
        company as CompanyInfoModel;
        _companySubject.add(company.data);
      }
    } catch (e) {
      return;
    }
  }


  void watcher(OwnerOrdersScreenState screenState, [bool loading = false]) {
    FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
      getOrdersFilters(
          screenState,
          FilterOrderRequest(state: screenState.orderFilter ?? 'pending'),
          loading);
    });
  }
}
