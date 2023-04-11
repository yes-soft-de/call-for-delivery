import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/state_manager/recycle_order/recycle_order_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/phone_number_detection.dart';
import 'package:c4d/utils/helpers/link_cleaner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class RecycleOrderScreen extends StatefulWidget {
  final RecycleOrderStateManager _stateManager;
  RecycleOrderScreen(
    this._stateManager,
  );

  @override
  RecycleOrderScreenState createState() => RecycleOrderScreenState();
}

class RecycleOrderScreenState extends State<RecycleOrderScreen>
    with WidgetsBindingObserver {
  late States currentState;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription? _stateSubscription;

  void addNewOrder(CreateOrderRequest request) {
    widget._stateManager.recycleOrder(this, request);
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
  List<BranchesModel> branches = [];
  int orderId = -1;
  int? costType;
  //
  late OrderDetailsModel orderInfo;
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
    WidgetsBinding.instance.addObserver(this);
    countryNumberController.text = '966';
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
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
    _stateSubscription?.cancel();
    super.dispose();
  }

  void saveInfo(String info) {}
  bool hideFlag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      if (args is int) {
        orderId = args;
        if (hideFlag) {
          hideFlag = false;
          orderId = args;
          widget._stateManager.getOrderbyId(this, orderId);
        }
      }
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: CustomC4dAppBar.appBar(context,
              title: S.current.orderRecycled, canGoBack: false),
          key: _scaffoldKey,
          body: SafeArea(
            child: currentState.getUI(context),
          ),
        ),
      ),
    );
  }
}
