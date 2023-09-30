import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/state_manager/new_order/update_order_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/link_cleaner.dart';
import 'package:c4d/utils/helpers/phone_number_detection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  late WebViewController controller;
  //
  late OrderDetailsModel orderInfo;

  GeoDistanceRequest geoDistanceRequest = GeoDistanceRequest();

  /// this variable become true when user enter the link
  /// so can let [GeoDistanceText] appear  do their job
  bool canCallForLocation = false;

  /// this variable is used for ignoring unnecessary
  String oldLink = '';
  bool _ignoreUnnecessaryCall(String newLink) {
    if (newLink.isEmpty) return true;

    var newLinkAfterTrim = newLink.trim();

    if (newLinkAfterTrim == oldLink) return true;

    oldLink = newLinkAfterTrim;
    return false;
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

      geoDistanceRequest.link = toController.text.trim();
      canCallForLocation = true;

      refresh();
    });
  }

  void showLoadingIndicatorOverlayToPreventPressingWhileLinkBeingParsing() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return SizedBox(
              height: 50,
              width: 50,
              child: Center(child: CircularProgressIndicator()));
        });
  }

  void locationParsing() async {
    setState(() {
      startParseLocation = true;
    });
    showLoadingIndicatorOverlayToPreventPressingWhileLinkBeingParsing();
    if (toController.text.isNotEmpty && toController.text != '') {
      if (toController.text.contains(' ') || toController.text.contains('\n')) {
        toController.text = Cleaner.clean(toController.text);
      }
      var data = toController.text.trim();
      var link = Uri.tryParse(data);
      if (link != null && link.queryParameters['q'] != null) {
        try {
          customerLocation = LatLng(
            double.parse(link.queryParameters['q']!.split(',')[0]),
            double.parse(link.queryParameters['q']!.split(',')[1]),
          );
        } catch (e) {
          toController.text =
              await DeepLinksService.extractCoordinatesFromUrl(data);
        }
        setState(() {
          startParseLocation = false;
        });
      } else if (link != null) {
        toController.text =
            await DeepLinksService.extractCoordinatesFromUrl(data);
        setState(() {
          startParseLocation = false;
        });
      } else {
        customerLocation = null;
        setState(() {
          startParseLocation = false;
        });
      }
    } else {
      customerLocation = null;
      setState(() {
        startParseLocation = false;
      });
    }
    if (customerLocation == null) {
      try {
        controller.loadRequest(Uri.parse(toController.text));
      } catch (e) {
        //
      }
      setState(() {
        startParseLocation = false;
      });
    }
    Navigator.of(context).pop();
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
