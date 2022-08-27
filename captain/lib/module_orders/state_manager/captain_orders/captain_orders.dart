import 'dart:async';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    if (screenState.currentPage == 0) {
      getAcceptedOrders(screenState, loading);
    } else {
      getNearbyOrders(screenState, loading);
    }
  }

  void getNearbyOrders(CaptainOrdersScreenState screenState,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState, picture: true));
    }
    _ordersService.getNearbyOrders().then((DataModel value) {
      if (value.hasError) {
        if (value.error == S.current.youAreOffline) {
          _stateSubject.add(CaptainOrdersListStateOrdersLoaded(screenState,
              DataModel.empty(), DataModel.withError(value.error)));
        } else {
          _stateSubject.add(ErrorState(screenState,
              onPressed: () {
                getNearbyOrders(screenState);
              },
              title: '',
              error: value.error,
              hasAppbar: false,
              tapApp: () {
                screenState.advancedController.showDrawer();
              },
              icon: Icons.sort_rounded));
        }
      } else {
        _stateSubject.add(CaptainOrdersListStateOrdersLoaded(
            screenState, DataModel.empty(), value));
      }
    });
  }

  void getAcceptedOrders(CaptainOrdersScreenState screenState,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState, picture: true));
    }
    _ordersService.getCaptainOrders().then((DataModel value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState,
            onPressed: () {
              getAcceptedOrders(screenState);
            },
            title: '',
            error: value.error,
            hasAppbar: false,
            tapApp: () {
              screenState.advancedController.showDrawer();
            },
            icon: Icons.sort_rounded));
      } else {
        _stateSubject.add(CaptainOrdersListStateOrdersLoaded(
            screenState, value, DataModel.empty()));
      }
    });
  }

  void companyInfo() {
    _ordersService.getCompanyInfo().then((info) => _companySubject.add(info!));
  }

  void updateProfileStatus(
      CaptainOrdersScreenState screenState, bool isOnline) {
    _profileService.changeProfileStatus(isOnline).then((value) {
      if (value.hasError) {
        Fluttertoast.showToast(msg: value.error ?? S.current.errorHappened);
      } else {
        Fluttertoast.showToast(msg: S.current.profileStatusUpdatedSuccessfully);
        getIt<GlobalStateManager>().update();
      }
    });
  }

  void updateOrder(
      UpdateOrderRequest request, CaptainOrdersScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _ordersService.updateOrder(request).then((value) {
      if (value.hasError) {
        screenState.getMyOrders();
        showDialog(
            context: screenState.context,
            builder: (ctx) {
              return CustomFlushBarHelper.warningDialog(
                  title: S.current.warnning,
                  message: value.error,
                  context: screenState.context);
            });
      } else {
        screenState.getMyOrders('Trigger');
        screenState.moveTo(OrdersRoutes.ORDER_STATUS_SCREEN, request.id);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.updateOrderSuccess)
            .show(screenState.context);
      }
    });
  }
}
