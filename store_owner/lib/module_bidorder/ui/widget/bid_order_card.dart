import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bidorder/bid_orders_routes.dart';
import 'package:c4d/module_bidorder/model/order/order_model.dart';
import 'package:flutter/material.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class BidOrderCard extends StatelessWidget {
  final BidOrderModel model;
  final bool isOpen;
  final Function deleteOrder;


  BidOrderCard({required this.model,required this.isOpen,required this.deleteOrder});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
       isOpen ?  Navigator.pushNamed(context, BidOrdersRoutes.ORDER_OFFERS_SCREEN,arguments: model.bidOrderId) :
       Navigator.pushNamed(context, BidOrdersRoutes.BID_ORDER_STATUS_SCREEN,arguments: model.id);
      },
      child: Padding(
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
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.note),
                  divider(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      verticalTile(context,
                          title: S.current.branch, subtitle: model.branchName),
                      verticalTile(context,
                          title:  S.current.paymentMethod, subtitle: model.payment =='cash' ? S.of(context).cash :S.current.card),
                      verticalTile(context,
                          title: S.current.createdDate, subtitle: model.createdDate),
                    ],
                  ),
                  divider(context),
                  // divider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      verticalTile(context,
                          title: S.current.category, subtitle: model.supplierCategoryName),
                    isOpen ?     InkWell(
                      onTap: (){
                        deleteOrder();
                      },
                      child: Card(
                        color: Colors.red.shade900,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(Icons.delete,color: Colors.white,size: 18,),
                        ),),
                    ) :Container()
                    ],
                  ),
                ],
              ),
            ),
          ),),
        ),
      ),
    );
  }

  Widget verticalTile(context,
      {required String title, required String subtitle}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,),
        ),
        Text(subtitle),
      ],
    );
  }

  Widget divider(context) {
    return Divider(
      thickness: 2,
      indent: 16,
      endIndent: 16,
      color: Theme.of(context).backgroundColor,
    );
  }
}
