import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/subscriptions_routes.dart';
import 'package:c4d/module_subscriptions/ui/screen/subscriptions_managment_screen.dart';
import 'package:c4d/module_subscriptions/ui/widget/bottom_sheet_sub_management/bottom_sheet_renew_sub.dart';
import 'package:c4d/module_subscriptions/ui/widget/control_widget.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                  arguments: screenState.profileId);
            },
            title: S.current.currentSubscriptions,
          ),
          ControlWidget(
            icon: Icons.play_disabled_rounded,
            onPressed: () {
              Navigator.of(context).pushNamed(
                  SubscriptionsRoutes.SUBSCRIPTIONS_EXPIRED_DUES_SCREEN,
                  arguments: screenState.profileId);
            },
            title: S.current.expiredSubscriptions,
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
                        screenState.stateManager
                            .extendPackage(screenState, screenState.profileId);
                      },
                      renewNewPlan: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(
                            SubscriptionsRoutes.CREATE_NEW_SUBSCRIPTION_SCREEN,
                            arguments: screenState.profileId);
                      },
                      renewOldPlan: () {
                        Navigator.of(context).pop();
                        screenState.stateManager
                            .renewPackage(screenState, screenState.profileId);
                      },
                    );
                  });
            },
            title: S.current.createSubscription,
          ),
          ControlWidget(
            icon: Icons.edit,
            onPressed: () {
              Fluttertoast.showToast(msg: S.current.notImplementedYet);
            },
            title: S.current.editSubscriptions,
          ),
          ControlWidget(
            icon: Icons.delete_sweep_rounded,
            onPressed: () {
              Fluttertoast.showToast(msg: S.current.notImplementedYet);
            },
            title: S.current.deleteFutureSubscription,
            width: 200,
          ),
        ],
      ),
    ]);
  }
}
