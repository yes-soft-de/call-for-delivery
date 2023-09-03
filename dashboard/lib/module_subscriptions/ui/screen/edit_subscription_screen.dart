import 'dart:async';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_subscriptions/request/store_edit_subscribe_to_package.dart';
import 'package:c4d/module_subscriptions/state_manager/edit_subscription_state_manager.dart';
import 'package:c4d/module_subscriptions/subscriptions_routes.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';

class EditSubscriptionScreen extends StatefulWidget {
  EditSubscriptionScreen();

  @override
  State<StatefulWidget> createState() => EditSubscriptionScreenState();
}

class EditSubscriptionScreenState extends State<EditSubscriptionScreen> {
  late States currentState;
  late StreamSubscription _streamSubscription;
  late EditSubscriptionStateManager _stateManager;

  String? selectedCategories;
  List<PackagesCategoryModel> categories = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late bool canPop;
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void moveNext() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).popUntil((route) =>
          route.settings.name == SubscriptionsRoutes.SUBSCRIPTIONS_MANAGEMENT);
      CustomFlushBarHelper.createSuccess(
          title: S.current.warnning, message: S.current.successRenew);
    });
  }

  @override
  void initState() {
    canPop = Navigator.of(context).canPop();
    _stateManager = getIt();
    _streamSubscription =
        _streamSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    _stateManager.getCategories(this);
    super.initState();
  }

  void subscribeToPackage(EditStoreSubscribeToPackageRequest request) {
    _stateManager.subscribePackage(this, request);
  }

  void getPackages(int selectedCategories) {
    _stateManager.getPackages(this, selectedCategories);
  }

  int storeID = -1;
  @override
  Widget build(BuildContext context) {
    if (storeID == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        storeID = arg;
      }
    }
    return Scaffold(
      key: scaffoldKey,
      body: currentState == null ? SizedBox() : currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }
}
