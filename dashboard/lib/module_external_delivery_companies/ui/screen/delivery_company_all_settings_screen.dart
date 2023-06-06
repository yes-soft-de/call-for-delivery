import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_external_delivery_companies/model/company_model.dart';
import 'package:c4d/module_external_delivery_companies/state_manager/delivery_copmany_all_settings_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeliveryCompanyAllSettingsScreen extends StatefulWidget {
  final DeliveryCompanyAllSettingsStateManager _stateManager;
  const DeliveryCompanyAllSettingsScreen(this._stateManager);

  @override
  State<DeliveryCompanyAllSettingsScreen> createState() =>
      DeliveryCompanyAllSettingsScreenState();
}

class DeliveryCompanyAllSettingsScreenState
    extends State<DeliveryCompanyAllSettingsScreen> {
  late States currentState;
  late CompanyModel company;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription? _stateSubscription;

  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this);

    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;

      if (mounted) {
        setState(() {});
      }
    });
  }

  getExternalCompanies(int companyId) {
    widget._stateManager.getCompanySetting(this, companyId);
  }

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      company = ModalRoute.of(context)?.settings.arguments as CompanyModel;
      getExternalCompanies(company.id);
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
