import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_captain/request/captain_payment_request.dart';
import 'package:c4d/module_captain/state_manager/captain_dues_state_manager.dart';
import 'package:c4d/utils/components/costom_search.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainDuesScreen extends StatefulWidget {
  final CaptainDuesStateManager _manager;

  const CaptainDuesScreen(this._manager);

  @override
  State<StatefulWidget> createState() => CaptainDuesScreenState();
}

class CaptainDuesScreenState extends State<CaptainDuesScreen> {
  States? _currentState;
  int currentIndex = 0;
  String? search;
  late CaptainPaymentRequest filter;
  @override
  void initState() {
    _currentState = LoadingState(this);
    widget._manager.stateSubject.listen((value) {
      _currentState = value;

      if (mounted) setState(() {});
    });
    filter = CaptainPaymentRequest(hasCaptainFinancialDueDemanded: true);
    widget._manager.getCaptainsFinanceDailyNew(this, filter);
    super.initState();
  }

  CaptainDuesStateManager get manager => widget._manager;
  void refresh() {
    if (mounted) setState(() {});
  }

  void getAccount() {
    widget._manager.getCaptainsFinanceDailyNew(this, filter);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomC4dAppBar.appBar(
          context,
          title: S.current.captainDues,
          onTap: () {
            GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
          },
          icon: Icons.menu,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 16),
              child: CustomDeliverySearch(
                hintText: S.current.searchForCaptain,
                onChanged: (s) {
                  if (s == '' || s.isEmpty) {
                    search = null;
                    refresh();
                  } else {
                    search = s;
                    refresh();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          currentIndex = 0;
                          filter = CaptainPaymentRequest(
                              hasCaptainFinancialDueDemanded: true);
                          refresh();
                          widget._manager
                              .getCaptainsFinanceDailyNew(this, filter);
                        },
                        child: AnimatedContainer(
                          height: 40,
                          padding: EdgeInsets.all(8),
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: currentIndex != 0
                                    ? Colors.grey
                                    : Colors.white,
                                width: 1),
                            borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(25),
                                bottomStart: Radius.circular(25)),
                            color: currentIndex == 0
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                          ),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                          child: Text(
                            S.current.paymentRequests,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: currentIndex != 0
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          currentIndex = 1;
                          filter = CaptainPaymentRequest(status: 2);
                          refresh();
                          widget._manager
                              .getCaptainsFinanceDailyNew(this, filter);
                        },
                        child: AnimatedContainer(
                          height: 40,
                          padding: EdgeInsets.all(8),
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: currentIndex != 1
                                      ? Colors.grey
                                      : Colors.white,
                                  width: 1),
                              borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(25),
                                  bottomEnd: Radius.circular(25)),
                              color: currentIndex == 1
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.background),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                          child: Text(
                            S.current.notPaid,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: currentIndex != 1
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                          ),
                          // Text(S.current.hidden),
                        ),
                      ),
                    ),
                  ]),
            ),
            Expanded(child: _currentState!.getUI(context)),
          ],
        ));
  }
}
