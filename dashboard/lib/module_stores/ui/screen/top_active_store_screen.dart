import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_stores/request/filter_store_activity_request.dart';
import 'package:c4d/module_stores/state_manager/top_active_store.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class TopActiveStoreScreen extends StatefulWidget {
  final TopActiveStateManagment _stateManager;

  TopActiveStoreScreen(this._stateManager);
  @override
  TopActiveStoreScreenState createState() => TopActiveStoreScreenState();
}

class TopActiveStoreScreenState extends State<TopActiveStoreScreen> {
  late States currentState;
  FilterStoreActivityRequest? filter;
  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    // getIt<GlobalStateManager>().stateStream.listen((event) {
    getTopActivityStore();
    // });
    filter = FilterStoreActivityRequest();
    super.initState();
  }

  void getTopActivityStore() {
    widget._stateManager.getTopActiveStore(this);
  }

  TopActiveStateManagment get stateManager => widget._stateManager;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.topstoreActivity, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}
