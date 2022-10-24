import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:flutter/material.dart';

class RemoveSubOrderDialog extends StatefulWidget {
  final List<OrderModel> orders;
  final Function(OrderNonSubRequest request) request;
  final int primaryOrder;
  RemoveSubOrderDialog(
      {Key? key,
      required this.orders,
      required this.request,
      required this.primaryOrder})
      : super(key: key);

  @override
  State<RemoveSubOrderDialog> createState() => _RemoveSubOrderDialogState();
}

class _RemoveSubOrderDialogState extends State<RemoveSubOrderDialog> {
  int? orderID;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.current.unlinkSubOrders),
      scrollable: true,
      content: Container(
        child: Column(
          children: subOrders(),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            Widget: Text(S.current.cancel)),
        TextButton(
            onPressed: orderID != null
                ? () {
                    Navigator.of(context).pop();
                    widget.request(OrderNonSubRequest(orderID: orderID));
                  }
                : null,
            Widget: Text(S.current.confirm)),
      ],
    );
  }

  List<Widget> subOrders() {
    List<Widget> widgets = [];
    for (var element in widget.orders) {
      if (element.id == widget.primaryOrder) {
        continue;
      }
      widgets.add(CheckboxListTile(
          title: Text('#' + element.id.toString()),
          value: (orderID != null && element.id != orderID)
              ? null
              : orderID == element.id,
          tristate: (orderID != null && element.id != orderID) ? true : false,
          onChanged: (value) {
            if (value == true) {
              orderID = element.id;
            } else {
              orderID = null;
            }
            setState(() {});
          }));
    }
    return widgets;
  }
}
