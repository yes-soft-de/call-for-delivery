import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/state_manager/new_order_link_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/link_cleaner.dart';
import 'package:c4d/utils/helpers/phone_number_detection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../module_deep_links/request/geo_distance_request.dart';

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
  int? costType;
  late WebViewController controller;
  bool startParseLocation = false;

  GeoDistanceRequest request = GeoDistanceRequest();
  int callGeoAgin = 0;

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
    countryNumberController.text = '966';
    widget._stateManager.getBranches(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    var old = toController.text;
    toController.addListener(() {
      if (_ignoreUnnecessaryCall(toController.text)) return;

      request.link = toController.text.trim();
      canCallForLocation = true;
      callGeoAgin++;

      refresh();
    });
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            print('started ---------------------------> $url');
          },
          onPageFinished: (String url) {
            print('finished ---------------------------> $url');
            customerLocation =
                DeepLinksService.getCustomerLocationFromRedirectedUrl(url);
            if (customerLocation != null) {
              refresh();
            }
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      );
  }

  void showLoadingIndicatorOverlayToPreventPressingWhileLinkBeingParsing() {
    showDialog(
        barrierDismissible: false,
        context: context,
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
  int orderId = -1;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && currentState is LoadingState && flag) {
      if (args is OrderModel) {
        orderId = args.id;
        branch = args.branchID;
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
