import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/state_manager/order_recycling_state_manager.dart';
import 'package:c4d/module_orders/ui/state/order_recycling_loaded_state.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderRecyclingScreen extends StatefulWidget {
  final OrderRecyclingStateManager _stateManager;
  OrderRecyclingScreen(this._stateManager);

  @override
  OrderRecyclingScreenState createState() => OrderRecyclingScreenState();
}

class OrderRecyclingScreenState extends State<OrderRecyclingScreen>
    with WidgetsBindingObserver {
  int orderId = -1;
  late States currentState;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  OrderRecyclingStateManager get manager => widget._stateManager;

  // New Order state controller
  TextEditingController orderDetailsController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController receiptNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryNumberController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String? payments;
  int? branch;
  LatLng? customerLocation;
  //
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Clipboard.hasStrings().asStream().listen((event) async {
      if (event) {
        ClipboardData? clip = await Clipboard.getData(Clipboard.kTextPlain);
        String data = clip!.text.toString();
        if (data.length > 9 && data[0] == '0') {
          await Clipboard.setData(ClipboardData(text: data.substring(1)));
          if (mounted) {
            setState(() {});
          }
        }
      }
    });
  }

  @override
  void initState() {
    currentState = LoadingState(this);
    WidgetsBinding.instance?.addObserver(this);

    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
      if (mounted) {
        widget._stateManager.getOrder(this, orderId, false);
      }
    });
    super.initState();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  bool canRemoveIt = false;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && currentState is LoadingState && flag) {
      orderId = args as int;
      widget._stateManager.getOrder(this, orderId);
      flag = false;
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.recycleOrder,
            actions: [
              CustomC4dAppBar.actionIcon(context, onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return CustomAlertDialog(
                          onPressed: () {
                            Navigator.of(context).pop();
                            CreateOrderRequest request =
                                CreateOrderRequest(order: orderId, cancel: 1);
                            if (currentState is OrderRecyclingLoaded) {
                              var orderInfo =
                                  (currentState as OrderRecyclingLoaded)
                                      .orderInfo;
                              request = CreateOrderRequest(
                                  order: orderId,
                                  fromBranch: orderInfo.branchID,
                                  cancel: 1);
                            }
                            manager.recycle(this, request);
                          },
                          content: S.current.areYouSureAboutDeleteOrder);
                    });
              }, icon: Icons.delete)
            ]),
        body: currentState.getUI(context),
      ),
    );
  }
}
