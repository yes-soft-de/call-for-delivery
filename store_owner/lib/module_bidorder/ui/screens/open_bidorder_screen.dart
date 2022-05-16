import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bidorder/request/filter_bidorder_request.dart';
import 'package:c4d/module_bidorder/state_manager/open_order_state_manager.dart';
import 'package:c4d/module_orders/ui/widgets/filter_bar.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OpenBidOrderScreen extends StatefulWidget {
  final OpenBidOrderStateManager _stateManager;

  OpenBidOrderScreen(this._stateManager);

  @override
  OpenBidOrderScreenState createState() => OpenBidOrderScreenState();
}

class OpenBidOrderScreenState extends State<OpenBidOrderScreen> {
  late States _currentState;
  StreamSubscription? _stateSubscription;
  int currentIndex = 0;
  FilterBidOrderRequest request = FilterBidOrderRequest();
  @override
  void initState() {
    super.initState();
    _currentState = LoadingState(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.getOpenOrdersFilters(this, request);
  }

  void getOrders() {
    widget._stateManager.getOpenOrdersFilters(this, request);
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
        appBar: CustomC4dAppBar.appBar(context, title: S.current.openOrder),
        body: SafeArea(
          child: Column(
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
                  FilterItem(label: S.current.openOrder),
                  FilterItem(label: S.current.waitingSupplier),
                  FilterItem(label: S.current.waitingCaptain),
                  FilterItem(label: S.current.ongoing),
                ],
                onItemSelected: (index) {
                  if (index == 0) {
                    request.openToPriceOffer = true;
                    request.state = null;
                  } else if (index == 1) {
                    request.openToPriceOffer = false;
                    request.state = 'initialized';
                  }
                  else if (index == 2) {
                    request.openToPriceOffer = false;
                    request.state = 'pending';
                  }
                  else if (index == 3) {
                    request.openToPriceOffer = false;
                    request.state = 'ongoing';
                  }
                  currentIndex = index;
                  getOrders();
                },
                selectedContent: Theme.of(context).textTheme.button!.color!,
                unselectedContent:
                    Theme.of(context).textTheme.headline6!.color!,
              ),
              Expanded(child: _currentState.getUI(context)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
