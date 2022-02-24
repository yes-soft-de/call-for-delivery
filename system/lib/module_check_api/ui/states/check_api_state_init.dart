import 'package:avatar_glow/avatar_glow.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custem_button.dart';
import 'package:c4d/module_check_api/ui/screen/check_api_screen.dart';
import 'package:c4d/module_check_api/ui/widget/check_button.dart';
import 'package:c4d/module_check_api/ui/widget/delayed_animation.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckApiStateInit extends States {
  final CheckApiScreenState screenState;
  CheckApiStateInit(this.screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AvatarGlow(
              endRadius: 90,
              duration: Duration(seconds: 2),
              glowColor: Colors.blue.shade900,
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
                    child: Icon(FontAwesomeIcons.server,size: 60,),
                  )),
            ),
            DelayedAnimation(
              child: Text(
                "Hi There",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,),
              ),
              delay: screenState.delayedAmount,
            ),
            DelayedAnimation(
              child: Text(
                "I'm Server",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,),
              ),
              delay: screenState.delayedAmount + 1000,
            ),
            SizedBox(
              height: 30.0,
            ),
            DelayedAnimation(
              child: Text(
                'To keep me safe',
                style: TextStyle(fontSize: 20.0),
              ),
              delay: screenState.delayedAmount + 2000,
            ),
            DelayedAnimation(
              child: Text(
                'Check my heartbeat',
                style: TextStyle(fontSize: 20.0),
              ),
              delay: screenState.delayedAmount + 3000,
            ),
            SizedBox(
              height: 100.0,
            ),
            DelayedAnimation(
              child: GestureDetector(
                onTapDown: _onTapDown,
                onTapUp: _onTapUp,
                child: Transform.scale(
                  scale: screenState.scale,
                  child: _animatedButtonUI,
                ),
              ),
              delay: screenState.delayedAmount + 4000,
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