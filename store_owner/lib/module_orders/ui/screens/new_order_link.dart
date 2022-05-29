import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/state_manager/new_order_link_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class NewOrderLinkScreen extends StatefulWidget {
  final NewOrderLinkStateManager _stateManager;

  NewOrderLinkScreen(
    this._stateManager,
  );

  @override
  NewOrderLinkScreenState createState() => NewOrderLinkScreenState();
}

class NewOrderLinkScreenState extends State<NewOrderLinkScreen>
    with WidgetsBindingObserver {
  late States currentState;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription? _stateSubscription;

  void addNewOrder(CreateOrderRequest request) {
    widget._stateManager.createOrder(this, request);
  }

  void refresh() {
    setState(() {});
  }

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
    super.initState();
    currentState = LoadingState(this);
    countryNumberController.text = '966';
    widget._stateManager.getBranches(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    toController.addListener(() {
      if (toController.text.isNotEmpty && toController.text != '') {
        var data = toController.text.trim();
        var link = Uri.tryParse(data);
        if (link != null && link.queryParameters['q'] != null) {
          customerLocation = LatLng(
            double.parse(link.queryParameters['q']!.split(',')[0]),
            double.parse(link.queryParameters['q']!.split(',')[1]),
          );
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    orderDetailsController.dispose();
    noteController.dispose();
    receiptNameController.dispose();
    phoneNumberController.dispose();
    countryNumberController.dispose();
    toController.dispose();
    priceController.dispose();
    _stateSubscription?.cancel();
    super.dispose();
  }

  void saveInfo(String info) {}
  int orderId = -1;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && currentState is LoadingState && flag) {
      orderId = args as int;
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
        appBar: CustomC4dAppBar.appBar(context, title: S.current.newOrderLink),
        key: _scaffoldKey,
        body: SafeArea(
          child: currentState.getUI(context),
        ),
      ),
    );
  }
}
