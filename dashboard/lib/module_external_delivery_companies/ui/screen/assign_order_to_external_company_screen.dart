import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/request/assign_order_to_external_company/assign_order_to_external_company_request.dart';
import 'package:c4d/module_external_delivery_companies/state_manager/assign_order_to_external_company_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AssignOrderToExternalCompanyScreen extends StatefulWidget {
  final AssignOrderToExternalCompanyStateManager _stateManager;

  const AssignOrderToExternalCompanyScreen(this._stateManager);

  @override
  State<AssignOrderToExternalCompanyScreen> createState() =>
      AssignOrderToExternalCompanyScreenState();
}

class AssignOrderToExternalCompanyScreenState
    extends State<AssignOrderToExternalCompanyScreen> {
  late States currentState;
  late int orderId;
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

  assignOrderToExternalCompany(int companyId) {
    widget._stateManager.assignOrderToExternalCompany(
        this,
        AssignOrderToExternalCompanyRequest(
          externalCompanyId: companyId,
          orderId: orderId,
        ));
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
      var arg = ModalRoute.of(context)?.settings.arguments as List;
      if (arg.length > 0) orderId = arg[0] as int;
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
          title: S.current.deliveryCompanies,
        ),
        key: _scaffoldKey,
        body: SafeArea(
          child: currentState.getUI(context),
        ),
      ),
    );
  }
}
