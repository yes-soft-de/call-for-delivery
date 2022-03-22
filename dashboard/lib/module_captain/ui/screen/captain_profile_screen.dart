import 'package:c4d/module_captain/request/enable_captain.dart';
import 'package:c4d/module_captain/request/update_captain_request.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/captains_routes.dart';
import 'package:c4d/module_captain/state_manager/captain_profile_state_manager.dart';

@injectable
class CaptainProfileScreen extends StatefulWidget {
  final CaptainProfileStateManager _stateManager;

  CaptainProfileScreen(this._stateManager);

  @override
  CaptainProfileScreenState createState() => CaptainProfileScreenState();
}

class CaptainProfileScreenState extends State<CaptainProfileScreen> {
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

  void getCaptain() {
    widget._stateManager.getCaptainProfile(this, captainId);
  }

  void enableCaptain(String status ) {
    widget._stateManager.acceptCaptainProfile(this, captainId, EnableCaptainRequest(id: captainId,status:status));
  }
  void updateCaptainProfile(UpdateCaptainRequest request) {
    widget._stateManager.updateCaptainProfile(this , request);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  int captainId = -1;

  @override
  Widget build(BuildContext context) {
    if (captainId == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        captainId = arg;
        widget._stateManager.getCaptainProfile(this, captainId);
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.profile,
//          actions: [
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Align(
//                alignment: AlignmentDirectional.centerStart,
//                child: InkWell(
//                  customBorder: CircleBorder(),
//                  onTap: () {
////                    Navigator.pushNamed(context, CaptainsRoutes.CAPTAIN_BALANCE,
////                        arguments: captainId);
//                  },
//                  child: Container(
//                    decoration: BoxDecoration(
//                        color: Theme.of(context).primaryColor,
//                        shape: BoxShape.circle),
//                    child: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Icon(
//                        Icons.account_balance,
//                        color: Colors.white,
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ]
      ),
      body: currentState.getUI(context),
    );
  }
}
