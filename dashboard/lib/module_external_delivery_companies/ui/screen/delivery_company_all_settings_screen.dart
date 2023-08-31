import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_external_delivery_companies/model/company_model.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/delete_company_criteria_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/update_company_criterial_status_request.dart';
import 'package:c4d/module_external_delivery_companies/state_manager/delivery_copmany_all_settings_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class DeliveryCompanyAllSettingsScreen extends StatefulWidget {
  const DeliveryCompanyAllSettingsScreen();

  @override
  State<DeliveryCompanyAllSettingsScreen> createState() =>
      DeliveryCompanyAllSettingsScreenState();
}

class DeliveryCompanyAllSettingsScreenState
    extends State<DeliveryCompanyAllSettingsScreen> {
  late States currentState;
  late DeliveryCompanyAllSettingsStateManager _stateManager;
  late StreamSubscription _stateSubscription;

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

  getCompanySetting() {
    _stateManager.getCompanySetting(this, company.id);
  }

  deleteCompanyCriterial(DeleteCompanyCriterialRequest request) {
    _stateManager.deleteCompanyCriterial(this, request);
  }

  updateCompanyCriterialStatus(UpdateCompanyCriterialStatusRequest request) {
    _stateManager.updateCompanyCriterialStatus(this, request);
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
      company = ModalRoute.of(context)?.settings.arguments as CompanyModel;
      getCompanySetting();
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
