import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/request/order/alert_container.dart';
import 'package:c4d/module_orders/request/order/provide_distance.dart';
import 'package:c4d/module_orders/request/order/update_order_request.dart';
import 'package:c4d/module_orders/ui/widgets/label_text.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';

class UpdateOrderStatusForm extends StatefulWidget {
  final OrderDetailsModel orderInfo;
  final Function(UpdateOrderRequest) callBack;
  UpdateOrderStatusForm(
      {Key? key, required this.orderInfo, required this.callBack})
      : super(key: key);

  @override
  State<UpdateOrderStatusForm> createState() => _UpdateOrderStatusFormState();
}

class _UpdateOrderStatusFormState extends State<UpdateOrderStatusForm> {
  late UpdateOrderRequest request;
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController distanceCalculator = TextEditingController();
  bool paid = false;
  late OrderDetailsModel orderInfo;
  @override
  void initState() {
    orderInfo = widget.orderInfo;
    paymentController.text =
        orderInfo.captainOrderCost?.toStringAsFixed(2) ?? '';
    noteController.text = orderInfo.noteCaptainOrderCost ?? '';
    distanceCalculator.text = orderInfo.kilometer?.toStringAsFixed(2) ?? '';
    paid = orderInfo.paidToProvider == 1 ? true : false;
    request = UpdateOrderRequest(
        id: orderInfo.id,
        state: StatusHelper.getStatusString(orderInfo.state),
        distance: distanceCalculator.text,
        paid: paid ? 1 : 2,
        orderCost: double.tryParse(paymentController.text),
        paymentNote: noteController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomC4dAppBar.appBar(context, title: S.current.updateOrderState),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // status
                Column(
                  children: [
                    ListTile(
                      title: LabelText(S.of(context).status),
                      subtitle: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).colorScheme.background),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                value:
                                    StatusHelper.getStatusEnum(request.state),
                                items: _getStatus(),
                                hint: Text(S.current.chooseBranch),
                                onChanged: (OrderStatusEnum? value) {
                                  request.state =
                                      StatusHelper.getStatusString(value);
                                  setState(() {});
                                }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: [OrderStatusEnum.FINISHED]
                      .contains(StatusHelper.getStatusEnum(request.state)),
                  child: Column(
                    children: [
                      AlertContainer(
                        subtitle: orderInfo.payment == 'cash'
                            ? S.current.finishingOrderMessageWithPayment
                            : S.current.finishingOrderMessage,
                        title: S.current.warnning,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProvideDistance(
                            thirdField: Visibility(
                              visible: paymentController.text != '' &&
                                  orderInfo.orderCost !=
                                      num.tryParse(paymentController.text),
                              child: ScalingWidget(
                                child: CustomFormField(
                                  hintText: S.current.collectedPaymentNote,
                                  controller: noteController,
                                  last: true,
                                ),
                              ),
                            ),
                            onChanged: () {
                              setState(() {});
                            },
                            payment: orderInfo.payment == 'cash',
                            callBack: (distance, payment) {},
                            controller: distanceCalculator,
                            controller2: paymentController,
                          )),
                      Visibility(
                        visible: paymentController.text != '' &&
                            orderInfo.orderCost !=
                                num.tryParse(paymentController.text),
                        child: ScalingWidget(
                          child: AlertContainer(
                            background: Theme.of(context).colorScheme.error,
                            title: S.current.collectedPaymentNotMatch,
                            subtitle: null,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: orderInfo.payment == 'cash',
                        child: CheckboxListTile(
                            value: paid,
                            title: Text(S.current.captainPaidToProvider),
                            onChanged: (value) {
                              paid = value ?? false;
                              setState(() {});
                            }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: TextButton(
                        style: TextButton.styleFrom(shape: StadiumBorder()),
                        onPressed: () {
                          request = UpdateOrderRequest(
                              id: orderInfo.id,
                              state: request.state,
                              distance: distanceCalculator.text,
                              paid: paid ? 1 : 2,
                              orderCost:
                                  double.tryParse(paymentController.text),
                              paymentNote: noteController.text);
                          widget.callBack(request);
                          Navigator.pop(context);
                        },
                        child: Text(S.current.update)),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.background,
                    thickness: 2.5,
                    indent: 16,
                    endIndent: 16,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: TextButton(
                        style: TextButton.styleFrom(shape: StadiumBorder()),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(S.current.cancel)),
                  ),
                ],
              ),
            )),
      ]),
    );
  }

  List<DropdownMenuItem<OrderStatusEnum>> _getStatus() {
    var branchDropDown = <DropdownMenuItem<OrderStatusEnum>>[];
    for (var element in OrderStatusEnum.values) {
      if (element == OrderStatusEnum.CANCELLED) {
        continue;
      }
      branchDropDown.add(DropdownMenuItem(
        child: Text(
          StatusHelper.getOrderStatusMessages(element),
          overflow: TextOverflow.ellipsis,
        ),
        value: element,
      ));
    }
    return branchDropDown;
  }
}
