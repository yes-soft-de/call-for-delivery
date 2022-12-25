import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/state_manager/search_for_order_state_manager.dart';
import 'package:c4d/module_orders/ui/widgets/filter_bar.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:intl/intl.dart';

@injectable
class SearchForOrderScreen extends StatefulWidget {
  final SearchForOrderStateManager _stateManager;

  SearchForOrderScreen(this._stateManager);

  @override
  SearchForOrderScreenState createState() => SearchForOrderScreenState();
}

class SearchForOrderScreenState extends State<SearchForOrderScreen> {
  late States currentState;
  int currentIndex = 0;
  StreamSubscription? _stateSubscription;

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
    currentState = LoadingState(this);
    ordersFilter = FilterOrderRequest(orderId: '');
    widget._stateManager.getOrdersFilters(this, ordersFilter);
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

  late FilterOrderRequest ordersFilter;
  Future<void> getOrders([bool loading = true]) async {
    widget._stateManager.getOrdersFilters(this, ordersFilter, loading);
  }

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
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            // filter on state
            FilterBar(
              cursorRadius: BorderRadius.circular(25),
              animationDuration: Duration(milliseconds: 350),
              backgroundColor: Theme.of(context).backgroundColor,
              currentIndex: currentIndex,
              borderRadius: BorderRadius.circular(25),
              floating: true,
              height: 40,
              cursorColor: Theme.of(context).colorScheme.primary,
              items: [
                FilterItem(
                  label: S.current.pending,
                ),
                FilterItem(label: S.current.ongoing),
                FilterItem(label: S.current.completed),
                FilterItem(label: S.current.cancelled2),
              ],
              onItemSelected: (index) {
                if (index == 0) {
                  ordersFilter.state = 'pending';
                } else if (index == 1) {
                  ordersFilter.state = 'ongoing';
                } else if (index == 3) {
                  ordersFilter.state = 'cancelled';
                } else {
                  ordersFilter.state = 'delivered';
                }
                currentIndex = index;
                getOrders();
              },
              selectedContent: Theme.of(context).textTheme.button!.color!,
              unselectedContent: Theme.of(context).textTheme.headline6!.color!,
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(child: currentState.getUI(context))
          ],
        ),
      ),
    );
  }
}
