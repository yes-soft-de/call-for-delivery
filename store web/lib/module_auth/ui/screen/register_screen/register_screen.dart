import 'dart:async';
import 'package:store_web/module_splash/splash_routes.dart';
import 'package:store_web/utils/components/custom_app_bar.dart';
import 'package:store_web/utils/components/fixed_container.dart';
import 'package:store_web/utils/images/images.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:store_web/module_auth/request/register_request/register_request.dart';
import 'package:store_web/module_auth/request/register_request/verfy_code_request.dart';
import 'package:store_web/module_auth/state_manager/register_state_manager/register_state_manager.dart';
import 'package:store_web/module_auth/ui/states/register_states/register_state.dart';
import 'package:store_web/module_auth/ui/states/register_states/register_state_code_sent.dart';
import 'package:store_web/module_auth/ui/states/register_states/register_state_init.dart';
import 'package:flutter/material.dart';
import 'package:store_web/utils/helpers/custom_flushbar.dart';

@injectable
class RegisterScreen extends StatefulWidget {
  final RegisterStateManager _stateManager;

  const RegisterScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  late RegisterState _currentState;
  late AsyncSnapshot loadingSnapshot;
  late StreamSubscription _stateSubscription;
  late bool flags = true;
  bool activeResend = false;
  late bool canPop;

  @override
  void initState() {
    super.initState();
    canPop = Navigator.of(context).canPop();
    loadingSnapshot = const AsyncSnapshot.nothing();
    _currentState = RegisterStateInit(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        setState(() {
          _currentState = event;
        });
      }
    });
    widget._stateManager.loadingStream.listen((event) {
      if (mounted) {
        setState(() {
          loadingSnapshot = event;
        });
      }
    });
  }

  dynamic args;
  var flag = true;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && flag) {
      if (args is Map) {
        _currentState = RegisterStatePhoneCodeSent(this);
        flag = false;
        refresh();
      }
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(255, 233, 195, 113),
            ),
          ),
          Image.asset(
            ImageAsset.AUTH_BACKGROUND,
            fit: BoxFit.fill,
          ),
          Scaffold(
            appBar: CustomC4dAppBar.appBar(
              context,
              canGoBack: canPop,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: FixedContainer(
              child: loadingSnapshot.connectionState != ConnectionState.waiting
                  ? _currentState.getUI(context)
                  : Stack(
                      children: [
                        _currentState.getUI(context),
                        Container(
                          width: double.maxFinite,
                          color: Colors.transparent.withOpacity(0.0),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  void registerClient(RegisterRequest request) {
    widget._stateManager.registerClient(request, this);
  }

  void verifyClient(VerifyCodeRequest request) {
    widget._stateManager.verifyClient(request, this);
  }

  void resendCode(VerifyCodeRequest request) {
    widget._stateManager.resendCode(request, this);
  }

  void resentCodeSucc() {
    CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.resendCodeSuccessfully)
        .show(context);
  }

  void wrongCode() {
    CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.invalidCode)
        .show(context);
  }

  void resendError() {
    CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.errorHappened)
        .show(context);
  }

  void verifyFirst() {
    CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.notVerifiedNumber)
        .show(context);
  }

  void moveToNext() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(SplashRoutes.SPLASH_SCREEN, (route) => false);
    CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.registerSuccess)
        .show(context);
  }

  Future<void> userRegistered() async {
    await CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.registerSuccess,
            timeout: 2)
        .show(context);
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }
}
