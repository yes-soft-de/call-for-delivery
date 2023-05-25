import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_dev/request/create_test_order_request.dart';
import 'package:c4d/module_dev/ui/screens/new_test_order/new_test_order_screen.dart';
import 'package:c4d/module_orders/ui/widgets/label_text.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:dropdown_search/dropdown_search.dart';

class NewTestOrderStateBranchesLoaded extends States {
  List<StoresModel> stores;
  List<BranchesModel> branches;
  final NewTestOrderScreenState screenState;
  NewTestOrderStateBranchesLoaded(this.stores, this.branches, this.screenState)
      : super(screenState) {
    if (branches.isNotEmpty) {
      screenState.branch = branches[0].id;
      activeBranch =
          branches.firstWhere((element) => element.id == screenState.branch);
      screenState.refresh();
    }
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool orderIsMain = false;
  BranchesModel? activeBranch;
  @override
  Widget getUI(context) {
    return StackedForm(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ListTile(
                      title: LabelText(S.of(context).store),
                      subtitle: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).backgroundColor),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: DropdownSearch<StoresModel>(
                              enabled: stores.isNotEmpty,
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
                              items: stores,
                              filterFn: (model, filter) {
                                return model.storeOwnerName.contains(filter);
                              },
                              itemAsString: (model) => model.storeOwnerName,
                              onChanged: (v) {
                                v as StoresModel;
                                screenState.packageType = v.packageType;
                                screenState.storeID = v.id;
                                screenState.branch = null;
                                screenState.getBranches(stores);
                                screenState.refresh();
                              },
                              selectedItem: screenState.storeID != null
                                  ? stores.firstWhere((element) =>
                                      element.id == screenState.storeID)
                                  : null), // stores
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
                            color: Theme.of(context).backgroundColor),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: DropdownSearch<BranchesModel>(
                              enabled: branches.isNotEmpty,
                              dropdownBuilder: (context, model) {
                                return Text(
                                  model?.branchName ?? S.current.chooseBranch,
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
                              items: branches,
                              filterFn: (model, filter) {
                                return model.branchName.contains(filter);
                              },
                              itemAsString: (model) => model.branchName,
                              onChanged: (v) {
                                v as BranchesModel;
                                screenState.branch = v.id;
                                activeBranch = branches.firstWhere((element) =>
                                    element.id == screenState.branch);
                                screenState.refresh();
                              },
                              selectedItem: screenState.branch != null
                                  ? branches.firstWhere((element) =>
                                      element.id == screenState.branch)
                                  : null), // stores
                        ),
                      ),
                    ),
                  ],
                ),
                // order count
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomFormField(
                    hintText: S.current.orderCount,
                    controller: screenState.orderCountController,
                    numbers: true,
                  ),
                )
              ],
            ),
          ),
        ),
        label: S.current.createNewOrder,
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                  onPressed: () {
                    if (screenState.storeID != null &&
                        screenState.branch != null &&
                        screenState.orderCountController.text.isNotEmpty) {
                      Navigator.of(context).pop();
                      createOrder();
                    } else {
                      CustomFlushBarHelper.createError(
                              title: S.current.warnning,
                              message: S.current.pleaseCompleteField);
                    }
                  },
                  content: S.current.confirmMakeOrder,
                  oneAction: false,
                );
              });
        });
  }

  // function create order without upload image
  void createOrderWithoutImage() {
    screenState.addNewOrder(CreateTestOrderRequest(
      storeOwner: screenState.storeID,
      branch: screenState.branch,
      orderIsMain: false,
      ordersCount: int.tryParse(screenState.orderCountController.text),
    ));
  }

  void createOrder() {
    createOrderWithoutImage();
  }

  List<DropdownMenuItem<int>> _getStores() {
    var branchDropDown = <DropdownMenuItem<int>>[];
    stores.forEach((element) {
      branchDropDown.add(DropdownMenuItem(
        child: Text(
          element.storeOwnerName,
          overflow: TextOverflow.ellipsis,
        ),
        value: element.id,
      ));
    });
    return branchDropDown;
  }

  List<DropdownMenuItem<int>> _getBranches() {
    var branchDropDown = <DropdownMenuItem<int>>[];
    branches.forEach((element) {
      branchDropDown.add(DropdownMenuItem(
        child: Text(
          element.branchName,
          overflow: TextOverflow.ellipsis,
        ),
        value: element.id,
      ));
    });
    return branchDropDown;
  }
}
