import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/model/order/order_model.dart';
import 'package:flutter/material.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class BidOrderCard extends StatelessWidget {
  final OrderModel model;
  final bool isOpen;


  BidOrderCard(this.model, this.isOpen);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        foregroundDecoration:  RotatedCornerDecoration(
          gradient:isOpen? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [Colors.green.shade900, Colors.green.shade300],
          ) :LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [Colors.red.shade900, Colors.red.shade300],
          ) ,
          textSpan: TextSpan(text:isOpen? S.of(context).open : S.of(context).close),
          labelInsets: LabelInsets(baselineShift: 3, start: 1),
          geometry:  BadgeGeometry(alignment: BadgeAlignment.topLeft,height: 45,width: 80),
        ),
        child: Card(
          color: Theme.of(context).cardColor,
          elevation: 5.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            title:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('#'+model.id.toString(),style: TextStyle(color: Theme.of(context).primaryColor ,fontWeight: FontWeight.bold,fontSize: 18),)),
                Divider(
                  indent: 16,
                  endIndent: 16,
                  thickness: 2.5,
                  color: Theme.of(context).backgroundColor,
                ),
                Text(model.title,style: TextStyle(color: Theme.of(context).primaryColor ,fontWeight: FontWeight.bold,fontSize: 18),),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(model.description)),
                Text(model.createdDate,style: TextStyle(color: Theme.of(context).colorScheme.error),)
              ],
            ),
          ),
        ),),
      ),
    );
  }
}
