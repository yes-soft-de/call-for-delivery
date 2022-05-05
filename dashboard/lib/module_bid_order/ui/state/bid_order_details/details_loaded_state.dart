import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_order/model/order_details/order_details_model.dart';
import 'package:c4d/module_bid_order/ui/screen/order_details_screen.dart';
import 'package:c4d/module_bid_order/ui/widget/offer_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderDetailsStateLoaded extends States {
  final OrderDetailsModel model;
  final BidOrderDetailsScreenState screenState;
  OrderDetailsStateLoaded(
    this.screenState, {
    required this.model,
  }) : super(screenState) {}



  @override
  Widget getUI(BuildContext context) {
    return StackedForm(
      label:'',
      child: CustomListView.custom(
        children: [
        model.images.isEmpty ?
        Image.asset(ImageAsset.PLACEHOLDER,height: 250,):  CarouselSlider.builder(
            options: CarouselOptions(
                height: 250.0, autoPlay: true, pageSnapping: true),
            itemCount: model.images.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Padding(
              padding: const EdgeInsets.all(2.0),
              child: CustomNetworkImage(
                imageSource: model.images[itemIndex],
                height: 200,
                width: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: model.openToPriceOffer ? Colors.green.shade900 :Colors.red.shade900 ,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 3, bottom: 3),
                            child: Text(
                              model.openToPriceOffer ? S.of(context).open :S.of(context).close ,
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          model.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(model.description),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.only(start: 12.0),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.solidCalendarAlt,
                              color: Colors.grey,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              model.createdDate,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(
            indent: 16,
            endIndent: 16,
            thickness: 2.5,
            color: Theme.of(context).backgroundColor,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 8,end: 8),
            child: Text(S.of(context).supplierOffer,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return OfferCard(model: model.offers[index]);
            },
            itemCount: model.offers.length,
            shrinkWrap: true,
          ),
          SizedBox(height: 55,)
        ],
      ),
      onTap: (){
      },
      visible: false,
    );
  }

}
