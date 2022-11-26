import 'package:c4d/module_captain/state_manager/captain_rating_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';

@injectable
class CaptainsRatingScreen extends StatefulWidget {
  final CaptainsRatingStateManager _stateManager;

  CaptainsRatingScreen(this._stateManager);

  @override
  CaptainsRatingScreenState createState() => CaptainsRatingScreenState();
}

class CaptainsRatingScreenState extends State<CaptainsRatingScreen> {
  late States currentState;
  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    super.initState();
  }

  CaptainsRatingStateManager get stateManager => widget._stateManager;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.captainsRating,
      ),
      body: currentState.getUI(context),
    );
  }
}
