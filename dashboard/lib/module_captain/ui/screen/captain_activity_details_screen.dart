import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/state_manager/captain_activity_details_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../generated/l10n.dart';
import '../../../utils/components/custom_app_bar.dart';

@injectable
class CaptainActivityDetailsScreen extends StatefulWidget {
  final CaptainActivityDetailsStateManager _stateManager;

  const CaptainActivityDetailsScreen(this._stateManager);

  @override
  CaptainActivityDetailsScreenState createState() =>
      CaptainActivityDetailsScreenState();
}

class CaptainActivityDetailsScreenState
    extends State<CaptainActivityDetailsScreen> {
  late States currentState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
  }

  CaptainActivityDetailsStateManager get statemanager => widget._stateManager;

  void getCaptainActivityDetails() {
    widget._stateManager.getCaptainActivityDetails(this, captainId);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  int captainId = -1;
  String captainName = '';

  Widget build(BuildContext context) {
    if (captainId == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null && arg is List) {
        captainId = arg[0];
        captainName = arg[1];
        widget._stateManager.getCaptainActivityDetails(this, captainId);
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.captainractivityDetails + ' ${captainName}',
      ),
      body: currentState.getUI(context),
    );
  }
}
