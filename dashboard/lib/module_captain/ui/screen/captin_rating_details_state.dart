import 'dart:async';

import 'package:flutter/material.dart';

import '../../../abstracts/states/loading_state.dart';
import '../../../abstracts/states/state.dart';
import '../../../di/di_config.dart';
import '../../../generated/l10n.dart';
import '../../../utils/components/custom_app_bar.dart';
import '../../../utils/global/global_state_manager.dart';
import '../../state_manager/captin_rating_details_state_manager.dart';

class CaptinRatingDetailsScreen extends StatefulWidget {
  final CaptinRatingDetailsStateManager _stateManager;

  CaptinRatingDetailsScreen(this._stateManager);

  @override
  CaptinRatingDetailsScreenState createState() =>
      CaptinRatingDetailsScreenState();
}

class CaptinRatingDetailsScreenState extends State<CaptinRatingDetailsScreen> {
  late States currentState;
  StreamSubscription? global;
  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    global = getIt<GlobalStateManager>().stateStream.listen((event) {
      getCaptainRating();
    });
    super.initState();
  }

  void getCaptainRating() {
    widget._stateManager.getCaptinRatingDetails(this, captainId);
  }

  CaptinRatingDetailsStateManager get stateManager => widget._stateManager;
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  int captainId = -1;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (captainId == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        captainId = arg;
        widget._stateManager.getCaptinRatingDetails(this, captainId);
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.captainratingDetails,
      ),
      body: currentState.getUI(context),
    );
  }
}
