import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_order/model/order_details/offer_model.dart';
import 'package:c4d/utils/helpers/offer_status_helper.dart';
import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  final OfferModel model;

  OfferCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8, end: 8, bottom: 5),
      child: Card(
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: new BoxDecoration(
            border: BorderDirectional(
              start: BorderSide(
                  width: 5,
                  color: OfferStatusHelper.getOfferStatusColor(
                      model.priceOfferStatus)),
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
//                backgroundColor: Colors.transparent,
              child: Text('#' + model.id.toString()),
            ),
            title: Column(
              children: [
                Row(
                  children: [
                    Text(
                      S.of(context).price + ': ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(model.priceOfferValue.toString() +
                        ' ' +
                        S.of(context).sar),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      S.of(context).deadLine + ': ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(model.offerDeadline),
                  ],
                ),
              ],
            ),
            subtitle: Text(
              OfferStatusHelper.getOfferStatusMsg(model.priceOfferStatus),
              style: TextStyle(
                  color: OfferStatusHelper.getOfferStatusColor(
                      model.priceOfferStatus)),
            ),
          ),
        ),
      ),
    );
  }
}
//Card(
//child: ListTile(
//leading: CircleAvatar(
//backgroundColor: Colors.transparent,
//backgroundImage: AssetImage(ImageAsset.LOGO)),
//title: Text('20 ر.س'),
//),
//);
