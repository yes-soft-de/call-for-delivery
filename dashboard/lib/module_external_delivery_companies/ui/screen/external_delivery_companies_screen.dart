import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_external_delivery_companies/request/create_new_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/delete_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/update_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/update_delivery_company_status_request.dart';
import 'package:c4d/module_external_delivery_companies/state_manager/external_delivery_companies_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExternalDeliveryCompaniesScreen extends StatefulWidget {
  final ExternalDeliveryCompaniesStateManager _stateManager;

  const ExternalDeliveryCompaniesScreen(this._stateManager);

  @override
  State<ExternalDeliveryCompaniesScreen> createState() =>
      ExternalDeliveryCompaniesScreenState();
}

class ExternalDeliveryCompaniesScreenState
    extends State<ExternalDeliveryCompaniesScreen> {
  late States currentState;
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
    getExternalCompanies();
  }

  getExternalCompanies() {
    widget._stateManager.getExternalCompanies(this);
  }

  updateCompany(UpdateDeliveryCompanyRequest request) {
    widget._stateManager.updateCompany(this, request);
  }

  createNewCompany(CreateNewDeliveryCompanyRequest request) {
    widget._stateManager.createNewCompany(this, request);
  }

  deleteCompany(DeleteDeliveryCompanyRequest request) {
    widget._stateManager.deleteCompany(this, request);
  }

  updateCompanyStatus(UpdateDeliveryCompanyStatusRequest request) {
    widget._stateManager.updateCompanyStatus(this, request);
  }

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.deliveryCompanies, icon: Icons.menu, onTap: () {
          GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
        }),
        key: _scaffoldKey,
        body: SafeArea(
          child: currentState.getUI(context),
        ),
      ),
    );
  }
}
