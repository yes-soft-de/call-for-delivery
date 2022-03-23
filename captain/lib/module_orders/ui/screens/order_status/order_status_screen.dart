import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_details_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/order_invoice_request.dart';
import 'package:c4d/module_orders/request/update_store_order_status_request.dart';
import 'package:c4d/module_orders/state_manager/order_status/order_status.state_manager.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/invoice_dialog.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/logger/logger.dart';

@injectable
class OrderStatusScreen extends StatefulWidget {
  final OrderStatusStateManager stateManager;

  const OrderStatusScreen(this.stateManager);

  @override
  OrderStatusScreenState createState() => OrderStatusScreenState();
}

class OrderStatusScreenState extends State<OrderStatusScreen> {
  String? orderId;
  States? currentState;
  OrderInvoiceRequest? invoiceRequest;
  bool makeInvoice = false;
  bool deliverOnMe = false;
  @override
  void initState() {
    currentState = LoadingState(this);
    widget.stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    getIt<GlobalStateManager>().stateStream.listen((event) {
      widget.stateManager
          .getOrderDetails(int.tryParse(orderId ?? '-1') ?? -1, this,false);
    });
    super.initState();
  }

  int currentIndex = 0;
  void goBack(String error) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        OrdersRoutes.CAPTAIN_ORDERS_SCREEN, (route) => false);
    CustomFlushBarHelper.createError(
      title: S.of(context).warnning,
      message: error,
    ).show(context);
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
    if (mounted) {
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
                widget.stateManager.updateOrder(
                    UpdateOrderRequest(
                      id: int.tryParse(orderId ?? '-1'),
                      state: StatusHelper.getStatusString(
                          OrderStatusEnum.values[index + 1]),
                      distance: distance,
                    ),
                    this);
              },
              content: S.of(context).confirmUpdateOrderStatus);
        });
  }

  void requestStoreOrderProgress(
      UpdateStoreOrderStatusRequest request, int index) {
    //   showDialog(
    //       context: context,
    //       builder: (_) {
    //         return CustomAlertDialog(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //               if (OrderStatusEnum.values[index] == OrderStatusEnum.IN_STORE &&
    //                   invoiceRequest != null) {
    //                 widget.stateManager.updateInvoice(invoiceRequest!, this,
    //                     storeRequest: request);
    //               } else {
    //                 widget.stateManager.updateStoreOrder(request, this);
    //               }
    //             },
    //             content: S.of(context).confirmUpdateOrderStatus);
    //       });
    // }
  }
  void getOrderDetails(var orderId) {
    widget.stateManager.getOrderDetails(orderId, this);
  }

  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && flag) {
      orderId = args.toString();
      widget.stateManager.getOrderDetails(int.tryParse(orderId!) ?? -1, this);
      flag = false;
      refresh();
    }
    return GestureDetector(
        onTap: () {
          var focus = FocusScope.of(context);
          if (focus.canRequestFocus) {
            focus.unfocus();
          }
        },
        child: Scaffold(
          body: currentState?.getUI(context),
        ));
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
              duration: const Duration(milliseconds: 375),
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
