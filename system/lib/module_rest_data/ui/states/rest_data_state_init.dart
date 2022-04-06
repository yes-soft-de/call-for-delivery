import 'package:avatar_glow/avatar_glow.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_check_api/ui/screen/check_api_screen.dart';
import 'package:c4d/module_check_api/ui/widget/check_button.dart';
import 'package:c4d/module_check_api/ui/widget/delayed_animation.dart';
import 'package:c4d/module_rest_data/ui/screen/rest_data_screen.dart';
import 'package:c4d/module_users/ui/widget/update_pass_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RestDataStateInit extends States {
  final RestDataScreenState screenState;
  RestDataStateInit(this.screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
           children: <Widget>[
            AvatarGlow(
              endRadius: 90,
              duration: Duration(milliseconds: 2000),
              glowColor: Colors.red.shade900,
              animate: true,
              repeat: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              showTwoGlows: true,
              child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.red[900],
                    radius: 60.0,
                    child: Icon(FontAwesomeIcons.solidBell,size: 60,color: Colors.white,),
                  )),
            ),
             SizedBox(
               height: 10.0,
             ),
            Text(
              "Be careful 🤚",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35.0,),
            ),
             SizedBox(
               height: 50.0,
             ),
            Text(
              "When click the button",
              style: TextStyle(
                  fontSize: 18.0,),
            ),
             SizedBox(
               height: 10.0,
             ),
             Text(
               "All data will be",
               style: TextStyle(
                 fontSize: 18.0,),
             ),
             SizedBox(
               height: 10.0,
             ),
             Text(
               "Deleted 🗑",
               style: TextStyle(
                 color: Colors.red.shade900,
                 fontSize: 20.0,),
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

      CheckButton(
         loading: screenState.loadingSnapshot.connectionState ==
          ConnectionState.waiting,text: 'Rest Data',);

  void _onTapDown(TapDownDetails details) {
    screenState.controller.forward();
    screenState.checkPassword();
  }

  void _onTapUp(TapUpDetails details) {
    screenState.controller.reverse();
    screenState.checkPassword();

  }

}