import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:flutter/material.dart';

class AboutStateLoading extends AboutState {
  AboutStateLoading(AboutScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
