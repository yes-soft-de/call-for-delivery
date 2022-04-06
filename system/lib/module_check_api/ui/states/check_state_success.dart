import 'package:avatar_glow/avatar_glow.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_check_api/model/check_api_model.dart';
import 'package:c4d/module_check_api/ui/screen/check_api_screen.dart';
import 'package:c4d/module_check_api/ui/widget/check_button.dart';
import 'package:c4d/module_check_api/ui/widget/view_response_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckApiStateSuccess extends States {
  final CheckApiScreenState screenState;
  final CheckApiModel model;
  CheckApiStateSuccess(this.screenState, this.model) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Container(
      color: Colors.green.shade50,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AvatarGlow(
              endRadius: 90,
              duration: Duration(seconds: 2),
              glowColor: Colors.green.shade900,
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
                    child: Icon(FontAwesomeIcons.checkDouble,size: 60,color: Colors.green.shade900),
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
             S.of(context).fine,
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              'I can give you what you want',
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
            InkWell(
              onTap: (){
                showDialog(context: context, builder: (context)
                {
                  return ViewResponseDialog(model.result);
                });

              },
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 20,),
                child: Text('View response',style: TextStyle(fontWeight: FontWeight.w800),),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget get _animatedButtonUI =>
      CheckButton(
        loading: screenState.loadingSnapshot.connectionState ==
            ConnectionState.waiting,text: 'Check',);

  void _onTapDown(TapDownDetails details) {
    screenState.controller.forward();
    screenState.checkApiHealth();
  }

  void _onTapUp(TapUpDetails details) {
    screenState.controller.reverse();
    screenState.checkApiHealth();
  }
}