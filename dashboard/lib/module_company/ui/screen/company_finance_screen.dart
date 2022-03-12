import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_company/request/create_company_profile.dart';
import 'package:c4d/module_company/request/delivery_company_financial.dart';
import 'package:c4d/module_company/request/financial_compensation_request.dart';
import 'package:c4d/module_company/state_manager/company_financial_state_manager.dart';
import 'package:c4d/module_company/state_manager/company_profile_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';

@injectable
class CompanyFinanceScreen extends StatefulWidget {
  final CompanyFinanceStateManager _stateManager;

  CompanyFinanceScreen(this._stateManager);

  @override
  CompanyFinanceScreenState createState() => CompanyFinanceScreenState();
}

class CompanyFinanceScreenState extends State<CompanyFinanceScreen> {
  late States currentState;
  bool canAddCategories = true;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        refresh();
      }
    });
    widget._stateManager.getCompanyProfile(this);
    super.initState();
  }

  void getFinance() {
    widget._stateManager.getCompanyProfile(this);
  }

  void createProfile(CreateCompanyProfile request) {
    widget._stateManager.createProfile(this, request);
  }
  void UpdateCompanyProfile(CreateCompanyProfile request) {
    widget._stateManager.UpdateCompanyProfile(this, request);
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
