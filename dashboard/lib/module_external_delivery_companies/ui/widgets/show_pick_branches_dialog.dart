import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

Future<List<BranchesModel>?> showPickBranchDialog(BuildContext context) async {
  ValueNotifier<List<StoresModel>> stores = ValueNotifier([]);
  ValueNotifier<List<BranchesModel>> branches = ValueNotifier([]);

  StoresModel? selectedStore;
  List<BranchesModel>? selectedBranches;

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

  if (stores.value.isEmpty) {
    _getStores();
  }
  return (showDialog<List<BranchesModel>>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Color(0xff024D92),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Stores
              Container(
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
                            model?.storeOwnerName ?? S.current.chooseStore,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          );
                        },
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
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
                          selectedStore = v;
                          _getBranches(selectedStore?.id ?? -1);
                        },
                        selectedItem: selectedStore,
                      );
                    },
                  ), // stores
                ),
              ),
              // branches
              SizedBox(height: 20),
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.background),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: ValueListenableBuilder(
                    valueListenable: branches,
                    builder: (context, value, child) {
                      return DropdownSearch<BranchesModel>.multiSelection(
                        enabled: branches.value.isNotEmpty,
                        dropdownBuilder: (context, model) {
                          return Text(
                            S.current.chooseBranch,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          );
                        },
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                          ),
                        ),
                        dropdownButtonProps: DropdownButtonProps(),
                        items: branches.value,
                        filterFn: (model, filter) {
                          return model.branchName.contains(filter);
                        },
                        itemAsString: (model) => model.branchName,
                        onChanged: (value) {
                          selectedBranches = value;
                          Navigator.pop(context, selectedBranches);
                        },
                        popupProps: PopupPropsMultiSelection.menu(
                          showSearchBox: true,
                          menuProps: MenuProps(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              hintText: S.current.chooseStore,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ), // stores
                ),
              ),

              SizedBox(height: 10)
            ],
          ),
        ),
      );
    },
  ));
}
