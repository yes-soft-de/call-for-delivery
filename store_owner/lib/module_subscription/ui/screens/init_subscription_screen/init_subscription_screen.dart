import 'dart:async';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/branches_routes.dart';
import 'package:c4d/module_subscription/state_manager/init_subscription_state_manager.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class InitSubscriptionScreen extends StatefulWidget {
  final InitSubscriptionStateManager _stateManager;

  InitSubscriptionScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => InitSubscriptionScreenState();
}

class InitSubscriptionScreenState extends State<InitSubscriptionScreen> {
  late StreamSubscription _streamSubscription;
  States? currentState;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late bool canPop;
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void moveNext() {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      getIt<GlobalStateManager>().update();
      Navigator.of(context).pop();
      CustomFlushBarHelper.createSuccess(
              title: S.current.warnning, message: S.current.successRenew)
          .show(context);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          BranchesRoutes.INIT_BRANCHES, (route) => false);
      CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.packageSubscriptionSuccess)
          .show(context);
    }
  }

  @override
  void initState() {
    canPop = Navigator.of(context).canPop();
    _streamSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.getPackages(this);
    super.initState();
  }

  void subscribeToPackage(int packageId) {
    widget._stateManager.subscribePackage(this, packageId);
  }

  void getPackages() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: currentState == null ? SizedBox() : currentState?.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
