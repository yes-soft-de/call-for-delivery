import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_users/request/filter_user_request.dart';
import 'package:c4d/module_users/request/update_pass_request.dart';
import 'package:c4d/module_users/state_manager/users_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class UsersScreen extends StatefulWidget {
  final UserStateManager _stateManager;

  UsersScreen(
      this._stateManager,
      );

  @override
  State<StatefulWidget> createState() => UsersScreenState();
}

class UsersScreenState extends State<UsersScreen>  {
  late StreamSubscription _streamSubscription;
  late States currentState;

  FilterUserRequest request = FilterUserRequest();

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }


  @override
  void initState() {
    currentState = LoadingState(this);
    _streamSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.getUsers(this,request);
    super.initState();
  }

  void getUsers(FilterUserRequest request){
    widget._stateManager.getUsers(this, request);
  }
  void updatePassword(UpdatePassRequest request){
    widget._stateManager.updatePassword(this, request);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text('Users'),),
      body: currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}