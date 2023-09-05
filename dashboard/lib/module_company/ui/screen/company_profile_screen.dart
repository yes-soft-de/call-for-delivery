import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_company/request/create_company_profile.dart';
import 'package:c4d/module_company/state_manager/company_profile_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CompanyProfileScreen extends StatefulWidget {
  CompanyProfileScreen();

  @override
  CompanyProfileScreenState createState() => CompanyProfileScreenState();
}

class CompanyProfileScreenState extends State<CompanyProfileScreen> {
  late States currentState;
  late CompanyProfileStateManager _stateManager;
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

  void getCompanyProfile() {
    _stateManager.getCompanyProfile(this);
  }

  void createProfile(CreateCompanyProfile request) {
    _stateManager.createProfile(this, request);
  }

  void updateProfile(CreateCompanyProfile request) {
    _stateManager.updateStore(this, request);
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
          title: S.of(context).contactInfo, icon: Icons.menu, onTap: () {
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
