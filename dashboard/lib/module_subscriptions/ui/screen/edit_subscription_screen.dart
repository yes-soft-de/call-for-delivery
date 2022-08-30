import 'dart:async';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_subscriptions/request/store_edit_subscribe_to_package.dart';
import 'package:c4d/module_subscriptions/request/store_subscribe_to_package.dart';
import 'package:c4d/module_subscriptions/state_manager/edit_subscription_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditSubscriptionScreen extends StatefulWidget {
  final EditSubscriptionStateManager _stateManager;

  EditSubscriptionScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => EditSubscriptionScreenState();
}

class EditSubscriptionScreenState extends State<EditSubscriptionScreen> {
  late StreamSubscription _streamSubscription;
  States? currentState;
  List<PackagesCategoryModel> categories = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late bool canPop;
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void moveNext() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pop();
      CustomFlushBarHelper.createSuccess(
              title: S.current.warnning, message: S.current.successRenew)
          .show(context);
    });
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
    widget._stateManager.getCategories(this);
    super.initState();
  }

  void subscribeToPackage(EditStoreSubscribeToPackageRequest request) {
    widget._stateManager.subscribePackage(this, request);
  }

  void getPackages(int selectedCategories) {
    widget._stateManager.getPackages(this, selectedCategories);
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
      body: currentState == null ? SizedBox() : currentState?.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
