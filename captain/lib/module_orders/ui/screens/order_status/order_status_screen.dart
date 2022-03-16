import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_details_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/order_invoice_request.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/request/update_store_order_status_request.dart';
import 'package:c4d/module_orders/state_manager/order_status/order_status.state_manager.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_status.state.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_status_error_state.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_status_store.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/invoice_dialog.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:c4d/utils/logger/logger.dart';

@injectable
class OrderStatusScreen extends StatefulWidget {
  final OrderStatusStateManager stateManager;

  OrderStatusScreen(this.stateManager);

  @override
  OrderStatusScreenState createState() => OrderStatusScreenState();
}

class OrderStatusScreenState extends State<OrderStatusScreen> {
  String? orderId;
  OrderDetailsState? currentState;
  OrderInvoiceRequest? invoiceRequest;
  bool makeInvoice = false;
  bool deliverOnMe = false;
  @override
  void initState() {
    currentState = OrderDetailsStateInit(this);
    widget.stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void sendOrderReportState(var orderId, bool answar) {
    widget.stateManager.sendOrderReportState(orderId, answar, this);
  }

  void sendState(bool success) {
    if (success) {
      CustomFlushBarHelper.createSuccess(
        title: S.of(context).warnning,
        message: S.of(context).sendToRecordSuccess,
      )..show(context);
    } else {
      CustomFlushBarHelper.createError(
        title: S.of(context).warnning,
        message: S.of(context).sendToRecordFaild,
      )..show(context);
    }
  }

  void goBack(String error) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        OrdersRoutes.CAPTAIN_ORDERS_SCREEN, (route) => false);
    CustomFlushBarHelper.createError(
      title: S.of(context).warnning,
      message: error,
    )..show(context);
  }

  void saveBill(String image, double price, bool? isBilled, String? storeID) {
    invoiceRequest = OrderInvoiceRequest(
        invoiceAmount: price,
        invoiceImage: image,
        orderNumber: orderId,
        storeID: storeID,
        isBilled: isBilled == null ? null : (isBilled == true ? 1 : 0));
    refresh();
  }

  void refresh() {
    if (this.mounted) {
      setState(() {});
    }
  }

  void requestOrderProgress(OrderDetailsModel currentOrder, int index,
      {String? distance, String? storeID}) {
    showDialog(
        context: context,
        builder: (_) {
          return CustomAlertDialog(
              onPressed: () {
                Navigator.of(context).pop();
                if (currentOrder.order.state == OrderStatusEnum.IN_STORE &&
                    invoiceRequest != null) {
                  print(storeID);
                  invoiceRequest?.storeID = storeID;
                  widget.stateManager.updateInvoice(
                    invoiceRequest!,
                    this,
                    orderRequest: UpdateOrderRequest(
                      id: int.tryParse(orderId ?? '-1'),
                      state: StatusHelper.getStatusString(
                          OrderStatusEnum.values[index + 1]),
                      orderCost: currentOrder.order.deliveryCost,
                      distance: distance,
                    ),
                  );
                } else {
                  widget.stateManager.updateOrder(
                      UpdateOrderRequest(
                        id: int.tryParse(orderId ?? '-1'),
                        state: StatusHelper.getStatusString(
                            OrderStatusEnum.values[index + 1]),
                        orderCost: currentOrder.order.deliveryCost,
                        distance: distance,
                      ),
                      this);
                }
              },
              content: S.of(context).confirmUpdateOrderStatus);
        });
  }

  void requestStoreOrderProgress(
      UpdateStoreOrderStatusRequest request, int index) {
    showDialog(
        context: context,
        builder: (_) {
          return CustomAlertDialog(
              onPressed: () {
                Navigator.of(context).pop();
                if (OrderStatusEnum.values[index] == OrderStatusEnum.IN_STORE &&
                    invoiceRequest != null) {
                  widget.stateManager.updateInvoice(invoiceRequest!, this,
                      storeRequest: request);
                } else {
                  widget.stateManager.updateStoreOrder(request, this);
                }
              },
              content: S.of(context).confirmUpdateOrderStatus);
        });
  }

  void getOrderDetails(var orderId) {
    widget.stateManager.getOrderDetails(orderId, this);
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && currentState is OrderDetailsStateInit) {
      orderId = args.toString();
      widget.stateManager.getOrderDetails(int.tryParse(orderId!) ?? -1, this);
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: !(currentState is OrderStatusErrorState ||
                currentState is OrderDetailsStoreLoaded)
            ? CustomC4dAppBar.appBar(context, title: S.of(context).orderDetails)
            : null,
        body: currentState?.getUI(context),
        floatingActionButton: makeInvoice
            ? TweenAnimationBuilder(
                duration: Duration(milliseconds: 750),
                tween: Tween<double>(begin: 0, end: 1),
                curve: Curves.linear,
                builder: (context, double val, child) {
                  return Transform.scale(
                    scale: val,
                    child: child,
                  );
                },
                child: ElevatedButton(
                  onPressed: detectInvoice,
                  style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.current.makeBill,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }

  Future<void> detectInvoice() async {
    String? imagePath;
    try {
//        imagePath = await EdgeDetection.detectEdge;
      await ImagePicker.platform
          .pickImage(source: ImageSource.camera, imageQuality: 70)
          .then((value) {
        if (value != null) {
          imagePath = value.path;
        }
      });
    } catch (e) {
      Logger().error('Detect Edge', e.toString(), StackTrace.current);
      await CustomFlushBarHelper.createError(
              title: S.current.warnning, message: e.toString())
          .show(context);
      return;
    }
    if (imagePath != null) {
      final totalCost = TextEditingController();
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 375),
              tween: Tween<double>(begin: 0, end: 1),
              curve: Curves.linear,
              builder: (context, double val, child) {
                return Transform.scale(
                  scale: val,
                  child: child,
                );
              },
              child: InvoiceDialog(
                totalCost,
                imagePath!,
                isBilledCalculated: deliverOnMe,
                onPressed: (isBilled) {
                  Navigator.of(context).pop();
                  widget.stateManager.uploadBill(
                      this, imagePath!, double.tryParse(totalCost.text) ?? 0,
                      isBilled: isBilled);
                },
              ),
            );
          });
    }
  }
}
