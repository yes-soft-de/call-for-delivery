import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_check_api/model/check_api_model.dart';
import 'package:c4d/module_check_api/ui/screen/check_api_screen.dart';
import 'package:c4d/module_check_api/ui/states/check_api_state_error.dart';
import 'package:c4d/module_check_api/ui/states/check_state_success.dart';
import 'package:c4d/module_rest_data/service/rest_data_service.dart';
import 'package:c4d/module_rest_data/ui/screen/rest_data_screen.dart';
import 'package:c4d/module_rest_data/ui/states/rest_data_state_error.dart';
import 'package:c4d/module_rest_data/ui/states/rest_loading_state.dart';
import 'package:c4d/module_rest_data/ui/states/rest_state_success.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class RestDataStateManager {
  final RestDataService _service;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  RestDataStateManager(this._service, this._authService);

  void restData(RestDataScreenState screenState) {
    _stateSubject.add(RestDataStateLoading(screenState));
      _service.restData().then((value) {
        if (value.hasError) {
          _stateSubject.add(
              RestDataStateError(screenState));
        } else {
          _authService.refreshToken();
          _stateSubject.add(RestDataStateSuccess(screenState));
        }
      });
  }
}