import 'dart:async';

import 'package:c4d/di/di_config.dart';
import 'package:flutter/material.dart';

import '../../../abstracts/states/loading_state.dart';
import '../../../abstracts/states/state.dart';
import '../../../generated/l10n.dart';
import '../../../utils/components/custom_app_bar.dart';
import '../../state_manager/caption_rating_details_state_manager.dart';

class CaptainRatingDetailsScreen extends StatefulWidget {
  CaptainRatingDetailsScreen();

  @override
  CaptainRatingDetailsScreenState createState() =>
      CaptainRatingDetailsScreenState();
}

class CaptainRatingDetailsScreenState
    extends State<CaptainRatingDetailsScreen> {
  late States currentState;
  late CaptainRatingDetailsStateManager _stateManager;
  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _streamSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void getCaptainRating() {
    _stateManager.getCaptainRatingDetails(this, captainId);
  }

  CaptainRatingDetailsStateManager get stateManager => _stateManager;
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
        _stateManager.getCaptainRatingDetails(this, captainId);
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.captainractivityDetails,
      ),
      body: currentState.getUI(context),
    );
  }
}
