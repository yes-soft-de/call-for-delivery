import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bidorder/model/offer/offers_model.dart';
import 'package:c4d/module_bidorder/request/offer_state_request.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import '../../screens/bidorder_details/order_offer_details_screen.dart';
import 'package:c4d/module_bidorder/ui/widget/offer_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:flutter/material.dart';

class OrderOfferDetailsStateLoaded extends States {
  final List<OfferModel> offers;
  final OrderOfferDetailsScreenState screenState;
  OrderOfferDetailsStateLoaded(
      this.screenState, {
        required this.offers,
      }) : super(screenState) {}



  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOffers());
  }

  List<Widget> getOffers() {
    var context = screenState.context;
    List<Widget> widgets = [];
    offers.forEach((element) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: OfferCard(
            model: element,
            acceptOffer: (){
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                        onPressed: () {
                          Navigator.of(context).pop();
                          screenState.updateOfferState(OfferStateRequest(priceOfferStatus: 'accepted',offerId: element.id));

                        },
                        content: S.current.confirmAcceptOffer);
                  });
            },
            refuseOffer: (){
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                        onPressed: () {
                          Navigator.of(context).pop();
                          screenState.updateOfferState(OfferStateRequest(priceOfferStatus: 'refused',offerId: element.id));
                        },
                        content: S.current.confirmRefuseOffer);
                  });
            },
          ),
        ),
      ));
    });
    widgets.add(SizedBox(
      height: 75,
    ));
    return widgets;
  }

}