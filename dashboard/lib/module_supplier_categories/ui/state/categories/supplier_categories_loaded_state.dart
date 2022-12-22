import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_supplier_categories/model/supplier_categories_model.dart';
import 'package:c4d/module_supplier_categories/request/active_category_request.dart';
import 'package:c4d/module_supplier_categories/ui/screen/supplier_categories_screen.dart';
import 'package:c4d/module_supplier_categories/ui/widget/supplier_category_card.dart';
import 'package:c4d/module_supplier_categories/ui/widget/supplier_category_form.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/costom_search.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';

class SupplierCategoriesLoadedState extends States {
  final SupplierCategoriesScreenState screenState;
  final String? error;
  final bool empty;
  final List<SupplierCategoryModel>? model;

  SupplierCategoriesLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.canAddCategories = false;
      screenState.refresh();
    }
  }

  String? search;

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
    return Container(
      width: double.maxFinite,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: CustomListView.custom(children: getCategories(context)),
        ),
      ),
    );
  }

  List<Widget> getCategories(context) {
    List<Widget> widgets = [];
    if (model == null) {
      return widgets;
    }
    if (model!.isEmpty) return widgets;
    for (var element in model ?? <SupplierCategoryModel>[]) {
      if (!element.name.contains(search ?? '') && search != null) {
        continue;
      }

      widgets.add(
        SupplierCategoryCard(
          description: element.description ?? '',
          name: element.name,
          image: element.image ?? '',
          status: element.status ?? false,
          enablePackage: (stat) {
            screenState.enableCategory(
                ActiveCategoryRequest(id: element.id, status: stat));
          },
          onEdit: () {
            showDialog(
                context: context,
                builder: (_) {
                  return SupplierCategoryForm(
                    request: element,
                    onSave: (request) {
                      screenState.updateCategory(request);
                    },
                  );
                });
          },
        ),
      );
    }

    if (model != null) {
      widgets.insert(
          0,
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 16),
            child: CustomDeliverySearch(
              hintText: S.current.search,
              onChanged: (s) {
                if (s == '' || s.isEmpty) {
                  search = null;
                  screenState.refresh();
                } else {
                  search = s;
                  screenState.refresh();
                }
              },
            ),
          ));
    }
    widgets.add(SizedBox(
      height: 50,
    ));
    return widgets;
  }
}
