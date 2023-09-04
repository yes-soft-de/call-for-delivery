import 'dart:async';
import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_orders/model/order/order_details_model.dart';
import 'package:c4d/module_orders/model/roomId/room_id_model.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_without_actions.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_details_captain_without_actions_state_loaded.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class OrderStatusWithoutActionsStateManager extends StateManagerHandler {
  final OrdersService _ordersService;

  Stream<States> get stateStream => stateSubject.stream;

  OrderStatusWithoutActionsStateManager(
    this._ordersService,
  );

  void getOrderDetails(
      int orderId, OrderStatusWithoutActionsScreenState screenState,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _ordersService.getOrderDetails(orderId).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrderDetails(orderId, screenState);
        }, title: S.current.orderDetails, error: value.error, hasAppbar: true));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, onPressed: () {
          getOrderDetails(orderId, screenState);
        },
            hasAppbar: true,
            emptyMessage: S.current.homeDataEmpty,
            title: S.current.orderDetails));
      } else {
        value as OrderDetailsModel;
        stateSubject.add(OrderDetailsCaptainWithoutActionsOrderLoadedState(
            screenState, value.data));
      }
    });
  }

  void createChatRoom(OrderStatusWithoutActionsScreenState screenState,
      int orderId, int storeId) {
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
          Navigator.of(screenState.context).pushNamed(ChatRoutes.chatRoute,
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
}
