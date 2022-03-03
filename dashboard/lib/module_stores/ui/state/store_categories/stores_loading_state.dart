import 'package:flutter/material.dart';
import 'package:c4d/module_stores/ui/screen/stores_screen.dart';
import 'package:c4d/module_stores/ui/state/store_categories/stores_state.dart';

class StoresLoadingState extends StoresState {
  StoresLoadingState(StoresScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
