import 'package:c4d/hive/util/argument_hive_helper.dart';
import 'package:c4d/module_captain/captains_routes.dart';
import 'package:c4d/module_captain/request/captain_finance_request.dart';
import 'package:c4d/module_captain/ui/widget/captain_control_widget.dart';
import 'package:c4d/module_captain/ui/widget/captain_profile/captain_finance_info.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/widgets/filter_bar.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class CaptainProfileLoadedState extends States {
  final CaptainProfileScreenState screenState;
  final String? error;
  final bool empty;
  ProfileModel? model;

  CaptainProfileLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }
  @override
  Widget getUI(BuildContext context) {
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
    return FixedContainer(
        child: Column(
      children: [
        FilterBar(
          cursorRadius: BorderRadius.circular(25),
          animationDuration: Duration(milliseconds: 350),
          backgroundColor: Theme.of(context).backgroundColor,
          currentIndex: screenState.currentIndex,
          borderRadius: BorderRadius.circular(25),
          floating: true,
          height: 40,
          cursorColor: Theme.of(context).colorScheme.primary,
          items: [
            FilterItem(
              label: S.current.accountInfo,
            ),
            FilterItem(label: S.current.accountManaging),
          ],
          onItemSelected: (index) {
            screenState.currentIndex = index;
            screenState.refresh();
          },
          selectedContent: Theme.of(context).textTheme.button!.color!,
          unselectedContent: Theme.of(context).textTheme.headline6!.color!,
        ),
        SizedBox(
          height: 8,
        ),
        Expanded(
          child: CustomListView.custom(
            children: [
              // image profile
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: SizedBox(
                    height: 175,
                    child: CustomNetworkImage(
                      imageSource: model?.image ?? '',
                      width: double.maxFinite,
                      height: double.maxFinite,
                    ),
                  ),
                ),
              ),
              Visibility(
                replacement: getManageUI(context),
                visible: screenState.currentIndex == 0,
                child: Column(
                  children: [
                    // info
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).colorScheme.primary),
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
                              iconData: Icons.phone,
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: model?.verificationStatus == true
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      model?.verificationStatus == true
                                          ? S.current.accountVerified
                                          : S.current.accountUnVerified,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CustomListTile(
                                title: S.of(context).car,
                                subTitle: model?.car,
                                iconData: Icons.local_taxi_rounded),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).colorScheme.primary),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ImageTile(
                                    title: S.current.identity,
                                    image: model?.identity ?? ''),
                                Spacer(),
                                ImageTile(
                                    title: S.current.mechanichLicence,
                                    image: model?.mechanicLicense ?? ''),
                              ],
                            ),
                            ImageTile(
                                title: S.current.driverLicence,
                                image: model?.drivingLicence ?? ''),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return Scaffold(
                                    appBar: CustomC4dAppBar.appBar(context,
                                        title: S.current.update),
                                    body: UpdateCaptainProfile(
                                      request: model,
                                      updateProfile: (request) {
                                        Navigator.of(context).pop();
                                        screenState
                                            .updateCaptainProfile(request);
                                      },
                                    ),
                                  );
                                });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              S.current.updatePersonalInformation,
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }

  String getCaptainType(int? captainFinancialSystemType) {
    if (captainFinancialSystemType == null) {
      return S.current.unknown;
    } else {
      if (captainFinancialSystemType == 1) return S.current.financeByHours;
      if (captainFinancialSystemType == 2) return S.current.financeByOrders;
      if (captainFinancialSystemType == 3) return S.current.financeCountOrder;
      return S.current.unknown;
    }
  }

  Widget getManageUI(context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(25)),
            child: ListTileSwitch(
                switchActiveColor: Colors.green,
                switchInactiveColor: Colors.red,
                leading: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).scaffoldBackgroundColor,
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
                    screenState.refresh();
                    screenState.enableCaptain('active');
                  } else {
                    model?.status = 'inactive';
                    screenState.refresh();
                    screenState.enableCaptain('inactive');
                  }
                }),
          ),
        ),
        CaptainControlWidget(
          icon: Icons.account_balance_wallet_rounded,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return Scaffold(
                    appBar: CustomC4dAppBar.appBar(context,
                        title: S.current.FinanceRequest),
                    body: CaptainFinanceInfo(
                      captainID: screenState.captainId,
                      details: model!.captainFinance!,
                      requestStatus: (status) {
                        Navigator.of(context).pop();
                        screenState.enableCaptainFinance(CaptainFinanceRequest(
                          // planId: model?.captainFinance?.id,
                          // planType: model?.captainFinance
                          //     ?.captainFinancialSystemType,
                          id: model?.captainFinance?.id,
                          status: status,
                        ));
                      },
                    ),
                  );
                });
          },
          title: S.of(context).captainFinance,
          active: model?.captainFinance?.status,
        ),
        CaptainControlWidget(
          icon: Icons.money,
          onPressed: () {
            ArgumentHiveHelper()
                .setCurrentCaptainID(screenState.captainId.toString());
            Navigator.of(context).pushNamed(OrdersRoutes.ORDER_CASH_CAPTAINS);
          },
          title: S.of(context).cashOrders,
        ),
        CaptainControlWidget(
          icon: FontAwesomeIcons.boxes,
          onPressed: () {
            ArgumentHiveHelper()
                .setCurrentCaptainID(screenState.captainId.toString());
            Navigator.of(context).pushNamed(OrdersRoutes.CAPTAIN_ORDERS_SCREEN);
          },
          title: S.of(context).orderLog,
        ),
        CaptainControlWidget(
          icon: Icons.chat,
          onPressed: () {
            Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                arguments: ChatArgument(
                    roomID: model?.roomId ?? '',
                    userType: model?.captainId.toString()));
          },
          title: S.of(context).chatRoom,
        ),
        CaptainControlWidget(
          icon: Icons.balance,
          onPressed: () {
            Navigator.of(context).pushNamed(CaptainsRoutes.CAPTAIN_BALANCE,
                arguments: screenState.captainId);
          },
          title: S.of(context).accountBalance,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 64.0),
            child: Container(
              height: 150,
              width: 2.5,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).colorScheme.error,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    S.current.dangerZone,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    S.current.DeletingYourAccountHint,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return CustomAlertDialog(
                                  oneAction: false,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    screenState.stateManager
                                        .deleteCaptainProfile(
                                            screenState,
                                            model?.captainId.toString() ??
                                                '-1');
                                  },
                                  content: S
                                      .current.areSureAboutDeletingYourAccount);
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          S.current.deleteAccount,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
