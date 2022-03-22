import 'dart:async';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/response/company_info/company_info.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_orders_loaded.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class CaptainOrdersListStateManager {
  final OrdersService _ordersService;
  final ProfileService _profileService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();
  final PublishSubject<ProfileModel> _profileSubject =
      PublishSubject<ProfileModel>();
  final PublishSubject<CompanyInfoResponse> _companySubject =
      PublishSubject<CompanyInfoResponse>();
  Stream<ProfileModel> get profileStream => _profileSubject.stream;
  Stream<States> get stateStream => _stateSubject.stream;
  Stream<CompanyInfoResponse> get companyStream => _companySubject.stream;

  CaptainOrdersListStateManager(this._ordersService, this._profileService);
  StreamSubscription? newActionSubscription;

  void getProfile(CaptainOrdersScreenState screenState) {
    _profileService.getProfile().then((profile) {
      if (profile.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: profile.error)
            .show(screenState.context);
      } else if (profile.empty) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: S.current.profileDataEmpty)
            .show(screenState.context);
      } else {
        _profileSubject.add(profile.data);
      }
    });
  }

  void getMyOrders(CaptainOrdersScreenState screenState,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState,picture: true));
    }
    Future.wait([
      _ordersService.getCaptainOrders(),
      _ordersService.getNearbyOrders(),
    ]).then((List<DataModel> value) {
      if (value[0].hasError && value[1].hasError) {
        _stateSubject.add(ErrorState(screenState,
            onPressed: () {
              getMyOrders(screenState);
            },
            title: '',
            errors: [value[0].error!, value[1].error!],
            hasAppbar: false,
            tapApp: () {
              screenState.advancedController.showDrawer();
            },
            icon: Icons.sort_rounded));
      } else {
        _stateSubject.add(CaptainOrdersListStateOrdersLoaded(
            screenState, value[0], value[1]));
      }
    });
  }

  void companyInfo() {
    _ordersService.getCompanyInfo().then((info) => _companySubject.add(info!));
  }
}
