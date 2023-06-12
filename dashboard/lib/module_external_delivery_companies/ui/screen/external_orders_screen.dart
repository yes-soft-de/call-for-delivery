import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_external_delivery_companies/model/company_model.dart';
import 'package:c4d/module_external_delivery_companies/state_manager/external_orders_state_manager.dart';
import 'package:c4d/module_orders/request/order/pending_order_request.dart';
import 'package:c4d/module_orders/ui/widgets/label_text.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

@injectable
class ExternalOrderScreen extends StatefulWidget {
  final ExternalOrdersStateManager _stateManager;

  const ExternalOrderScreen(this._stateManager);

  @override
  State<ExternalOrderScreen> createState() => ExternalOrderScreenState();
}

class ExternalOrderScreenState extends State<ExternalOrderScreen> {
  late States currentState;
  late CompanyModel company;
  int currentIndex = 0;
  final PendingOrderRequest filter = PendingOrderRequest(
    type: PendingOrderRequestType.onlyExternal,
  );

  ValueNotifier<List<StoresModel>> stores = ValueNotifier([]);
  ValueNotifier<List<BranchesModel>> branches = ValueNotifier([]);
  StoresModel? selectedStore;
  BranchesModel? selectedBranch;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription? _stateSubscription;

  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<void> getOrders([bool loading = true]) async {
    widget._stateManager.getPendingOrders(
      this,
      filter,
      loading,
    );
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

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      var arg = ModalRoute.of(context)?.settings.arguments as List;
      if (arg.length > 0) {
        company = arg[0] as CompanyModel;
        filter.externalCompanyId = company.id;
        getOrders();
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
            title: S.current.externalOrders,
            actions: [
              CustomC4dAppBar.actionIcon(
                context,
                icon: Icons.search,
                onTap: () {
                  _getStores();
                  _showSearchDialog(context);
                },
              ),
            ]),
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
                        // filter date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            // date picker
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
                              filter.fromDate = value;
                              setState(() {});
                              getOrders();
                            }
                          });
                        },
                        title: Text(S.current.firstDate),
                        subtitle: Text(filter.fromDate != null
                            ? DateFormat('yyyy/M/d')
                                .format(filter.fromDate ?? DateTime.now())
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
                              filter.toDate = DateTime(
                                value.year,
                                value.month,
                                value.day,
                              );
                              setState(() {});
                              getOrders();
                            }
                          });
                        },
                        title: Text(S.current.endDate),
                        subtitle: Text(filter.toDate != null
                            ? DateFormat('yyyy/M/d')
                                .format(filter.toDate ?? DateTime.now())
                            : '0000/00/00'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: AnimatedContainer(
                          height: 40,
                          padding: EdgeInsets.all(8),
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: currentIndex != 0
                                    ? Colors.grey
                                    : Colors.white,
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
                          child: InkWell(
                            splashFactory: NoSplash.splashFactory,
                            onTap: () {
                              currentIndex = 0;
                              refresh();
                            },
                            child: Text(
                              S.current.pending,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: currentIndex != 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
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
                              color: currentIndex == 1
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.background),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                          child: InkWell(
                            splashFactory: NoSplash.splashFactory,
                            onTap: () {
                              currentIndex = 1;
                              refresh();
                            },
                            child: Text(
                              S.current.notAccepted,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: currentIndex != 1
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                            ),
                          ),
                          // Text(S.current.hidden),
                        ),
                      ),
                      Expanded(
                        child: AnimatedContainer(
                          height: 40,
                          padding: EdgeInsets.all(8),
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: currentIndex != 2
                                      ? Colors.grey
                                      : Colors.white,
                                  width: 1),
                              borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(25),
                                  bottomEnd: Radius.circular(25)),
                              color: currentIndex == 2
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.background),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                          child: InkWell(
                            splashFactory: NoSplash.splashFactory,
                            onTap: () {
                              currentIndex = 2;
                              refresh();
                            },
                            child: Text(
                              S.current.completed,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: currentIndex != 2
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                            ),
                          ),
                          // Text(S.current.hidden),
                        ),
                      ),
                    ]),
              ),
              Expanded(child: Center(child: currentState.getUI(context))),
            ],
          ),
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
                                filter.storeOwnerProfileId =
                                    selectedStore?.id.toString() ?? null;
                                filter.storeBranchId = null;
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
                                  filter.storeBranchId =
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
                            filter.storeOwnerProfileId = null;
                            filter.storeBranchId = null;
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
