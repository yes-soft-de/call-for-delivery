import 'package:c4d/consts/offer_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bidorder/model/offer/offers_model.dart';
import 'package:c4d/utils/helpers/offer_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OfferCard extends StatelessWidget {
  final OfferModel model;
  final Function acceptOffer;
  final Function refuseOffer;

  OfferCard( {required this.model ,required this.acceptOffer , required this.refuseOffer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8,end: 8,bottom: 5),
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: new BoxDecoration(
            border: BorderDirectional(
              start:
              BorderSide(width: 5, color:OfferStatusHelper.getOfferStatusColor(model.state)),
            ),
          ),
          child: ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    verticalTile(context,
                        title: S.current.offerNumber, subtitle:'#'+ model.id.toString()),
                    verticalTile(context,
                        title: S.current.offerStatus, subtitle:OfferStatusHelper.getOfferStatusName(model.state)),
                  ],
                ),
//                Center(child: Text('#'+model.id.toString(),style: TextStyle(color: Theme.of(context).primaryColor ,fontWeight: FontWeight.bold,fontSize: 18),)),
                divider(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    verticalTile(context,
                        title: S.current.offerPrice, subtitle: model.priceOfferValue.toString()+' '+ S.current.sar),
                    verticalTile(context,
                        title: S.current.deliverCost, subtitle: model.totalDeliveryCost.toString()+' '+ S.current.sar),
                    verticalTile(context,
                        title: S.current.profitMargin, subtitle: model.profitMargin.toString()+' '+ S.current.sar),

                  ],
                ),
                divider(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    verticalTile(context,
                        title: S.current.transCount, subtitle: model.transportationCount.toString()),
                    verticalTile(context,
                        title: S.current.carModel, subtitle: model.carModel.toString()),

                  ],
                ),
                divider(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    verticalTile(context,
                        title: S.current.totalPrice , subtitle: model.totalPrice.toString()+' '+ S.current.sar),
                    verticalTile(context,
                        title: S.current.deliverDate, subtitle: model.deliveryDate),

                  ],
                ),
                divider(context),
              ],
            ),
            subtitle:
            (model.state !=OfferStatusEnum.PENDING)? Container():
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    acceptOffer();
                  },
                  child: Card(
                    color: Colors.green.shade900,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(FontAwesomeIcons.check,color: Colors.white,size: 18,),
                    ),),
                ),
                SizedBox(width: 5,),
                InkWell(
                  onTap: (){
                    refuseOffer();
                  },
                  child: Card(
                    color: Colors.red.shade900,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(Icons.close,color: Colors.white,size: 18,),
                    ),),
                ),
              ],
            ),
          ),
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
            fontWeight: FontWeight.bold,fontSize: 16),
        ),
        Text(subtitle,style: TextStyle(fontSize: 14),),
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