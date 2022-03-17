import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/request/captain_offer_request.dart';
import 'package:c4d/module_captain/request/enable_offer.dart';
import 'package:c4d/module_captain/state_manager/captain_offer_state_manager.dart';
import '../widget/offer/captain_offer_form.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/floated_button.dart';
import 'package:c4d/utils/effect/hidder.dart';

@injectable
class CaptainOffersScreen extends StatefulWidget {
  final CaptainOfferStateManager _stateManager;

  CaptainOffersScreen(this._stateManager);

  @override
  CaptainOffersScreenState createState() => CaptainOffersScreenState();
}

class CaptainOffersScreenState extends State<CaptainOffersScreen> {
  late States currentState;
  bool canAddCategories = true;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    widget._stateManager.getCaptainOffer(this);
    super.initState();
  }

  void getCaptainOffer() {
    widget._stateManager.getCaptainOffer(this);
  }

  void addCaptainOffer(CaptainOfferRequest request) {
    widget._stateManager.addCaptainOffer(this, request);
  }

  void updateCaptainOffer(CaptainOfferRequest request) {
    widget._stateManager.updateCaptainOffer(this, request);
  }
  void enableCaptainOffer(EnableOfferRequest request) {
    widget._stateManager.enableCaptainOffer(this, request);
  }
//  void deleteCategories(String id) {
//    widget._stateManager.deleteCategories(this, id);
//  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).captainsOffer, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
      floatingActionButton: Hider(
        active: canAddCategories,
        child: FloatedIconButton(
          text: S.current.addOffer,
          icon: Icons.add_circle_rounded,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                 return CaptainOfferForm(onSave: (request){
                   addCaptainOffer(request);
                 },);
                });
          },
        ),
      ),
    );
  }
}
