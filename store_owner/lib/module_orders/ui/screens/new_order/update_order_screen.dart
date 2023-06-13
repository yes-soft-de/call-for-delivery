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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

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
      if (!toController.text.contains('http')) {
        toController.clear();
        Fluttertoast.showToast(msg: S.current.invalidMapLink);
      }
    });
  }

  void locationParsing() async {
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
      } else if (link != null) {
        toController.text =
            await DeepLinksService.getFirebaseDynamicLinkData(data);
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
