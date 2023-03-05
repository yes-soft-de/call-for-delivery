import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/module_plan/state_manager/account_balance_state_manager.dart';
import 'package:c4d/module_plan/ui/screen/captain_financial_dues_screen.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/flat_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AccountBalanceScreen extends StatefulWidget {
  final AccountBalanceStateManager _manager;

  const AccountBalanceScreen(this._manager);

  @override
  State<StatefulWidget> createState() => AccountBalanceScreenState();
}

class AccountBalanceScreenState extends State<AccountBalanceScreen> {
  States? _currentState;
  String? selectedPlan;
  @override
  void initState() {
    _currentState = LoadingState(this);
    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    widget._manager.getAccountBalance(this);
    super.initState();
  }

  AccountBalanceStateManager get manager => widget._manager;
  void refresh() {
    if (mounted) setState(() {});
  }

  void getAccount() {
    refresh();
  }

  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.myBalance,
          actions: [
            Visibility(
              visible: false,
              child: CustomC4dAppBar.actionIcon(context, onTap: () {
                Navigator.of(context).pushNamed(PlanRoutes.PLAN_ROUTE,
                    arguments: S.current.updateProfile);
              }, icon: Icons.balance_rounded),
            )
          ],
          bottom: PreferredSize(
              child: FilterBar(
                cursorRadius: BorderRadius.circular(25),
                animationDuration: const Duration(milliseconds: 350),
                backgroundColor: Theme.of(context).colorScheme.background,
                currentIndex: currentIndex,
                borderRadius: BorderRadius.circular(25),
                floating: true,
                height: 40,
                cursorColor: Theme.of(context).colorScheme.primary,
                items: [
                  FilterItem(label: S.current.myBalance),
                  FilterItem(label: S.current.financialDuesCycles),
                ],
                onItemSelected: (index) {
                  currentIndex = index;
                  pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.linear);
                  setState(() {});
                },
                selectedContent: Theme.of(context).textTheme.button!.color!,
                unselectedContent:
                    Theme.of(context).textTheme.headline6!.color!,
              ),
              preferredSize: const Size.fromHeight(40))),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          currentIndex = index;
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 350),
              curve: Curves.linear);
          setState(() {});
        },
        children: [
          Scaffold(
            body: _currentState?.getUI(context) ?? Container(),
          ),
          getIt<CaptainFinancialDuesScreen>()
        ],
      ),
    );
  }
}
