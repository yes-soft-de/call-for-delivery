import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/ui/screen/init_account_screen.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InitAccountStateSuccess extends States {
  final InitAccountScreenState screenState;
  InitAccountStateSuccess(this.screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Lottie.asset(LottieAsset.CREATED_SUCCESSFULLY),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    S.of(context).go,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                onPressed: () {
                  screenState.moveNext();
                }),
          )
        ],
      ),
    );
  }
}
