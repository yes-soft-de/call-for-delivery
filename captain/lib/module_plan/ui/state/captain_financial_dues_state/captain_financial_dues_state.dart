import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/captain_financial_dues.dart';
import 'package:c4d/module_plan/ui/screen/captain_financial_dues_screen.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:flutter/material.dart';

class CaptainFinancialDuesStateLoaded extends States {
  List<CaptainFinancialDuesModel>? balance;
  final CaptainFinancialDuesScreenState screenState;
  CaptainFinancialDuesStateLoaded(this.screenState, this.balance)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar:
          CustomC4dAppBar.appBar(context, title: S.current.myBalance, actions: [
      ]),
      body: CustomListView.custom(
        children: [
        ],
      ),
    );
  }

}
