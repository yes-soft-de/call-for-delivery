import 'package:c4d/module_captain/request/enable_captain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/porfile_model.dart';
import 'package:c4d/module_captain/ui/screen/captain_profile_screen.dart';
import 'package:c4d/module_captain/ui/widget/captain_profile/custom_captain_profile_tile.dart';
import 'package:c4d/module_captain/ui/widget/captain_profile/image_tile.dart';
import 'package:c4d/module_captain/ui/widget/update_captain_widget.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/global/screen_type.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class CaptainProfileLoadedState extends States {
  final CaptainProfileScreenState screenState;
  final String? error;
  final bool empty;
  final ProfileModel? model;

  CaptainProfileLoadedState(this.screenState, this.model,
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
          screenState.getCaptain();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getCaptain();
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
                          title: S.of(context).age,
                          subTitle: model?.age?.toString(),
                          iconData: Icons.calendar_today_rounded),
                      CustomListTile(
                          title: S.of(context).phoneNumber,
                          subTitle: model?.phone,
                          iconData: Icons.phone),
                      CustomListTile(
                          title: S.of(context).car,
                          subTitle: model?.car,
                          iconData: Icons.local_taxi_rounded),
//                      CustomListTile(
//                          title: S.of(context).createDate,
//                          subTitle: model?.createDate,
//                          iconData: Icons.timer_rounded),
//                      CustomListTile(
//                          title: S.of(context).status,
//                          subTitle: model?.isOnline,
//                          iconData: Icons.wifi_rounded),

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
                              S.of(context).captainStatus,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              model?.status == 'active'
                                  ? S.current.captainStateActive
                                  : S.current.captainStateInactive,
                              style: TextStyle(color: Colors.white),
                            ),
                            value: model?.status == 'active',
                            onChanged: (v) {
                              if (v) {
                                model?.status = 'active';
                                screenState.enableCaptain('active');
                              } else {
                                model?.status = 'inactive';
                                screenState.enableCaptain('inactive');
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColorDark),
                  child: Flex(
                    direction: ScreenType.isMobile(context)
                        ? Axis.vertical
                        : Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageTile(
                          title: S.current.identity,
                          image: model?.identity ?? ''),
                      ImageTile(
                          title: S.current.mechanichLicence,
                          image: model?.mechanicLicense ?? ''),
                      ImageTile(
                          title: S.current.driverLicence,
                          image: model?.drivingLicence ?? ''),
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
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return Scaffold(
                  appBar:
                      CustomC4dAppBar.appBar(context, title: S.current.update),
                  body: UpdateCaptainProfile(
                    request: model,
                    updateProfile: (request) {
                      Navigator.of(context).pop();
                      screenState.updateCaptainProfile(request);
                    },
                  ),
                );
              });
        });
  }
}
