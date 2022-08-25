import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/subscriptions_routes.dart';
import 'package:c4d/module_subscriptions/ui/widget/control_widget.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SubscriptionManagementScreen extends StatefulWidget {
  SubscriptionManagementScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionManagementScreen> createState() =>
      SubscriptionManagementScreenState();
}

class SubscriptionManagementScreenState
    extends State<SubscriptionManagementScreen> {
  bool flagArgs = false;
  int profileId = -1;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && flagArgs) {
      if (args is int) {
        profileId = args;
        flagArgs = false;
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.subscriptionManagement),
      body: Wrap(
        alignment: WrapAlignment.center,
        spacing: 16,
        children: [
          ControlWidget(
            icon: Icons.subscriptions_rounded,
            onPressed: () {
              Navigator.of(context).pushNamed(
                  SubscriptionsRoutes.SUBSCRIPTIONS_DUES_SCREEN,
                  arguments: profileId);
            },
            title: S.current.currentSubscriptions,
          ),
          ControlWidget(
            icon: Icons.play_disabled_rounded,
            onPressed: () {
              Fluttertoast.showToast(msg: S.current.notImplementedYet);
            },
            title: S.current.expiredSubscriptions,
          ),
          ControlWidget(
            icon: Icons.create_new_folder_rounded,
            onPressed: () {
              Fluttertoast.showToast(msg: S.current.notImplementedYet);
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
          ),
        ],
      ),
    );
  }
}
