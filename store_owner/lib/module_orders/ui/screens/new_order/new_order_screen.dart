import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state_manager/new_order/new_order.state_manager.dart';
import 'package:c4d/module_orders/ui/state/new_order/new_order.state.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class NewOrderScreen extends StatefulWidget {
  final NewOrderStateManager _stateManager;

  NewOrderScreen(
    this._stateManager,
  );

  @override
  NewOrderScreenState createState() => NewOrderScreenState();
}

class NewOrderScreenState extends State<NewOrderScreen> {
  late States currentState;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void addNewOrder(
    String recipientName,
    String recipientPhone,
  ) {}

  void moveToNext() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      OrdersRoutes.OWNER_ORDERS_SCREEN,
      (r) => false,
    );
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  void initNewOrder() {
    refresh();
  }

  void refresh() {
    setState(() {});
  }

  // New Order state controller
  TextEditingController orderDetailsController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController receiptNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String? payments;
  //
  @override
  void initState() {
    super.initState();
    currentState = NewOrderStateBranchesLoaded([], this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
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
