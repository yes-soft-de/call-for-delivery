import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_external_delivery_companies/model/company_model.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/create_company_criteria_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/update_company_criteria_request.dart';
import 'package:c4d/module_external_delivery_companies/state_manager/edit_delivery_company_setting_state_manager.dart';
import 'package:c4d/module_external_delivery_companies/ui/state/edit_delivery_company_setting_state_loaded.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class EditDeliveryCompanySettingScreen extends StatefulWidget {
  const EditDeliveryCompanySettingScreen();

  @override
  State<EditDeliveryCompanySettingScreen> createState() =>
      EditDeliveryCompanySettingScreenState();
}

class EditDeliveryCompanySettingScreenState
    extends State<EditDeliveryCompanySettingScreen> {
  late States currentState;
  late EditDeliveryCompanySettingScreenStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  late CompanySetting companySetting;
  late CompanyModel company;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this);

    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;

      if (mounted) {
        setState(() {});
      }
    });
  }

  updateCompanyCriterial(UpdateCompanyCriterialRequest request) {
    _stateManager.updateCompanyCriterial(this, request);
  }

  createCompanyCriterial(CreateCompanyCriteria request) {
    _stateManager.createCompanyCriterial(this, request);
  }

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      var arg = ModalRoute.of(context)?.settings.arguments as List;
      companySetting = arg[0] as CompanySetting;
      company = arg[1] as CompanyModel;

      bool isNewSetting = false;
      if (arg.length > 2) isNewSetting = arg[2] as bool;

      currentState = EditDeliveryCompanySettingScreenStateLoaded(
          this, companySetting, isNewSetting);
    }

    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(
          context,
          title: company.name,
        ),
        key: _scaffoldKey,
        body: SafeArea(
          child: currentState.getUI(context),
        ),
      ),
    );
  }
}
