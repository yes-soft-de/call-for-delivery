import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_supplier/request/filter_supplier_ads.dart';
import 'package:c4d/module_supplier/state_manager/supplier_ads_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SupplierAdsScreen extends StatefulWidget {
  final SupplierAdsStateManager _stateManager;


  SupplierAdsScreen(this._stateManager);

  @override
  SupplierAdsScreenState createState() => SupplierAdsScreenState();
}

class SupplierAdsScreenState extends State<SupplierAdsScreen> {
  late States _currentState;
  int supplierProfileId = -1;

  void refresh() {
    if (mounted) setState(() {});
  }


  @override
  void initState() {
    _currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      refresh();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (supplierProfileId == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        supplierProfileId = arg;
        widget._stateManager.getSupplierAds(this, FilterSupplierAds(supplierProfileId: supplierProfileId));
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).suppliers, icon: Icons.menu, onTap: () {
            GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
          }),
      body: _currentState.getUI(context),
    );
  }
}
