import 'package:c4d/utils/images/images.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingState extends States {
  final bool picture;
  LoadingState(State<StatefulWidget> screenState, {this.picture = false})
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    if (picture) {
      return Center(
        child: LottieBuilder.asset(LottieAsset.LOADING_BOX),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
