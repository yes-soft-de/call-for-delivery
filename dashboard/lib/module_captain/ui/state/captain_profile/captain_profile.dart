import 'package:c4d/hive/util/argument_hive_helper.dart';
import 'package:c4d/module_captain/request/captain_finance_request.dart';
import 'package:c4d/module_captain/request/enable_captain.dart';
import 'package:c4d/module_captain/ui/widget/captain_profile/captain_finance_info.dart';
import 'package:c4d/module_orders/orders_routes.dart';
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
                      Container(
                        child: ListTile(
                          onTap: () {
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
                                        screenState.enableCaptainFinance(
                                            CaptainFinanceRequest(
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
                          leading: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                    Icons.account_balance_wallet_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              )),
                          title: Text(
                            S.of(context).captainFinance,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            getCaptainType(model
                                ?.captainFinance?.captainFinancialSystemType),
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: PhysicalModel(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              elevation: 5,
                              shape: BoxShape.circle,
                              child: Icon(
                                Icons.circle,
                                color: model?.captainFinance?.status == true
                                    ? Colors.green
                                    : Colors.red,
                                size: 30,
                              )),
                        ),
                      ),
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
                                screenState.refresh();
                                screenState.enableCaptain('active');
                              } else {
                                model?.status = 'inactive';
                                screenState.refresh();
                                screenState.enableCaptain('inactive');
                              }
                            }),
                      ),
                      InkWell(
                        onTap: () {
                          ArgumentHiveHelper().setCurrentCaptainID(
                              screenState.captainId.toString());
                          Navigator.of(context)
                              .pushNamed(OrdersRoutes.ORDER_CASH_CAPTAINS);
                        },
                        child: CustomListTile(
                            title: S.of(context).cashOrders,
                            subTitle: '',
                            leading: Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                            ),
                            iconData: Icons.money),
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
                      color: Theme.of(context).colorScheme.primary),
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
                                        content: S.current
                                            .areSureAboutDeletingYourAccount);
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
}
