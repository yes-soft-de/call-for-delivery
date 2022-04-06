import 'dart:convert';
import 'package:c4d/abstracts/states/state.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/stores_routes.dart';
import 'package:c4d/module_stores/ui/screen/stores_screen.dart';
import 'package:c4d/module_stores/ui/widget/add_store_widget.dart';
import 'package:c4d/utils/components/costom_search.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/progresive_image.dart';

class StoresLoadedState extends States {
  final StoresScreenState screenState;
  final String? error;
  final bool empty;
  final List<StoresModel>? model;

  StoresLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.canAddCategories = false;
      screenState.refresh();
    }
  }

  String? id;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStores();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getStores();
          });
    }
    return Container(
      width: double.maxFinite,
      child: Center(
        child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: CustomListView.custom(children: getStores())),
      ),
    );
  }

  String? search;
  List<Widget> getStores() {
    List<Widget> widgets = [];
    if (model == null) {
      return widgets;
    }
    if (model!.isEmpty) return widgets;
    for (var element in model!) {
      if (element.storeOwnerName.contains(search ?? '') == false) {
        continue;
      }
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            Navigator.of(screenState.context).pushNamed(StoresRoutes.STORE_INFO,
                arguments: StoresModel(
                    id: element.id,
                    storeOwnerName: element.storeOwnerName,
                    phone: element.phone,
                    status: element.status,
                  imageUrl: element.imageUrl,
                    employeeCount: element.employeeCount
                )
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(screenState.context).colorScheme.primary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: SizedBox(
                      height: 75,
                      width: 75,
                      child: CustomNetworkImage(
                        imageSource: element.imageUrl ?? '',
                        width: 75,
                        height: 75,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: getTile(element.storeOwnerName),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(screenState.context, StoresRoutes.LOGS_ORDERS_SCREEN,arguments: element.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(screenState.context)
                          .backgroundColor
                          .withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.business_center,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16,),
                InkWell(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: screenState.context,
                        builder: (context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Scaffold(
                              appBar: CustomC4dAppBar.appBar(context,
                                  title: S.current.updateStore),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              body: UpdateStoreWidget(
                                storesModel: element,
                                updateStore: (request,haveImage) {
                                  Navigator.of(context).pop();
                                  screenState.updateStore(request,haveImage);
                                },
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(screenState.context)
                          .backgroundColor
                          .withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16,),
              
              ],
            ),
          ),
        ),
      ));
    }
    if (model != null) {
      widgets.insert(
          0,
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 16),
            child: CustomDeliverySearch(
              hintText: S.current.searchForStore,
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
    widgets.add(SizedBox(height: 75));
    return widgets;
  }

  Widget getTile(String text) {
    return Text(text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
  }
}
