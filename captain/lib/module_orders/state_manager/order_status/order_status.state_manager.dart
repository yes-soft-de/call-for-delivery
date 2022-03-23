import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_orders/model/order/order_details_model.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_details_captain_state_loaded.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class OrderStatusStateManager {
  final OrdersService _ordersService;
  final ImageUploadService _imageUploadService;
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;
  StreamSubscription? _updateStateListener;

  OrderStatusStateManager(this._ordersService, this._imageUploadService);

  void getOrderDetails(int orderId, OrderStatusScreenState screenState,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _ordersService.getOrderDetails(orderId).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrderDetails(orderId, screenState);
        }, title: S.current.orderDetails, error: value.error, hasAppbar: true));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getOrderDetails(orderId, screenState);
        },
            hasAppbar: true,
            emptyMessage: S.current.homeDataEmpty,
            title: S.current.orderDetails));
      } else {
        value as OrderDetailsModel;
        _stateSubject
            .add(OrderDetailsCaptainOrderLoadedState(screenState, value.data));
      }
    });
  }

  void updateOrder(
      UpdateOrderRequest request, OrderStatusScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _ordersService.updateOrder(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error)
            .show(screenState.context);
        getIt<GlobalStateManager>().update();

      } else {
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.updateOrderSuccess)
            .show(screenState.context);
        getIt<GlobalStateManager>().update();
      }
    });
  }

  // void updateStoreOrder(UpdateStoreOrderStatusRequest request,
  //     OrderStatusScreenState screenState) {
  //   _stateSubject.add(OrderDetailsStateLoading(screenState));
  //   _ordersService.updateStoreOrderStatus(request).then((value) {
  //     if (value.hasError) {
  //       screenState.goBack(value.error);
  //     } else {
  //       CustomFlushBarHelper.createSuccess(
  //           title: S.current.warnning, message: S.current.updateOrderSuccess)
  //         ..show(screenState.context);
  //       _ordersService.getOrderDetails(request.orderNumber ?? -1).then((value) {
  //         if (value.hasError) {
  //           _stateSubject.add(OrderStatusErrorState(
  //               screenState, value.error ?? '', request.orderNumber ?? -1));
  //         } else if (value.isEmpty) {
  //           _stateSubject.add(OrderDetailsEmptyState(screenState,
  //               S.current.homeDataEmpty, request.orderNumber ?? -1));
  //         } else {
  //           value as OrderDetailsModel;
  //           var store = value.data.carts.singleWhere((element) =>
  //               element.storeOwnerID == request.storeOwnerProfileId);
  //           _stateSubject.add(OrderDetailsStoreLoaded(screenState, store));
  //         }
  //       });
  //     }
  //   });
  // }

  // void updateInvoice(
  //     OrderInvoiceRequest request, OrderStatusScreenState screenState,
  //     {UpdateOrderRequest? orderRequest,
  //     UpdateStoreOrderStatusRequest? storeRequest}) {
  //   _stateSubject.add(OrderDetailsStateLoading(screenState));
  //   _ordersService.updateOrderBill(request).then((value) {
  //     if (value.hasError) {
  //       CustomFlushBarHelper.createError(
  //               title: S.current.warnning, message: S.current.saveInvoiceFailed)
  //           .show(screenState.context);
  //     } else {
  //       if (request.isBilled != null) {
  //         _ordersService
  //             .billedForCompany(BilledCalculatedRequest(
  //                 orderNumber: request.orderNumber,
  //                 isBillCalculated: request.isBilled))
  //             .then((value) {
  //           if (value.hasError) {
  //             CustomFlushBarHelper.createError(
  //                     title: S.current.warnning,
  //                     message: S.current.saveInvoiceFailed)
  //                 .show(screenState.context);
  //           } else {
  //             if (orderRequest != null) {
  //               updateOrder(orderRequest, screenState);
  //             } else if (storeRequest != null) {
  //               updateStoreOrder(storeRequest, screenState);
  //             }
  //           }
  //         });
  //       } else {
  //         if (orderRequest != null) {
  //           updateOrder(orderRequest, screenState);
  //         } else if (storeRequest != null) {
  //           updateStoreOrder(storeRequest, screenState);
  //         }
  //       }
  //     }
  //   });
  // }

  Future<void> uploadBill(
      OrderStatusScreenState screenState, String image, double totalPrice,
      {bool? isBilled, String? storeID}) async {
    await CustomFlushBarHelper.createSuccess(
      title: S.current.warnning,
      message: S.current.savingInvoice,
    ).show(screenState.context);
    await _imageUploadService.uploadImage(image).then((uploadedImageLink) {
      if (uploadedImageLink == null) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: S.current.saveInvoiceFailed)
            .show(screenState.context);
      } else {
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.saveInvoiceSuccess)
            .show(screenState.context);
        screenState.saveBill(uploadedImageLink, totalPrice, isBilled, storeID);
      }
    });
  }

  void dispose() {
    _updateStateListener?.cancel();
  }
}
