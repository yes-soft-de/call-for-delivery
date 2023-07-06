import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/module_auth/enums/auth_status.dart';
import 'package:store_web/module_auth/request/register_request/register_request.dart';
import 'package:store_web/module_auth/request/register_request/verfy_code_request.dart';
import 'package:store_web/module_auth/service/auth_service/auth_service.dart';
import 'package:store_web/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:store_web/module_auth/ui/states/register_states/register_state.dart';
import 'package:store_web/module_auth/ui/states/register_states/register_state_code_sent.dart';
import 'package:store_web/module_auth/ui/states/register_states/register_state_init.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class RegisterStateManager {
  final AuthService _authService;
  final _registerStateSubject = PublishSubject<RegisterState>();
  final _loadingStateSubject = PublishSubject<AsyncSnapshot>();
  late RegisterScreenState _registerScreen;
  bool registered = false;
  RegisterStateManager(this._authService) {
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.CODE_SENT:
          _registerScreen.verifyFirst();
          _registerStateSubject
              .add(RegisterStatePhoneCodeSent(_registerScreen));
          break;
        case AuthStatus.CODE_RESENT:
          _registerScreen.resentCodeSucc();
          break;
        case AuthStatus.UNVERIFIED:
          _registerScreen.resendError();
          break;
        case AuthStatus.CODE_TIMEOUT:
          _registerScreen.wrongCode();
          break;
        case AuthStatus.AUTHORIZED:
          _loadingStateSubject.add(const AsyncSnapshot.nothing());
          _registerScreen.moveToNext();
          break;
        case AuthStatus.REGISTERED:
          registered = true;
          break;
        default:
          _loadingStateSubject.add(const AsyncSnapshot.nothing());
          _registerStateSubject.add(RegisterStateInit(_registerScreen));
          break;
      }
    }).onError((err) {
      _loadingStateSubject.add(const AsyncSnapshot.nothing());
      _registerStateSubject.add(RegisterStateInit(_registerScreen,
          error: err, registered: registered));
    });
  }

  Stream<RegisterState> get stateStream => _registerStateSubject.stream;
  Stream<AsyncSnapshot> get loadingStream => _loadingStateSubject.stream;

  void registerClient(
      RegisterRequest request, RegisterScreenState registerScreenState) {
    _loadingStateSubject.add(const AsyncSnapshot.waiting());
    _registerScreen = registerScreenState;
    _authService
        .registerApi(request)
        .whenComplete(() => _loadingStateSubject.add(const AsyncSnapshot.nothing()));
  }

  void verifyClient(
      VerifyCodeRequest request, RegisterScreenState registerScreenState) {
    _loadingStateSubject.add(const AsyncSnapshot.waiting());
    _registerScreen = registerScreenState;
    _authService
        .verifyCodeApi(request)
        .whenComplete(() => _loadingStateSubject.add(const AsyncSnapshot.nothing()));
  }

  void resendCode(
      VerifyCodeRequest request, RegisterScreenState registerScreenState) {
    _loadingStateSubject.add(const AsyncSnapshot.waiting());
    _registerScreen = registerScreenState;
    _authService
        .resendCode(request)
        .whenComplete(() => _loadingStateSubject.add(const AsyncSnapshot.nothing()));
  }
}
