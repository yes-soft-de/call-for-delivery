import 'package:c4d/module_supplier/model/porfile_model.dart';
import 'package:c4d/module_supplier/ui/screen/supplier_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/ui/widget/captain_profile/custom_captain_profile_tile.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class SupplierProfileLoadedState extends States {
  final SupplierProfileScreenState screenState;
  final String? error;
  final bool empty;
  final ProfileSupplierModel? model;

  SupplierProfileLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }
  @override
  Widget getUI(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getSupplier();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getSupplier();
          });
    }
    return StackedForm(
        child: FixedContainer(
          child: CustomListView.custom(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 175,
                  height: 175,
                  child: Center(
                    child: ClipOval(
                      //   borderRadius: BorderRadius.circular(25),
                      child: Container(
                        width: 175,
                        height: 175,
                        child: CustomNetworkImage(
                          imageSource: model?.image ?? '',
                          width: double.maxFinite,
                          height: double.maxFinite,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColorDark),
                  child: Column(
                    children: [
                      CustomListTile(
                          title: S.of(context).name,
                          subTitle: model?.name,
                          iconData: Icons.person_rounded),
                      CustomListTile(
                          title: S.of(context).phoneNumber,
                          subTitle: model?.phone,
                          iconData: Icons.phone),
                      CustomListTile(
                          title: S.of(context).category,
                          subTitle: model?.supplierCategoryName,
                          iconData: Icons.category),
                      Container(
                        child: ListTileSwitch(
                            switchActiveColor: Colors.green,
                            switchInactiveColor: Colors.red,
                            leading: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.account_box_rounded,
                                      color: Theme.of(context).primaryColor),
                                )),
                            title: Text(
                              S.of(context).status,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              model?.status ?? false
                                  ? S.current.captainStateActive
                                  : S.current.captainStateInactive,
                              style: TextStyle(color: Colors.white),
                            ),
                            value: model?.status ?? false,
                            onChanged: (v) {
                              if (v) {
                                model?.status = true;
                                screenState.enableCaptain(true);
                              } else {
                                model?.status = false;
                                screenState.enableCaptain(false);
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 75,
              )
            ],
          ),
        ),
        label: S.current.update,
        visible: true,
        onTap: () {
//          showDialog(
//              context: context,
//              builder: (_) {
//                return Scaffold(
//                  appBar:
//                      CustomC4dAppBar.appBar(context, title: S.current.update),
//                  body: UpdateCaptainProfile(
//                    request: model,
//                    updateProfile: (request) {
//                      Navigator.of(context).pop();
//                      screenState.updateCaptainProfile(request);
//                    },
//                  ),
//                );
//              });
        });
  }
}
