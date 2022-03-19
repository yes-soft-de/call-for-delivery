import 'package:c4d/utils/images/images.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingState extends States {
  LoadingState(State<StatefulWidget> screenState) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: LottieBuilder.asset(LottieAsset.LOADING_BOX),
    );
  }
}
