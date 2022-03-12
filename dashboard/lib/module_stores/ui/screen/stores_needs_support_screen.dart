import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_stores/state_manager/stores_need_support_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoresNeedsSupportScreen extends StatefulWidget {
  final StoresNeedsSupportStateManager _stateManager;

  StoresNeedsSupportScreen(this._stateManager);

  @override
  StoreNeedsSupportScreenState createState() =>
      StoreNeedsSupportScreenState();
}

class StoreNeedsSupportScreenState extends State<StoresNeedsSupportScreen> {
  late States currentState;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    widget._stateManager.getStores(this);
    super.initState();
  }

  void getClients() {
    widget._stateManager.getStores(this);
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
          title: S.of(context).directSupport, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}
