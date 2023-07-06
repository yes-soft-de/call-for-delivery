import 'dart:async';
import 'package:store_web/di/di_config.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:store_web/module_auth/presistance/auth_prefs_helper.dart';
import 'package:store_web/module_auth/request/register_request/verfy_code_request.dart';
import 'package:store_web/module_auth/service/auth_service/auth_service.dart';
import 'package:store_web/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:store_web/module_auth/ui/states/register_states/register_state.dart';
import 'package:store_web/module_auth/ui/widget/custom_auth_filed.dart';
import 'package:flutter/material.dart';
import 'package:store_web/utils/helpers/custom_flushbar.dart';

class RegisterStatePhoneCodeSent extends RegisterState {
  bool retryEnabled = false;
  late Timer _timer;
  int _start = 59;
  RegisterStatePhoneCodeSent(RegisterScreenState screen, {String? error})
      : super(screen) {
    startTimer();
    if (error != null) {
      CustomFlushBarHelper.createError(
              title: S.current.warnning, message: error)
          .show(screen.context);
    }
  }
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          retryEnabled = true;
          screen.refresh();
        } else {
          _start--;
          screen.refresh();
        }
      },
    );
  }

  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> _verifyKey = GlobalKey<FormState>();
  AutovalidateMode mode = AutovalidateMode.disabled;

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _verifyKey,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Center(
                  child: Text(
                    S.current.register,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: const Color(0xff03816A),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              CustomAuthFiled(
                controller: codeController,
                title: S.current.codeSendToYou,
                icon: Icons.qr_code_scanner,
                maxLength: 6,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      screen.verifyClient(VerifyCodeRequest(
                          userID: getIt<AuthService>().username,
                          code: codeController.text,
                          password: getIt<AuthPrefsHelper>().getPassword()));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: screen.loadingSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              S.of(context).confirm,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  S.current.youCanResendAfter +
                      ' ' +
                      '00:${_start < 10 ? '0$_start' : _start}',
                  style: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
              SizedBox(
                child: SizedBox(
                  width: 75,
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      onPressed: retryEnabled
                          ? () {
                              _start = 59;
                              startTimer();
                              retryEnabled = false;
                              Future.delayed(const Duration(seconds: 60), () {
                                retryEnabled = true;
                                screen.refresh();
                              });
                              screen.refresh();
                              screen.resendCode(VerifyCodeRequest(
                                  userID: getIt<AuthService>().username));
                            }
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          S.of(context).resendCode,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
