import 'package:c4d/module_categories/model/packages_model.dart';
import 'package:c4d/module_categories/request/active_package_request.dart';
import 'package:c4d/module_categories/ui/widget/package_card.dart';
import 'package:c4d/module_categories/ui/widget/package_form.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_categories/ui/screen/packages_screen.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';

class PackagesLoadedState extends States {
  final PackagesScreenState screenState;
  final List<PackagesCategoryModel>? categories;
  List<PackagesModel>? packages;
  final String? error;
  final bool empty;

  PackagesLoadedState(this.screenState, this.categories, this.packages,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.canAddPackage = false;
      screenState.refresh();
    }
  }

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getCategories();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getCategories();
          });
    }
    return FixedContainer(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                //color: Theme.of(context).backgroundColor,
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 4)),
            child: Center(
              child: DropdownButton(
                value: screenState.id,
                items: getChoices(),
                onChanged: (v) {
                  screenState.id = v.toString();
                  screenState.getPackagesCategories(
                      int.parse(screenState.id ?? '-1'), categories ?? []);
                },
                hint: Text(
                  S.current.chooseCategory,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                underline: SizedBox(),
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.arrow_drop_down_rounded),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: CustomListView.custom(children: getProducts(context)),
        )
      ],
    ));
  }

  List<Widget> getProducts(BuildContext context) {
    List<Widget> widgets = [];
    if (packages == null) {
      return widgets;
    }

    if (packages!.isEmpty) return widgets;
    for (var element in packages!) {
//      if (id != null && id != element.) {
//        continue;
//      }
      widgets.add(SinglePackageCard(
        carsCount: element.carCount.toString(),
        ordersCount: element.orderCount.toString(),
        packageInfo: element.note,
        packageName: element.name,
        cost: element.cost.toString(),
        expaired: element.expired.toString(),
        city: element.city,
        status: element.status,
        edit: () {
          showDialog(
              context: context,
              builder: (_) {
                return PackageForm(
                  request: element,
                  onSave: (request) {
                    request.packageCategoryID =
                        int.tryParse(screenState.id ?? '');
                    screenState.updatePakage(request);
                  },
                );
              });
        },
        enablePackage: (status) {
          element.status = status;
          screenState.refresh();
          screenState.enablePackage(
              ActivePackageRequest(status: status, id: element.id), false);
        },
        extraCost: element.extraCost?.toString() ?? '',
        geographicalRange: element.geographicalRange?.toString() ?? '',
        type: element.type.toInt(),
      ));
    }
    widgets.add(SizedBox(
      height: 100,
    ));
    return widgets;
  }

  List<DropdownMenuItem<String>> getChoices() {
    List<DropdownMenuItem<String>> items = [];
    categories?.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.id.toString(),
        child: Text(element.categoryName),
      ));
    });
    return items;
  }
}
