import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_captain/request/captain_offer_request.dart';
import 'package:c4d/module_captain/request/enable_offer.dart';
import 'package:c4d/module_captain/state_manager/captain_offer_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/floated_button.dart';
import 'package:c4d/utils/effect/hidder.dart';
import 'package:flutter/material.dart';

import '../widget/offer/captain_offer_form.dart';

class CaptainOffersScreen extends StatefulWidget {
  CaptainOffersScreen();

  @override
  CaptainOffersScreenState createState() => CaptainOffersScreenState();
}

class CaptainOffersScreenState extends State<CaptainOffersScreen> {
  late States currentState;
  late CaptainOfferStateManager _stateManager;
  late StreamSubscription _streamSubscription;

  bool canAddCategories = true;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _streamSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    _stateManager.getCaptainOffer(this);
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void getCaptainOffer() {
    _stateManager.getCaptainOffer(this);
  }

  void addCaptainOffer(CaptainOfferRequest request) {
    _stateManager.addCaptainOffer(this, request);
  }

  void updateCaptainOffer(CaptainOfferRequest request) {
    _stateManager.updateCaptainOffer(this, request);
  }

  void enableCaptainOffer(EnableOfferRequest request, [bool loading = true]) {
    _stateManager.enableCaptainOffer(this, request, loading);
  }
//  void deleteCategories(String id) {
//    _stateManager.deleteCategories(this, id);
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
                  return CaptainOfferForm(
                    onSave: (request) {
                      addCaptainOffer(request);
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
