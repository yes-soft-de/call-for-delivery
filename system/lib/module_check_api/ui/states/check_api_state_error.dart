import 'package:avatar_glow/avatar_glow.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_check_api/ui/screen/check_api_screen.dart';
import 'package:c4d/module_check_api/ui/widget/check_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckApiStateError extends States {
  final CheckApiScreenState screenState;
  CheckApiStateError(this.screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Container(
      color: Colors.red.shade50,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AvatarGlow(
              endRadius: 90,
              duration: Duration(seconds: 2),
              glowColor: Colors.red.shade900,
              repeat: true,
              repeatPauseDuration: Duration(seconds: 1),
              startDelay: Duration(seconds: 1),
              child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
//                    backgroundImage: AssetImage(ImageAsset.LOGO),
                    backgroundColor: Colors.grey[100],
                    radius: 60.0,
                    child: Icon(FontAwesomeIcons.ambulance,size: 60,color: Colors.red.shade900,),
                  )),
            ),
            Text(
              "Hi There",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.0,),
            ),
            Text(
              "I'm Server",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.0,),
            ),

            SizedBox(
              height: 30.0,
            ),
            Text(
              S.of(context).notWell,
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              'Call 911 quickly',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 100.0,
            ),
            GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              child: Transform.scale(
                scale: screenState.scale,
                child: _animatedButtonUI,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget get _animatedButtonUI =>
      CheckButton(screenState.loadingSnapshot.connectionState ==
          ConnectionState.waiting);

  void _onTapDown(TapDownDetails details) {
    screenState.controller.forward();
    screenState.checkApiHealth();
  }

  void _onTapUp(TapUpDetails details) {
    screenState.controller.reverse();
    screenState.checkApiHealth();
  }
}