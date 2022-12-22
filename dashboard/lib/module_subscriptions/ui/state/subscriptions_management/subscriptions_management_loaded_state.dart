import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/subscriptions_routes.dart';
import 'package:c4d/module_subscriptions/ui/screen/subscriptions_managment_screen.dart';
import 'package:c4d/module_subscriptions/ui/widget/bottom_sheet_sub_management/bottom_sheet_renew_sub.dart';
import 'package:c4d/module_subscriptions/ui/widget/control_widget.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:flutter/material.dart';

class SubscriptionManagementStateLoaded extends States {
  final SubscriptionManagementScreenState screenState;
  SubscriptionManagementStateLoaded(this.screenState) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: [
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 16,
        children: [
          ControlWidget(
            icon: Icons.subscriptions_rounded,
            onPressed: () {
              Navigator.of(context).pushNamed(
                  SubscriptionsRoutes.SUBSCRIPTIONS_DUES_SCREEN,
                  arguments: screenState.profileId!.id);
            },
            title: S.current.currentSubscriptions,
          ),
          ControlWidget(
            icon: Icons.play_disabled_rounded,
            onPressed: () {
              Navigator.of(context).pushNamed(
                  SubscriptionsRoutes.SUBSCRIPTIONS_EXPIRED_DUES_SCREEN,
                  arguments: screenState.profileId!.id);
            },
            title: S.current.endedSubscriptions,
          ),
          ControlWidget(
            icon: Icons.create_new_folder_rounded,
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return BottomSheetRenewSubscription(
                      packageExtend: () {
                        Navigator.of(context).pop();
                        screenState.stateManager.extendPackage(
                            screenState, screenState.profileId!.id);
                      },
                      renewNewPlan: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(
                            SubscriptionsRoutes.CREATE_NEW_SUBSCRIPTION_SCREEN,
                            arguments: screenState.profileId!.id);
                      },
                      renewOldPlan: () {
                        Navigator.of(context).pop();
                        screenState.stateManager.renewPackage(
                            screenState, screenState.profileId!.id);
                      },
                      captainOffer: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(
                            SubscriptionsRoutes
                                .CREATE_NEW_SUBSCRIPTION_TO_CAPTAIN_OFFER_SCREEN,
                            arguments: screenState.profileId?.storeId);
                      },
                    );
                  });
            },
            title: S.current.createSubscription,
          ),
          ControlWidget(
            icon: Icons.delete_sweep_rounded,
            color: Theme.of(context).colorScheme.error,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return CustomAlertDialog(
                        onPressed: () {
                          Navigator.of(context).pop();
                          screenState.stateManager.deleteFutureSubscriptions(
                              screenState, screenState.profileId!.id);
                        },
                        content: S.current.deleteAllFutureSubscriptions,
                        oneAction: false);
                  });
            },
            title: S.current.deleteFutureSubscription,
            subtitleFontSize: 12,
            // width: 200,
          ),
        ],
      ),
    ]);
  }
}
