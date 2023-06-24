import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_my_notifications/model/update_model.dart';
import 'package:c4d/module_my_notifications/service/my_notification_service.dart';
import 'package:c4d/module_my_notifications/ui/widget/update_dialog.dart';
import 'package:c4d/module_orders/model/company_info_model.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/request/payment/paymnet_status_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:c4d/module_orders/ui/state/owner_orders/orders.state.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_subscription/model/can_make_order_model.dart';
import 'package:c4d/module_subscription/service/subscription_service.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
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

  final PublishSubject<States> _stateSubject = PublishSubject();
  final PublishSubject<ProfileModel> _profileSubject = PublishSubject();
  final PublishSubject<CanMakeOrderModel> _subscriptionStatus =
      PublishSubject();
  final PublishSubject<CompanyInfoModel> _companySubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  Stream<ProfileModel> get profileStream => _profileSubject.stream;

  Stream<CompanyInfoModel> get companyStream => _companySubject.stream;
  Stream<CanMakeOrderModel> get statusStream => _subscriptionStatus.stream;

  OwnerOrdersStateManager(
    this._ordersService,
    this._authService,
    this._profileService,
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
      }
    });
  }

  void getUpdates(OwnerOrdersScreenState screenState) {
    getIt<MyNotificationsService>()
        .getUpdates(onlyNewUpdates: true)
        .then((value) {
      if (value.hasError) {
        // do nothing
      } else if (value.isEmpty) {
        // do nothing
      } else if (value is UpdateModel && value.data.isEmpty) {
        // do nothing
      } else {
        value as UpdateModel;
        if (!screenState.showWelcomeDialog)
          showDialog(
            context: screenState.context,
            builder: (context) {
              return UpdateDialog(
                updateModel: value.data,
              );
            },
          );
      }
    });
  }

  /// to show welcome package if needed (9162)
  void showWelcomeDialogIfNeeded(OwnerOrdersScreenState screenState) async {
    await _authService.accountStatus();
    screenState.showWelcomeDialog = getIt<AuthPrefsHelper>().getIsNewAccount();
    screenState.welcomeDialogWithoutPayment =
        getIt<AuthPrefsHelper>().getOpenWelcomeDialogWithoutPayment();
    if (screenState.showWelcomeDialog)
      screenState.welcomeDialog(screenState.context);
    screenState.refresh();
  }

  void getOrdersFilters(
      OwnerOrdersScreenState screenState, FilterOrderRequest request,
      [bool loading = true]) {
    // if (request.state == 'pending') {
    //   getOrders(screenState);
    //   return;
    // }
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
          showWelcomeDialogIfNeeded(screenState);

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
    await getMakeOrderAbility();
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
      var company = await _ordersService.getCompanyInfo();
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

  Future<void> getMakeOrderAbility() async {
    try {
      // can make order
      var status = await getIt<SubscriptionService>().getMakingOrderAbility();
      if (status.hasError) {
        Fluttertoast.showToast(
          msg: status.error ?? S.current.errorHappened,
          backgroundColor: Colors.red,
        );
        _subscriptionStatus.add(
          CanMakeOrderModel(
            canCreateOrder: false,
            status: status.error ?? S.current.errorHappened,
            percentageOfOrdersConsumed: '0%',
            consumingAlert: false,
            unlimitedPackage: false,
            packageType: -1,
            hasToPay: false,
            firstTimeSubscriptionWithUniformPackage: false,
          ),
        );
      } else {
        status as CanMakeOrderModel;
        _subscriptionStatus.add(status.data);
      }
    } catch (e) {
      return;
    }
  }

  void makePayment(
      OwnerOrdersScreenState screenState, PaymentStatusRequest request) {
    _ordersService.makePayment(request).then(
      (value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '')
              .show(screenState.context);
        } else {
          getIt<GlobalStateManager>().update();
          showWelcomeDialogIfNeeded(screenState);
        }
      },
    );
  }

  void watcher(OwnerOrdersScreenState screenState, [bool loading = false]) {
    FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
      if (screenState.mounted) {
        getOrdersFilters(
            screenState,
            FilterOrderRequest(state: screenState.orderFilter ?? 'pending'),
            false);
      }
    });
  }
}
