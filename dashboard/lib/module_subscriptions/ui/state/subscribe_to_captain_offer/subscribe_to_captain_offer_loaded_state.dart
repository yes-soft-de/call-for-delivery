import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captain_offer_model.dart';
import 'package:c4d/module_captain/ui/widget/offer/offer_card.dart';
import 'package:c4d/module_subscriptions/request/store_captain_offer_request.dart';
import 'package:c4d/module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class SubscribeToCaptainOfferLoadedState extends States {
  List<CaptainsOffersModel> packages;
  final CreateSubscriptionToCaptainOfferScreenState screenState;
  SubscribeToCaptainOfferLoadedState(this.screenState, this.packages)
      : super(screenState);
  int? _selectedPackageId;
  String? appBarTitle;
  @override
  Widget getUI(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      appBarTitle = args;
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: appBarTitle ?? S.current.captainOffers,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DottedLine(
                dashColor: Theme.of(context).backgroundColor,
                lineThickness: 4,
              ),
            ),
            //package
            ScalingWidget(
              fade: true,
              milliseconds: 1000,
              child: SizedBox(
                height: 225,
                child: ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  children: _getPackages(),
                ),
              ),
            ),
            // Submit Package
            Visibility(
              visible: _selectedPackageId != null,
              child: ScalingWidget(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                      onPressed: () {
                        screenState.subscribeToPackage(
                          StoreSubscribeToCaptainOfferRequest(
                              captainOffer: _selectedPackageId,
                              storeOwner: screenState.storeID),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          S.of(context).subscribe,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 75,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getPackages() {
    if (packages.isEmpty) {
      return [];
    }
    return packages.map((element) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            if (element.id == _selectedPackageId) {
              _selectedPackageId = null;
            } else {
              _selectedPackageId = element.id;
            }
            screenState.refresh();
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: element.id == _selectedPackageId
                    ? Theme.of(screenState.context).colorScheme.primary
                    : null),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CaptainOfferCard(
                model: element,
                onEdit: () {},
                onEnable: () {},
                justShown: true,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
