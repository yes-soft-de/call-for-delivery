import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_stores/state_manager/stores_inactive_state_manager.dart';

@injectable
class StoresInActiveScreen extends StatefulWidget {
  final StoresInActiveStateManager _stateManager;

  StoresInActiveScreen(this._stateManager);

  @override
  StoresInActiveScreenState createState() => StoresInActiveScreenState();
}

class StoresInActiveScreenState extends State<StoresInActiveScreen> {
  late States currentState;
  bool canAddCategories = true;
  String searchKey = '';
  @override
  void initState() {
    currentState = LoadingState(this);
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
          title: S.of(context).storesInActive, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}
