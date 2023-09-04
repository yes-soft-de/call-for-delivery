import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_company/request/create_company_profile.dart';
import 'package:c4d/module_company/state_manager/company_financial_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CompanyFinanceScreen extends StatefulWidget {
  CompanyFinanceScreen();

  @override
  CompanyFinanceScreenState createState() => CompanyFinanceScreenState();
}

class CompanyFinanceScreenState extends State<CompanyFinanceScreen> {
  late States currentState;
  late CompanyFinanceStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  bool canAddCategories = true;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        refresh();
      }
    });
    _stateManager.getCompanyProfile(this);
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void getFinance() {
    _stateManager.getCompanyProfile(this);
  }

  void createProfile(CreateCompanyProfile request) {
    _stateManager.createProfile(this, request);
  }

  void UpdateCompanyProfile(CreateCompanyProfile request) {
    _stateManager.UpdateCompanyProfile(this, request);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).companyFinance, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: GestureDetector(
          onTap: () {
            var focus = FocusScope.of(context);
            if (focus.canRequestFocus) {
              focus.unfocus();
            }
          },
          child: currentState.getUI(context)),
    );
  }
}
