import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_check_api/model/check_api_model.dart';
import 'package:c4d/module_check_api/service/check_api_service.dart';
import 'package:c4d/module_check_api/ui/screen/check_api_screen.dart';
import 'package:c4d/module_check_api/ui/states/check_api_state_error.dart';
import 'package:c4d/module_check_api/ui/states/check_state_success.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class CheckApiStateManager {
  final CheckApiService _checkApiService;

  final PublishSubject<States> _stateSubject = PublishSubject();
  final _loadingStateSubject = PublishSubject<AsyncSnapshot>();

  Stream<States> get stateStream => _stateSubject.stream;
  Stream<AsyncSnapshot> get loadingStream => _loadingStateSubject.stream;

  CheckApiStateManager(this._checkApiService);

  void checkApiHealth(CheckApiScreenState screenState) {
       _loadingStateSubject.add(AsyncSnapshot.waiting());
      _checkApiService.checkApiHealth().then((value) {
        if (value.hasError) {
          _stateSubject.add(
              CheckApiStateError(screenState));
        } else {
          CheckApiModel model = value as CheckApiModel;
          _stateSubject.add(CheckApiStateSuccess(screenState,model.data));
        }
      }).whenComplete(() => _loadingStateSubject.add(AsyncSnapshot.nothing()));
  }
}