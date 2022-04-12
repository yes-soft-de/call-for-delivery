import 'package:c4d/abstracts/states/state.dart';
import 'package:flutter/material.dart';

class LoadingState extends States {
  LoadingState(State<StatefulWidget> screenState) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
