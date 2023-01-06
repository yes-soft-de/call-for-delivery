import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../module_orders/orders_routes.dart';
import '../../../utils/helpers/order_status_helper.dart';
import '../../model/captain_activity_details_model.dart';

class CardCaptainActivityDetails extends StatelessWidget {
  final CaptainActivityDetailsModel model;
  const CardCaptainActivityDetails({required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(OrdersRoutes.ORDER_STATUS_SCREEN,
                arguments: model.id);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: StatusHelper.getOrderStatusColor(model.state),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      verticalTile(context,
                          title: S.current.orderNumber,
                          subtitle: model.id.toString()),
                      verticalTile(context,
                          title: S.of(context).orderStatus,
                          subtitle: StatusHelper.getStatusString(model.state)),
                    ],
                  ),
                  divider(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      verticalTile(context,
                          title: S.current.deliverDate,
                          subtitle: model.deliveryDate),
                      verticalTile(context,
                          title: S.current.createDate,
                          subtitle: model.createdDate),
                    ],
                  ),
                  divider(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      verticalTile(context,
                          title: S.current.cost,
                          subtitle:
                              model.orderCost.toString() + ' ${S.current.sar}'),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_circle_left_outlined,
                            color: Colors.white,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

Widget verticalTile(context,
    {required String title, required String subtitle}) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.button?.color),
      ),
      Text(subtitle,
          style: Theme.of(context)
              .textTheme
              .button
              ?.copyWith(fontWeight: FontWeight.normal)),
    ],
  );
}

Widget divider(context) {
  Color dividerColor = Theme.of(context).textTheme.button!.color!;
  return Divider(
    thickness: 2,
    indent: 16,
    endIndent: 16,
    color: dividerColor,
  );
}
