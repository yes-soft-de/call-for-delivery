import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/request/geo_distance_request.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/state_manager/new_order/new_order.state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/phone_number_detection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class NewOrderScreen extends StatefulWidget {
  final NewOrderStateManager _stateManager;

  NewOrderScreen(
    this._stateManager,
  );

  @override
  NewOrderScreenState createState() => NewOrderScreenState();
}

class NewOrderScreenState extends State<NewOrderScreen>
    with WidgetsBindingObserver {
  late States currentState;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription? _stateSubscription;
  bool startParseLocation = false;

  void addNewOrder(CreateOrderRequest request) {
    widget._stateManager.createOrder(this, request);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
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
  int? costType;
  int? branch;
  LatLng? customerLocation;
  GeoDistanceRequest geoDistanceRequest = GeoDistanceRequest();

  /// this variable will have the [toController.text] value but without cleaning
  ///
  /// [toController] must be clean to make sure that it will appear in the filed
  ///
  /// so to make sure that the link will send to the backend without changing this variable well be sent
  ///
  String destinationLink = '';

  /// this variable become true when user enter the link
  /// so can let [GeoDistanceText] appear  do their job
  bool canCallForLocation = false;

  /// this variable is used for ignoring unnecessary
  String oldLink = '';
  bool _ignoreUnnecessaryCall(String newLink) {
    if (newLink.isEmpty) return true;

    var newLinkAfterClean = cleanLink(newLink);

    if (newLinkAfterClean == oldLink) return true;

    oldLink = newLinkAfterClean;
    return false;
  }

  /// this method make sure that the link will appear in the files by:
  ///
  /// * remove unnecessary
  ///
  /// * remove new lines
  ///
  String cleanLink(String old) {
    String cleanedText = old;

    /// remove new lines
    cleanedText = cleanedText.replaceAll('\n', '');

    /// remove white spaces end and begin of text
    cleanedText = cleanedText.trim();

    return cleanedText;
  }

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
    widget._stateManager.getBranches(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });

    toController.addListener(() async {
      if (_ignoreUnnecessaryCall(toController.text)) return;

      geoDistanceRequest.link = destinationLink;
      canCallForLocation = true;

      refresh();
    });
  }

  void quickFillUp() async {
    ClipboardData? clip = await Clipboard.getData(Clipboard.kTextPlain);
    String data = clip?.text.toString() ?? '';
    var fields = data.split(';');
    if (fields.isEmpty) {
      Fluttertoast.showToast(msg: S.current.InvalidInput);
    }
    for (var e in fields) {
      var map = e.split(':');
      var key = map[0];
      var value = map[1];
      switch (key) {
        case 'clientNumber':
          phoneNumberController.text =
              PhoneNumberDetection.getPhoneNumber(value);
          break;
        case 'clientName':
          receiptNameController.text = value;
          break;
        case 'details':
          orderDetailsController.text = value;
          break;
        case 'clientLocationStr':
          toController.text = value + map[2];
          break;
        case 'payment':
          payments = value.toString() == '1' ? 'cash' : 'credit';
          break;
      }
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(context, title: S.current.newOrder),
        key: _scaffoldKey,
        body: SafeArea(
          child: currentState.getUI(context),
        ),
      ),
    );
  }
}
