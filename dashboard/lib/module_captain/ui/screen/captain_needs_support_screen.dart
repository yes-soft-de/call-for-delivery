import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_captain/state_manager/captain_need_support_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainsNeedsSupportScreen extends StatefulWidget {
  final CaptainsNeedsSupportStateManager _stateManager;

  CaptainsNeedsSupportScreen(this._stateManager);

  @override
  CaptainsNeedsSupportScreenState createState() =>
      CaptainsNeedsSupportScreenState();
}

class CaptainsNeedsSupportScreenState
    extends State<CaptainsNeedsSupportScreen> {
  late States currentState;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    widget._stateManager.getCaptainSupport(this);
    super.initState();
  }

  void getClients() {
    widget._stateManager.getCaptainSupport(this);
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
