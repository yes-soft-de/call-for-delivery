import 'dart:async';

import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/store_profile_model.dart';
import 'package:c4d/module_subscriptions/state_manager/store_subscription_management_state_manager.dart';
import 'package:c4d/module_subscriptions/ui/state/subscriptions_management/subscriptions_management_loaded_state.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SubscriptionManagementScreen extends StatefulWidget {
  SubscriptionManagementScreen();

  @override
  State<SubscriptionManagementScreen> createState() =>
      SubscriptionManagementScreenState();
}

class SubscriptionManagementScreenState
    extends State<SubscriptionManagementScreen> {
  late States currentState;
  late StoreSubscriptionManagementStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  bool flagArgs = true;
  StoreProfileModel? profileId;
  @override
  void initState() {
    currentState = SubscriptionManagementStateLoaded(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (this.mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  StoreSubscriptionManagementStateManager get stateManager => _stateManager;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && flagArgs) {
      if (args is StoreProfileModel) {
        profileId = args;
        flagArgs = false;
      }
    }
    return Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.subscriptionManagement),
        body: currentState.getUI(context));
  }
}
