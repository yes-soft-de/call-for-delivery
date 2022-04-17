import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/captain_finance_by_hours_model.dart';
import 'package:c4d/module_plan/model/captain_finance_by_order_count.dart';
import 'package:c4d/module_plan/model/captain_finance_by_order_model.dart';
import 'package:c4d/module_plan/request/captain_finance_request.dart';
import 'package:c4d/module_plan/ui/screen/plan_screen.dart';
import 'package:c4d/module_plan/ui/widget/by_hours_widget.dart';
import 'package:c4d/module_plan/ui/widget/by_order_count.dart';
import 'package:c4d/module_plan/ui/widget/by_order_widget.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InitCaptainPlanLoadedState extends States {
  final PlanScreenState screenState;
  InitCaptainPlanLoadedState(this.screenState,
      {this.financeByHours,
      this.financeByOrder,
      this.financeByOrderCount,
      this.error,
      this.empty})
      : super(screenState);
  String? appBarTitle;
  int? _selectedPlanId;
  List<CaptainFinanceByOrderModel>? financeByOrder = [];
  List<CaptainFinanceByHoursModel>? financeByHours = [];
  List<CaptainFinanceByOrdersCountModel>? financeByOrderCount = [];
  String? error;
  String? empty;
  List<String> packages = [
    S.current.planByHours,
    S.current.planByOrders,
    S.current.planByOrderCount
  ];
  @override
  Widget getUI(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      appBarTitle = args;
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: appBarTitle ?? S.current.storeAccountInit,
          canGoBack: appBarTitle != null ? true : false),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            // info
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.primary),
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Theme.of(context).textTheme.button?.color,
                  ),
                  title: Text(
                    S.current.planHint + ' . ',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DottedLine(
                dashColor: Theme.of(context).backgroundColor,
                lineThickness: 4,
              ),
            ),
            // categories
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                        value: screenState.selectedPlan,
                        items: _getCatagories(),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        hint: Text(S.current.chooseYourPlan),
                        onChanged: (String? value) {
                          screenState.selectedPlan = value;
                          _selectedPlanId = null;
                          empty = null;
                          error = null;
                          // get data
                          screenState.manager.getFinance(
                              screenState, screenState.selectedPlan ?? '');
                          screenState.refresh();
                        }),
                  ),
                ),
              ),
            ),
            // there is no packages available in this category
            Visibility(
                visible: empty != null,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        S.current.emptyPackagesCategory,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SvgPicture.asset(
                        SvgAsset.EMPTY_SVG,
                        width: 125,
                        height: 125,
                      )
                    ],
                  ),
                )),
            // there is error in this category
            Visibility(
                visible: error != null,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        S.current.emptyPackagesCategory,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SvgPicture.asset(
                        SvgAsset.ERROR_SVG,
                        width: 125,
                        height: 125,
                      )
                    ],
                  ),
                )),
            const SizedBox(
              height: 8,
            ),
            //package
            Visibility(
              visible: screenState.selectedPlan != null,
              child: ScalingWidget(
                fade: true,
                milliseconds: 1000,
                child: SizedBox(
                  height: getHeight(),
                  width: double.maxFinite,
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.horizontal,
                    children: getPlanes(),
                  ),
                ),
              ),
            ),
            // Submit Package
            Visibility(
              visible: _selectedPlanId != null ||
                  screenState.selectedPlan == S.current.planByOrderCount,
              child: ScalingWidget(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                      onPressed: () {
                        int index =
                            packages.indexOf(screenState.selectedPlan!) + 1;
                        screenState.manager.financeRequest(
                            screenState,
                            CaptainFinanceRequest(
                                planId: _selectedPlanId,
                                planType: index == 3 ? 0 : index));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          S.of(context).next,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 75,
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getCatagories() {
    List<DropdownMenuItem<String>> dropDown = [];
    packages.forEach((element) {
      dropDown.add(DropdownMenuItem(
        child: Text(
          element,
          overflow: TextOverflow.ellipsis,
        ),
        value: element,
      ));
    });
    return dropDown;
  }

  List<Widget> _getPlanByOrder() {
    if (financeByOrder == null) {
      return [];
    }
    if (financeByOrder?.isEmpty == true) {
      return [];
    }
    return financeByOrder!.map((element) {
      return GestureDetector(
        onTap: () {
          if (element.id == _selectedPlanId) {
            _selectedPlanId = null;
          } else {
            _selectedPlanId = element.id;
          }
          screenState.refresh();
        },
        // specific widget
        child: FinanceByOrder(
          amount: element.amount,
          bounce: element.bounce,
          bounceCountOrdersInMonth: element.bounceCountOrdersInMonth,
          categoryName: element.categoryName,
          countKilometersFrom: element.countKilometersFrom,
          countKilometersTo: element.countKilometersTo,
          active: element.id == _selectedPlanId,
        ),
      );
    }).toList();
  }

  List<Widget> _getPlanByHours() {
    if (financeByHours == null) {
      return [];
    }
    if (financeByHours?.isEmpty == true) {
      return [];
    }
    return financeByHours!.map((element) {
      return GestureDetector(
        onTap: () {
          if (element.id == _selectedPlanId) {
            _selectedPlanId = null;
          } else {
            _selectedPlanId = element.id;
          }
          screenState.refresh();
        },
        // specific widget
        child: FinanceByHours(
          compensationForEveryOrder: element.compensationForEveryOrder,
          salary: element.salary,
          countHours: element.countHours,
          active: element.id == _selectedPlanId,
        ),
      );
    }).toList();
  }

  List<Widget> _getPlanByOrderCount() {
    if (financeByOrderCount == null) {
      return [];
    }
    if (financeByOrderCount?.isEmpty == true) {
      return [];
    }
    return financeByOrderCount!.map((element) {
      return GestureDetector(
        onTap: () {},
        // specific widget
        child: FinanceByCountOrder(
          bounceMaxCountOrdersInMonth: element.bounceMaxCountOrdersInMonth,
          bounceMinCountOrdersInMonth: element.bounceMinCountOrdersInMonth,
          countOrdersInMonth: element.countOrdersInMonth,
          monthCompensation: element.monthCompensation,
          salary: element.salary,
        ),
      );
    }).toList();
  }

  List<Widget> getPlanes() {
    if (screenState.selectedPlan == S.current.planByOrders) {
      return _getPlanByOrder();
    } else if (screenState.selectedPlan == S.current.planByHours) {
      return _getPlanByHours();
    } else {
      return _getPlanByOrderCount();
    }
  }

  double getHeight() {
    if (screenState.selectedPlan == S.current.planByOrders) {
      return 250;
    } else if (screenState.selectedPlan == S.current.planByHours) {
      return 135;
    } else {
      return 200;
    }
  }
}
