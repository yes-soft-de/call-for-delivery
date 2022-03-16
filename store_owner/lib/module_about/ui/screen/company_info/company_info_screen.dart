import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/state_manager/company_info_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyInfoScreen extends StatefulWidget {
  final CompanyInfoStateManager _stateManager;
  CompanyInfoScreen(this._stateManager);

  @override
  State<CompanyInfoScreen> createState() => CompanyInfoScreenState();
}

class CompanyInfoScreenState extends State<CompanyInfoScreen> {
  late States currentState;
  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.getCompanyInfo(this);
    widget._stateManager.stateStream.listen((event) {
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
        appBar: CustomC4dAppBar.appBar(context, title: S.current.companyInfo),
        body: currentState.getUI(context));
  }
}
