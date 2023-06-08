import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/navigator_assistant.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_orders/request/order/pending_order_request.dart';
import 'package:c4d/module_orders/state_manager/order_pending_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';

@injectable
class OrderPendingScreen extends StatefulWidget {
  final OrderPendingStateManager _stateManager;

  OrderPendingScreen(this._stateManager);

  @override
  OrderPendingScreenState createState() => OrderPendingScreenState();
}

class OrderPendingScreenState extends State<OrderPendingScreen> {
  bool isExternalFilterOn = false;
  late States currentState;
  int currentIndex = 0;
  StreamSubscription? _stateSubscription;
  String? companyName;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void goToLogin() {
    Navigator.of(context)
        .pushNamed(AuthorizationRoutes.LOGIN_SCREEN, arguments: 1);
  }

  var today = DateTime.now();
  @override
  void initState() {
    super.initState();
    currentIndex = NavigatorAssistant.nonDeliveringIndex;
    currentState = LoadingState(this);
    widget._stateManager.getPendingOrders(
      this,
      PendingOrderRequest(
        type: isExternalFilterOn
            ? PendingOrderRequestType.onlyExternal
            : PendingOrderRequestType.all,
      ),
    );
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }

  Future<void> getOrders([bool loading = true]) async {
    widget._stateManager.getPendingOrders(
        this,
        PendingOrderRequest(
          type: isExternalFilterOn
              ? PendingOrderRequestType.onlyExternal
              : PendingOrderRequestType.all,
        ),
        loading);
  }

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      var arg = ModalRoute.of(context)?.settings.arguments as List?;
      if (arg != null && arg.length > 0) {
        companyName = arg[0] as String;
        print(companyName);
      }
    }

    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
          appBar: CustomC4dAppBar.appBar(context,
              title: companyName.notNullOrEmpty()
                  ? S.current.externalOrders
                  : S.current.orders,
              icon: companyName.notNullOrEmpty() ? null : Icons.menu,
              onTap: companyName.notNullOrEmpty()
                  ? null
                  : () {
                      GlobalVariable.mainScreenScaffold.currentState
                          ?.openDrawer();
                    },
              actions: companyName.notNullOrEmpty()
                  ? null
                  : [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            children: [
                              Text(
                                S.current.onlyExternal,
                              ),
                              SizedBox(width: 5),
                              Switch(
                                activeTrackColor: Color(0xff60CF86),
                                value: isExternalFilterOn,
                                onChanged: (value) {
                                  isExternalFilterOn = value;
                                  getOrders();
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
          body: currentState.getUI(context)),
    );
  }
}
