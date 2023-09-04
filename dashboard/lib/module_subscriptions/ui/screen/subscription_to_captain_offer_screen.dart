import 'dart:async';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_subscriptions/request/store_captain_offer_request.dart';
import 'package:c4d/module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';

class CreateSubscriptionToCaptainOfferScreen extends StatefulWidget {
  CreateSubscriptionToCaptainOfferScreen();

  @override
  State<StatefulWidget> createState() =>
      CreateSubscriptionToCaptainOfferScreenState();
}

class CreateSubscriptionToCaptainOfferScreenState
    extends State<CreateSubscriptionToCaptainOfferScreen> {
  late States currentState;
  late SubscriptionToCaptainOfferStateManager _stateManager;
  late StreamSubscription _streamSubscription;

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
      Navigator.of(context).pop();
      CustomFlushBarHelper.createSuccess(
          title: S.current.warnning,
          message: S.current.subscribedToOfferSuccessfully);
    });
  }

  @override
  void initState() {
    canPop = Navigator.of(context).canPop();
    _stateManager = getIt();
    _streamSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    _stateManager.getPackages(this);
    super.initState();
  }

  void subscribeToPackage(StoreSubscribeToCaptainOfferRequest request) {
    _stateManager.subscribePackage(this, request);
  }

  void getPackages(int selectedCategories) {
    _stateManager.getPackages(this);
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
      body: currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }
}
