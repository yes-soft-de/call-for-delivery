import 'package:c4d/module_branches/branches_routes.dart';
import 'package:c4d/module_stores/request/active_store_request.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/state_manager/store_profile_state_manager.dart';
import 'package:c4d/module_stores/stores_routes.dart';

@injectable
class StoreInfoScreen extends StatefulWidget {
  final StoreProfileStateManager stateManager;

  StoreInfoScreen(this.stateManager);

  @override
  StoreInfoScreenState createState() => StoreInfoScreenState();
}

class StoreInfoScreenState extends State<StoreInfoScreen> {
  bool flagArgs = true;
  late States currentState;
  StoresModel? model;

  void getStore(int id) {
    widget.stateManager.getStore(this, id);
  }

  void enableStore(ActiveStoreRequest request, [bool loading = true]) {
    widget.stateManager.enableStore(this, request, loading);
  }

  @override
  void initState() {
    currentState = LoadingState(this);
    widget.stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && flagArgs) {
      if (args is StoresModel) {
        model = args;
        flagArgs = false;
        getStore(model?.id ?? -1);
      }
    }

    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: model?.storeOwnerName ?? S.current.storeName,
          actions: [
            CustomC4dAppBar.actionIcon(context, onTap: () {
              Navigator.of(context).pushNamed(
                      BranchesRoutes.BRANCHES_LIST_SCREEN,
                      arguments: model?.id ?? -1);
            }, icon: Icons.location_on_rounded)
          ]),
      body: currentState.getUI(context),
    );
  }
}
