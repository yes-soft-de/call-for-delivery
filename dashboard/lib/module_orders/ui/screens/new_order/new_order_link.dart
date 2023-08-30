import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/state_manager/new_order/new_order_link_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/phone_number_detection.dart';
import 'package:c4d/utils/helpers/link_cleaner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';

class NewOrderLinkScreen extends StatefulWidget {
  NewOrderLinkScreen();

  @override
  NewOrderLinkScreenState createState() => NewOrderLinkScreenState();
}

class NewOrderLinkScreenState extends State<NewOrderLinkScreen>
    with WidgetsBindingObserver {
  late States currentState;
  late NewOrderLinkStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void addNewOrder(CreateOrderRequest request) {
    _stateManager.createOrder(this, request);
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
  int? costType;
  //
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Clipboard.hasStrings().asStream().listen((event) async {
      if (event) {
        ClipboardData? clip = await Clipboard.getData(Clipboard.kTextPlain);
        String data = clip?.text.toString() ?? '';
        if (data.length > 9 && PhoneNumberDetection.isMobileNumberValid(data)) {
          var result = PhoneNumberDetection.getPhoneNumber(data);
          await Clipboard.setData(ClipboardData(text: result));
          phoneNumberController.text = result;
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
    _stateManager = getIt();
    countryNumberController.text = '966';
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    var old = toController.text;
    toController.addListener(() {
      if (old != toController.text) {
        old = toController.text;
        locationParsing();
      }
    });
  }

  void locationParsing() {
    if (toController.text.isNotEmpty && toController.text != '') {
      if (toController.text.contains(' ') || toController.text.contains('\n')) {
        toController.text = Cleaner.clean(toController.text);
      }
      var data = toController.text.trim();
      var link = Uri.tryParse(data);
      if (link != null && link.queryParameters['q'] != null) {
        customerLocation = LatLng(
          double.parse(link.queryParameters['q']!.split(',')[0]),
          double.parse(link.queryParameters['q']!.split(',')[1]),
        );
        setState(() {});
      } else {
        customerLocation = null;
        setState(() {});
      }
    } else {
      customerLocation = null;
      setState(() {});
    }
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
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void saveInfo(String info) {}
  int orderId = -1;
  int? storeID;
  int? packageType;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && currentState is LoadingState && flag) {
      if (args is OrderModel) {
        orderId = args.id;
        storeID = args.storeId;
        packageType = args.packageType;
        branch = int.tryParse(args.branchID.toString());
        _stateManager.getBranches(this, storeID.toString());
      }
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
