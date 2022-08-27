import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/ui/state/subscriptions_management/subscriptions_management_loaded_state.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubscriptionManagementScreen extends StatefulWidget {
  SubscriptionManagementScreen();

  @override
  State<SubscriptionManagementScreen> createState() =>
      SubscriptionManagementScreenState();
}

class SubscriptionManagementScreenState
    extends State<SubscriptionManagementScreen> {
  bool flagArgs = true;
  int profileId = -1;
  States? currentState;
  @override
  void initState() {
    currentState = SubscriptionManagementStateLoaded(this);
    super.initState();
  }

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
        body: currentState?.getUI(context));
  }
}
