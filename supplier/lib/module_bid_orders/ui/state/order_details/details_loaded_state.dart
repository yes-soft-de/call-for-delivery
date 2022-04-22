import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/model/order_details/order_details_model.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/order_details_screen.dart';
import 'package:c4d/module_bid_orders/ui/widgets/offer_card.dart';
import 'package:c4d/module_profile/ui/widget/init_field/init_field.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class OrderDetailsStateLoaded extends States {
  final OrderDetailsModel model;
  final OrderDetailsScreenState screenState;
  OrderDetailsStateLoaded(
    this.screenState, {
    required this.model,
  }) : super(screenState) {}



  @override
  Widget getUI(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()),
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
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
          model.openToPriceOffer ?    Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).addYourOffer,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          CustomFormField(
                            controller: screenState.priceController,
                            hintText: S.of(context).price,
                            numbers: true,
                          ),
                          SizedBox(height: 10,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Theme.of(context).backgroundColor,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      builder: (context, widget) {
                                        bool isDark =
                                        getIt<ThemePreferencesHelper>()
                                            .isDarkMode();

                                        if (isDark == false)
                                          return widget ?? SizedBox();
                                        return Theme(
                                            data: ThemeData.dark().copyWith(
                                                primaryColor: Colors.indigo),
                                            child: widget ?? SizedBox());
                                      },
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2023))
                                      .then((value) {
                                        if(value != null)
                                      screenState.offerTime = value.toIso8601String();
                                        screenState.refresh();
                                  });
                                },
                                title: Text(screenState.offerTime != null
                                    ? DateFormat('yyyy/M/d').format(DateTime.parse(
                                    screenState.offerTime ??
                                        DateTime.now().toIso8601String()))
                                    : S.of(context).deadLine),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        screenState.addOffer();
                      },
                      child: Card(
                        color: Colors.green.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(FontAwesomeIcons.check,color: Colors.white,),
                        ),),
                    ),
                  ],
                ),
              ):Container(),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 8,end: 8),
                child: Text(S.of(context).myOffers,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ),

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return OfferCard(model.offers[index]);
                },
                itemCount: model.offers.length,
                shrinkWrap: true,
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        )
      ],
    );
  }
}
