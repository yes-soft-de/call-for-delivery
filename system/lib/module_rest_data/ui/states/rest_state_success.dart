import 'package:avatar_glow/avatar_glow.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_rest_data/ui/screen/rest_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RestDataStateSuccess extends States {
  final RestDataScreenState screenState;
  RestDataStateSuccess(this.screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
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
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'New data added',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'Successfully ✅',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}