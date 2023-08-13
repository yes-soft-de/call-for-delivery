import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_categories/request/active_package_request.dart';
import 'package:c4d/module_categories/ui/widget/category_card.dart';
import 'package:c4d/module_categories/ui/widget/category_form.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/ui/screen/categories_screen.dart';
import 'package:c4d/utils/components/costom_search.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';

class CategoriesLoadedState extends States {
  final CategoriesScreenState screenState;
  final String? error;
  final bool empty;
  final List<PackagesCategoryModel>? model;

  CategoriesLoadedState(this.screenState, this.model,
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
          screenState.getPackagesCategories();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getPackagesCategories();
          });
    }
    return Container(
      width: double.maxFinite,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
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
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: model?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (model != null &&
                        model![index]
                            .categoryName
                            .toLowerCase()
                            .contains(search?.toLowerCase() ?? '')) {
                      return CategoryCard(
                        description: model![index].description ?? '',
                        name: model![index].categoryName,
                        status: model![index].status,
                        onEdit: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return CategoryForm(
                                  request: model![index],
                                  onSave: (request) {
                                    screenState.updateCategory(request);
                                  },
                                );
                              });
                        },
                        onActivate: (status) {
                          model![index].status = status;
                          screenState.refresh();
                          screenState.enableCategories(ActivePackageRequest(
                              id: model![index].id, status: status ? 1 : 0));
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
