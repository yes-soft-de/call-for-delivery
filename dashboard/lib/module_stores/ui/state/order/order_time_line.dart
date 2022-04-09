import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/order/order_details_model.dart';
import 'package:c4d/module_stores/ui/screen/order/order_time_line_screen.dart';
import 'package:c4d/module_stores/ui/widget/custom_step.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:c4d/utils/helpers/translating.dart';

class OrderTimLineLoadedState extends States {
  OrderTimeLineScreenState screenState;
  OrderTimeLine? model;
  OrderTimLineLoadedState(this.screenState, this.model) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return FixedContainer(
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(8),
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              Visibility(
                visible: model?.completionTime != '',
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  leading: Container(
                      height: double.maxFinite,
                      width: 50,
                      child: Icon(
                        FontAwesomeIcons.delicious,
                        color: Colors.white,
                      )),
                  tileColor: Theme.of(context).colorScheme.primary,
                  title: Text(
                    S.current.completeTime,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  subtitle: Text(
                    Trans.localString(model?.completionTime ?? '', context),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              Flex(
                direction: Axis.vertical,
                children: getStepperAdmin(StatusHelper.getOrderStatusIndex(
                    model?.currentState ?? OrderStatusEnum.WAITING)),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CustomStepTimeLineAdmin(
                    status:
                        model?.steps[index].state ?? OrderStatusEnum.WAITING,
                    currentIndex: index,
                    date: model?.steps[index].date,
                    captainArrived:
                        model?.steps[index].isCaptainArrived ?? true,
                  );
                },
                itemCount: model?.steps.length,
                shrinkWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> getStepper(int currentIndex) {
    List<Widget> steps = [
      CustomStepTimeLine(
          status: OrderStatusEnum.WAITING,
          currentIndex: currentIndex,
          date: model?.steps[0].date),
      Padding(
        padding: const EdgeInsets.only(right: 22.0, left: 22.0),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 2.5,
            color: Theme.of(screenState.context).primaryColor.withOpacity(0.7),
          ),
        ),
      ),
      CustomStepTimeLine(
          status: OrderStatusEnum.GOT_CAPTAIN,
          currentIndex: currentIndex,
          date: model!.steps.length >= 2 ? model?.steps[1].date : null),
      Padding(
        padding: const EdgeInsets.only(right: 22.0, left: 22.0),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 2.5,
            color: currentIndex <
                    StatusHelper.getOrderStatusIndex(
                        OrderStatusEnum.GOT_CAPTAIN)
                ? Theme.of(screenState.context).disabledColor
                : Theme.of(screenState.context).primaryColor,
          ),
        ),
      ),
      CustomStepTimeLine(
          status: OrderStatusEnum.IN_STORE,
          currentIndex: currentIndex,
          date: model!.steps.length >= 3 ? model?.steps[2].date : null),
      Padding(
        padding: const EdgeInsets.only(right: 22.0, left: 22.0),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 2.5,
            color: currentIndex <
                    StatusHelper.getOrderStatusIndex(OrderStatusEnum.IN_STORE)
                ? Theme.of(screenState.context).disabledColor
                : Theme.of(screenState.context).primaryColor,
          ),
        ),
      ),
      CustomStepTimeLine(
          status: OrderStatusEnum.DELIVERING,
          currentIndex: currentIndex,
          date: model!.steps.length >= 4 ? model?.steps[3].date : null),
      Padding(
        padding: const EdgeInsets.only(right: 22.0, left: 22.0),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 2.5,
            color: currentIndex <
                    StatusHelper.getOrderStatusIndex(OrderStatusEnum.DELIVERING)
                ? Theme.of(screenState.context).disabledColor
                : Theme.of(screenState.context).primaryColor,
          ),
        ),
      ),
      CustomStepTimeLine(
          status: OrderStatusEnum.FINISHED,
          currentIndex: currentIndex,
          date: model!.steps.length >= 4 ? model?.steps[4].date : null),
    ];
    return steps;
  }

  List<Widget> getStepperAdmin(int currentIndex) {
    List<Widget> steps = [];
    return steps;
  }
}
