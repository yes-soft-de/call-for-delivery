import 'dart:async';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/model/account_balance_model.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/state_manager/account_balance_state_manager.dart';
import 'package:c4d/module_profile/ui/states/account_balance/account_balance_loaded_state.dart';
import 'package:c4d/module_profile/ui/states/init_account/init_account_profile_loaded.dart';
import 'package:c4d/module_subscription/subscriptions_routes.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AccountBalanceScreen extends StatefulWidget {
  final AccountBalanceStateManager _stateManager;

  AccountBalanceScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => AccountBalanceScreenState();
}

class AccountBalanceScreenState extends State<AccountBalanceScreen> {
  late StreamSubscription _streamSubscription;
  late States currentState;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void moveNext() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        SubscriptionsRoutes.INIT_SUBSCRIPTIONS_SCREEN, (route) => false);
  }

  void initProfile(ProfileRequest request) {
    // widget._stateManager.createProfile(request, this);
  }

  @override
  void initState() {
    currentState = AccountBalanceLoaded(
        this,
        AccountBalanceModel(
            amountOwedToStore: 500,
            payments: [
              PaymentsModel(
                  id: -1,
                  amount: 500,
                  note: S.current.package,
                  date: DateTime.now())
            ],
            sumPaymentsToStore: 900,
            total: 1400));
    _streamSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.myBalance,
      ),
      body: currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
