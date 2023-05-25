import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/state_manager/order_distance_conflict_state_manager.dart';
import 'package:c4d/module_orders/ui/widgets/label_text.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';

@injectable
class OrderDistanceConflictScreen extends StatefulWidget {
  final OrderDistanceConflictStateManager _stateManager;

  OrderDistanceConflictScreen(this._stateManager);

  @override
  OrderDistanceConflictScreenState createState() =>
      OrderDistanceConflictScreenState();
}

class OrderDistanceConflictScreenState
    extends State<OrderDistanceConflictScreen> {
  late States currentState;

  ValueNotifier<List<StoresModel>> stores = ValueNotifier([]);
  ValueNotifier<List<BranchesModel>> branches = ValueNotifier([]);
  StoresModel? selectedStore;
  BranchesModel? selectedBranch;

  int currentIndex = 0;
  StreamSubscription? _stateSubscription;
  OrderDistanceConflictStateManager get manager => widget._stateManager;
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  var today = DateTime.now();
  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this);
    ordersFilter = FilterOrderRequest(
        isResolved: currentIndex == 0 ? false : true,
        fromDate: DateTime(today.year, today.month, today.day, 0),
        toDate: DateTime.now());
    widget._stateManager.getOrdersFilters(this, ordersFilter);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  _getStores() {
    getIt<StoresService>().getStores().then((value) {
      if (value.hasError) {
      } else if (value.isEmpty) {
      } else {
        value as StoresModel;
        stores.value = value.data;
      }
    });
  }

  _getBranches(int storeID) {
    getIt<BranchesListService>().getBranches(storeID.toString()).then((value) {
      if (value.hasError) {
      } else if (value.isEmpty) {
      } else {
        value as BranchesModel;
        branches.value = value.data;
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
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.conflictDistances, icon: Icons.menu, onTap: () {
          GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
        }, actions: [
          CustomC4dAppBar.actionIcon(
            context,
            icon: Icons.search,
            onTap: () {
              _getStores();
              _showSearchDialog(context);
            },
          ),
          CustomC4dAppBar.actionIcon(
            context,
            onTap: () {
              ordersFilter.fromDate =
                  DateTime(today.year, today.month, today.day, 0);
              ordersFilter.toDate = DateTime.now();
              currentIndex = 0;
              ordersFilter.state = 'pending';
              getOrders();
            },
            icon: Icons.restart_alt_rounded,
          ),
        ]),
        body: Column(
          children: [
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      currentIndex = 0;
                      ordersFilter.isResolved = false;
                      getOrders();
                    },
                    child: AnimatedContainer(
                      height: 40,
                      padding: EdgeInsets.all(8),
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                currentIndex != 0 ? Colors.grey : Colors.white,
                            width: 1),
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(25),
                            bottomStart: Radius.circular(25)),
                        color: currentIndex == 0
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.background,
                      ),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      child: Text(
                        S.current.newOrders,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color:
                              currentIndex != 0 ? Colors.black : Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      currentIndex = 1;
                      ordersFilter.isResolved = true;
                      getOrders();
                    },
                    child: AnimatedContainer(
                      height: 40,
                      padding: EdgeInsets.all(8),
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: currentIndex != 1
                                  ? Colors.grey
                                  : Colors.white,
                              width: 1),
                          borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(25),
                              bottomEnd: Radius.circular(25)),
                          color: currentIndex == 1
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.background),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      child: Text(
                        S.current.previousOrder,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color:
                              currentIndex != 1 ? Colors.black : Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                      ),
                      // Text(S.current.hidden),
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(height: 8),
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
                        color: Theme.of(context).colorScheme.background,
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
                                ordersFilter.fromDate = value;
                                setState(() {});
                                getOrders();
                              }
                            });
                          },
                          title: Text(S.current.firstDate),
                          subtitle: Text(ordersFilter.fromDate != null
                              ? DateFormat('yyyy/M/d').format(
                                  ordersFilter.fromDate ?? DateTime.now())
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
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).colorScheme.background,
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
                                ordersFilter.toDate = value;
                                setState(() {});
                                getOrders();
                              }
                            });
                          },
                          title: Text(S.current.endDate),
                          subtitle: Text(ordersFilter.toDate != null
                              ? DateFormat('yyyy/M/d')
                                  .format(ordersFilter.toDate ?? DateTime.now())
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
            Expanded(child: currentState.getUI(context))
          ],
        ),
      ),
    );
  }

  _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.current.searchForStore,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: LabelText(S.of(context).store),
                    subtitle: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).colorScheme.background),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: ValueListenableBuilder(
                          valueListenable: stores,
                          builder: (context, value, child) {
                            return DropdownSearch<StoresModel>(
                              enabled: stores.value.isNotEmpty,
                              dropdownBuilder: (context, model) {
                                return Text(
                                  model?.storeOwnerName ??
                                      S.current.chooseStore,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                );
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(0, 12, 0, 0))),
                              dropdownButtonProps: DropdownButtonProps(),
                              popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                  menuProps: MenuProps(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                          hintText: S.current.chooseStore,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25))))),
                              items: stores.value,
                              filterFn: (model, filter) {
                                return model.storeOwnerName.contains(filter);
                              },
                              itemAsString: (model) => model.storeOwnerName,
                              onChanged: (v) {
                                v as StoresModel;
                                selectedStore = v;
                                selectedBranch = null;
                                branches.value = [];
                                _getBranches(v.id);
                                ordersFilter.storeOwnerProfileId =
                                    selectedStore?.id.toString() ?? null;
                                ordersFilter.storeBranchId = null;
                              },
                              selectedItem: selectedStore,
                            );
                          },
                        ), // stores
                      ),
                    ),
                  ),
                ],
              ),
              // branches
              Column(
                children: [
                  ListTile(
                    title: LabelText(S.of(context).branch),
                    subtitle: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).colorScheme.background),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: ValueListenableBuilder(
                          valueListenable: branches,
                          builder: (context, value, child) {
                            return DropdownSearch<BranchesModel>(
                                enabled: branches.value.isNotEmpty,
                                dropdownBuilder: (context, model) {
                                  return Text(
                                    model?.branchName ?? S.current.chooseBranch,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  );
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(0, 12, 0, 0))),
                                dropdownButtonProps: DropdownButtonProps(),
                                popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    menuProps: MenuProps(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                            hintText: S.current.chooseStore,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25))))),
                                items: branches.value,
                                filterFn: (model, filter) {
                                  return model.branchName.contains(filter);
                                },
                                itemAsString: (model) => model.branchName,
                                onChanged: (v) {
                                  v as BranchesModel;
                                  selectedBranch = v;
                                  ordersFilter.storeBranchId =
                                      selectedBranch?.id.toString() ?? null;
                                },
                                selectedItem: selectedBranch);
                          },
                        ), // stores
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 45,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text(S.current.confirm),
                          onPressed: () {
                            getOrders();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: ElevatedButton(
                          child: Text(S.current.cancel),
                          onPressed: () {
                            ordersFilter.storeOwnerProfileId = null;
                            ordersFilter.storeBranchId = null;
                            selectedBranch = null;
                            selectedStore = null;
                            getOrders();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10)
            ],
          ),
        );
      },
    );
  }
}
