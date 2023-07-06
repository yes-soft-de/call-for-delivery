import 'package:store_web/abstracts/states/state.dart';
import 'package:flutter/material.dart';

class LoadingState extends States {
  LoadingState(State<StatefulWidget> screenState) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
