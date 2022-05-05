import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_order/request/notice_request.dart';
import 'package:c4d/module_bid_order/state_manager/bid_order_state_manager.dart';
import 'package:c4d/module_bid_order/ui/widget/filter_bar.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class BidOrdersScreen extends StatefulWidget {
  final BidOrderStateManager _stateManager;

  BidOrdersScreen(this._stateManager);

  @override
  BidOrdersScreenState createState() => BidOrdersScreenState();
}

class BidOrdersScreenState extends State<BidOrdersScreen> {
  late States _currentState;
  StreamSubscription? _stateSubscription;



 void getBidOrdersFilters()  {
    widget._stateManager.getBidOrder(
        this,ordersFilter);
  }

 bool openToPriceOffer=true;
  int currentIndex = 0;
  var today = DateTime.now();
  int? storeID = -1;
  late FilterBidOrderRequest ordersFilter;

  @override
  void initState() {
    super.initState();
    _currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    if (storeID == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        storeID = arg;
        ordersFilter = FilterBidOrderRequest(
            storeId: storeID,
            fromDate: DateTime(today.year, today.month, today.day, 0)
                .toIso8601String(),
            toDate: DateTime.now().toIso8601String(),openToPriceOffer: openToPriceOffer);
        widget._stateManager.getBidOrder(this, ordersFilter);
      }
    }
    return  Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.orderLog,
      ),
      body: Column(
        children: [
          // filter date
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        onTap: () {
                          showDatePicker(
                              context: context,
                              builder: (context, widget) {
                                bool isDark =
                                getIt<ThemePreferencesHelper>()
                                    .isDarkMode();

                                if (isDark == false)
                                  return widget ?? SizedBox();
                                return Theme(
                                    data: ThemeData.dark().copyWith(
                                        primaryColor: Colors.indigo),
                                    child: widget ?? SizedBox());
                              },
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime.now())
                              .then((value) {
                            if (value != null) {
                              ordersFilter.fromDate = value.toIso8601String();
                              setState(() {});
                              getBidOrdersFilters();
                            }
                          });
                        },
                        title: Text(S.current.firstDate),
                        subtitle: Text(ordersFilter.fromDate != null
                            ? DateFormat('yyyy/M/d').format(DateTime.parse(
                            ordersFilter.fromDate ??
                                DateTime.now().toIso8601String()))
                            : '0000/00/00'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 32,
                    height: 2.5,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              builder: (context, widget) {
                                bool isDark =
                                getIt<ThemePreferencesHelper>()
                                    .isDarkMode();
                                if (isDark == false)
                                  return widget ?? SizedBox();
                                return Theme(
                                    data: ThemeData.dark().copyWith(
                                        primaryColor: Colors.indigo),
                                    child: widget ?? SizedBox());
                              },
                              firstDate: DateTime(2021),
                              lastDate: DateTime.now())
                              .then((value) {
                            if (value != null) {
                              ordersFilter.toDate = value.toIso8601String();
                              setState(() {});
                              getBidOrdersFilters();
                            }
                          });
                        },
                        title: Text(S.current.endDate),
                        subtitle: Text(ordersFilter.toDate != null
                            ? DateFormat('yyyy/M/d').format(DateTime.parse(
                            ordersFilter.toDate ??
                                DateTime.now().toIso8601String()))
                            : '0000/00/00'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          FilterBar(
            cursorRadius: BorderRadius.circular(25),
            animationDuration: Duration(milliseconds: 350),
            backgroundColor: Theme.of(context).backgroundColor,
            currentIndex: currentIndex,
            borderRadius: BorderRadius.circular(25),
            floating: true,
            height: 40,
            items: [
              FilterItem(label: S.current.open),
              FilterItem(label: S.current.close),
            ],
            onItemSelected: (index) {
              if (index == 0) {
                ordersFilter.openToPriceOffer=true;
              } else  if (index == 1){
                ordersFilter.openToPriceOffer=false;
              }
              currentIndex = index;
              getBidOrdersFilters();
            },
            selectedContent: Theme.of(context).textTheme.button!.color!,
            unselectedContent: Theme.of(context).textTheme.headline6!.color!,
            cursorColor: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: Container(child: _currentState.getUI(context))),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }

}
