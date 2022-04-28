import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/hive/captain_hive_helper.dart';
import 'package:c4d/module_captain/state_manager/captain_account_balance_state_manager.dart';
import 'package:c4d/module_captain/ui/screen/captain_financial_dues_screen.dart';
import 'package:c4d/module_notice/ui/widget/filter_bar.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainAccountBalanceScreen extends StatefulWidget {
  final AccountBalanceStateManager _manager;

  const CaptainAccountBalanceScreen(this._manager);

  @override
  State<StatefulWidget> createState() => CaptainAccountBalanceScreenState();
}

class CaptainAccountBalanceScreenState
    extends State<CaptainAccountBalanceScreen> {
  States? _currentState;
  String? selectedPlan;
  @override
  void initState() {
    _currentState = LoadingState(this);
    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  AccountBalanceStateManager get manager => widget._manager;
  void refresh() {
    if (mounted) setState(() {});
  }

  void getAccount() {
    refresh();
  }

  late int captainID = -1;
  bool flage = true;
  int currentIndex = 0;
  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && flage) {
      if (args is int) {
        captainID = args;
        flage = false;
        CaptainsHiveHelper().setCurrentCaptainID(captainID);
        widget._manager.getAccountBalance(this, captainID);
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.accountBalance,
          bottom: PreferredSize(
              child: FilterBar(
                cursorRadius: BorderRadius.circular(25),
                animationDuration: const Duration(milliseconds: 350),
                backgroundColor: Theme.of(context).backgroundColor,
                currentIndex: currentIndex,
                borderRadius: BorderRadius.circular(25),
                floating: true,
                height: 40,
                cursorColor: Theme.of(context).colorScheme.primary,
                items: [
                  FilterItem(label: S.current.currentFinancialCycle),
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
