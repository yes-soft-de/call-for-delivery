import 'dart:async';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart';
import 'package:c4d/module_auth/request/register_request/verfy_code_request.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/images/images.dart';

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
      body: Form(
        key: _verifyKey,
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Image.asset(
              ImageAsset.LOGO,
              height: 200,
              width: 150,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 8.0, left: 32, right: 32, top: 8),
              child: Text(
                S.of(context).codeSendToYou,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    autovalidateMode: mode,
                    toolbarOptions: const ToolbarOptions(
                        copy: true, paste: true, selectAll: true, cut: true),
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    validator: (value) {
                      if (mode == AutovalidateMode.disabled) {
                        mode = AutovalidateMode.onUserInteraction;
                        screen.refresh();
                      }
                      if (value == null) {
                        return S.of(context).pleaseCompleteField;
                      } else if (value.length < 6) {
                        return S.of(context).invalidCode;
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.of(context).enterCodeSentToYou,
                      prefixIcon: const Icon(Icons.confirmation_num),
                      filled: true,
                      fillColor: Theme.of(context).backgroundColor,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0, left: 16, bottom: 8.0, top: 8.0),
              child: Container(
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
    );
  }
}
