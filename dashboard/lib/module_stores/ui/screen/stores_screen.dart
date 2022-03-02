import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/state_manager/stores_state_manager.dart';
import 'package:c4d/module_stores/ui/state/store_categories/stores_loading_state.dart';
import 'package:c4d/module_stores/ui/state/store_categories/stores_state.dart';
import 'package:c4d/utils/global/global_state_manager.dart';

@injectable
class StoresScreen extends StatefulWidget {
  final StoresStateManager _stateManager;

  StoresScreen(this._stateManager);

  @override
  StoresScreenState createState() => StoresScreenState();
}

class StoresScreenState extends State<StoresScreen> {
  late StoresState currentState;
  bool canAddCategories = true;

  @override
  void initState() {
    currentState = StoresLoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        refresh();
      }
    });
    getIt<GlobalStateManager>().stateStream.listen((event) {
      widget._stateManager.getStores(this);
    });
    widget._stateManager.getStores(this);
    super.initState();
  }

  void getStores() {
    widget._stateManager.getStores(this);
  }

//  void addStore(CreateStoreRequest request) {
//    widget._stateManager.createStore(this, request);
//  }

  void updateStore(UpdateStoreRequest request) {
    widget._stateManager.updateStore(this, request);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).storesList, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}
