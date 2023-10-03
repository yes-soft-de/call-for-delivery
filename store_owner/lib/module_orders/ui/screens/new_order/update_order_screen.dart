import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/state_manager/new_order/update_order_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/phone_number_detection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

import '../../../../module_deep_links/request/geo_distance_request.dart';

@injectable
class UpdateOrderScreen extends StatefulWidget {
  final UpdateOrderStateManager _stateManager;

  UpdateOrderScreen(
    this._stateManager,
  );

  @override
  UpdateOrderScreenState createState() => UpdateOrderScreenState();
}

class UpdateOrderScreenState extends State<UpdateOrderScreen>
    with WidgetsBindingObserver {
  bool startParseLocation = false;
  late States currentState;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription? _stateSubscription;

  void addNewOrder(CreateOrderRequest request) {
    widget._stateManager.updateOrder(this, request);
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
  late OrderDetailsModel orderInfo;

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
    cleanedText = cleanedText.replaceAll('\n', ' ');

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
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    toController.addListener(() {
      if (_ignoreUnnecessaryCall(toController.text)) return;

      geoDistanceRequest.link = destinationLink;
      canCallForLocation = true;

      refresh();
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
  bool hideFlag = true;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      if (args is OrderDetailsModel) {
        orderInfo = args;
        if (hideFlag) {
          hideFlag = false;
          getIt<OrdersService>().hideOrder(orderInfo.id).ignore();
          widget._stateManager.getBranches(this);
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
              title: S.current.editOrder, canGoBack: false),
          key: _scaffoldKey,
          body: SafeArea(
            child: currentState.getUI(context),
          ),
        ),
      ),
    );
  }
}
