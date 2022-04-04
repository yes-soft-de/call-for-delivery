import 'dart:async';

import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
 import 'package:c4d/module_rest_data/state_manager/rest_data_state_manager.dart';
import 'package:c4d/module_rest_data/ui/states/rest_data_state_init.dart';
import 'package:c4d/module_rest_data/ui/states/rest_loading_state.dart';
import 'package:c4d/module_users/ui/widget/update_pass_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

@injectable
class RestDataScreen extends StatefulWidget {
  final RestDataStateManager _stateManager;

  RestDataScreen(
      this._stateManager,
      );

  @override
  State<StatefulWidget> createState() => RestDataScreenState();
}

class RestDataScreenState extends State<RestDataScreen>  with TickerProviderStateMixin  {
  late StreamSubscription _streamSubscription;
  late States currentState;
  late AsyncSnapshot loadingSnapshot;

  final int delayedAmount = 100;
 late double scale;
late  AnimationController controller;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void restData() {
    widget._stateManager.restData(this);
  }

  @override
  void initState() {
    loadingSnapshot = AsyncSnapshot.nothing();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 50,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });

    currentState = RestDataStateInit(this);
    _streamSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - controller.value;
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).restData),),

      body: currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
  checkPassword(){
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialogBox(title:S.of(context).enterYourPassword,titleAction: 'Rest data',hintText: 'Confirm password',
              updatePass: (newPass){
                newPass as String;
                if(newPass.compareTo(getIt<AuthService>().password) == 0){
                   restData();
                }else{
                  Fluttertoast.showToast(msg: S.of(context).passwordNotMatch);
                }
              });
        });

  }
}