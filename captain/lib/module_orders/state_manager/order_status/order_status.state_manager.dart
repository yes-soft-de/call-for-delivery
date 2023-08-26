import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_chat_v2/chat_routes.dart';
import 'package:c4d/module_chat_v2/model/chat_argument.dart';
import 'package:c4d/module_chat_v2/presistance/chat_hive_helper.dart';
import 'package:c4d/module_orders/model/order/order_details_model.dart';
import 'package:c4d/module_orders/model/roomId/room_id_model.dart';
import 'package:c4d/module_orders/request/add_extra_distance_request.dart';
import 'package:c4d/module_orders/request/cancel_order_request.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_details_captain_state_loaded.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_status_warning_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      {bool loading = true, String? message}) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _ordersService.getOrderDetails(orderId).then((value) {
      if (value.hasError) {
        if (value.error == S.current.thisOrderAcceptedByAnotherCaptain) {
          _stateSubject.add(OrderStatusWarningState(screenState, onPressed: () {
            getOrderDetails(orderId, screenState);
          },
              title: S.current.orderDetails,
              error: value.error,
              hasAppbar: true));
          showDialog(
              context: screenState.context,
              builder: (ctx) {
                return CustomFlushBarHelper.warningDialog(
                    title: S.current.warnning,
                    message: value.error ?? '',
                    context: ctx);
              });
        } else {
          _stateSubject.add(ErrorState(screenState, onPressed: () {
            getOrderDetails(orderId, screenState);
          },
              title: S.current.orderDetails,
              error: value.error,
              hasAppbar: true));
        }
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getOrderDetails(orderId, screenState);
        },
            hasAppbar: true,
            emptyMessage: S.current.homeDataEmpty,
            title: S.current.orderDetails));
      } else {
        value as OrderDetailsModel;
        _stateSubject.add(OrderDetailsCaptainOrderLoadedState(
            screenState, value.data,
            message: message));
      }
    });
  }

  void createChatRoom(
      OrderStatusScreenState screenState, int orderId, int storeId) {
    _ordersService.createChatRoom(orderId).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
        getOrderDetails(orderId, screenState);
      } else {
        getOrderDetails(orderId, screenState);
        if (value.isEmpty == false) {
          value as RoomId;
          Navigator.of(screenState.context).pushNamed(Chat2Routes.chat2Route,
              arguments: ChatArgument(
                  roomID: value.roomId ?? '',
                  userType: 'store',
                  userID: storeId));
          CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning, message: S.current.chatRoomCreated)
              .show(screenState.context);
        }
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
        getOrderDetails(request.id ?? -1, screenState);
      } else {
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.updateOrderSuccess)
            .show(screenState.context);
        getOrderDetails(request.id ?? -1, screenState, message: 'Trigger');
      }
    });
  }

  void updateCashStatus(
      UpdateOrderRequest request, OrderStatusScreenState screenState) {
    _ordersService.updateCashStatus(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error)
            .show(screenState.context);
        getOrderDetails(request.id ?? -1, screenState, loading: false);
      } else {
        Fluttertoast.showToast(msg: S.current.updateOrderSuccess);
        getOrderDetails(request.id ?? -1, screenState,
            loading: false, message: 'Trigger');
      }
    });
  }

  void updateDistance(
      OrderStatusScreenState screenState, AddExtraDistanceRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _ordersService.updateExtraDistanceToOrder(request).then((value) {
      if (value.hasError) {
        if (value.error == 'you can edit only once') {
          _showCantEditDistanceDialog(screenState.context);
        } else {
          CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '')
              .show(screenState.context);
        }
        screenState.getOrderDetails(request.id);
      } else {
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.noticeHasBeenSendedToAdministration)
            .show(screenState.context);
        screenState.getOrderDetails(request.id);
      }
    });
  }

  void _showCantEditDistanceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xff381D87),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      S.current.requestDistanceEdit,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(
                        Icons.warning_rounded,
                        size: 40,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        S.current.youCantRequestEdit,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    S.current.youCanEditOnlyOneTimeContactWith,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 45,
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () {
                        var roomID = ChatHiveHelper().getDirectSupport();
                        if (roomID != null) {
                          Navigator.of(context).pushNamed(
                            Chat2Routes.chat2Route,
                            arguments:
                                ChatArgument(roomID: roomID, userType: 'Admin'),
                          );
                        }
                      },
                      child: Text(
                        S.current.directSupport,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: const Color(0xff381D87)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void cancelOrder(
      OrderStatusScreenState screenState, CancelOrderRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _ordersService.cancelOrder(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
        screenState.getOrderDetails(request.id);
      } else {
        screenState.goBack();
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.updateOrderSuccess)
            .show(screenState.context);
      }
    });
  }

  void dispose() {
    _updateStateListener?.cancel();
  }
}
