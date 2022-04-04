import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_rest_data/ui/screen/rest_data_screen.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_background/animated_background.dart';

class RestDataStateLoading extends States {
  final RestDataScreenState screenState;
  RestDataStateLoading(this.screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Lottie.asset(LottieAsset.CLOUD_STORAGE,height: 200,width: 200),
              Text(
                'The process may take some time',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Please waiting...',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
//       AnimatedBackground(
//    behaviour: RandomParticleBehaviour(
//        options: ParticleOptions(baseColor: Theme.of(context).primaryColor,particleCount: 50)),
//    vsync: screenState,
//    child: Container(),
//    ),

      ],
    );
  }
}