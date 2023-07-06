import 'dart:async';
import 'package:store_web/abstracts/states/state.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:store_web/module_auth/ui/widget/custom_auth_filed.dart';
import 'package:flutter/material.dart';
import 'package:store_web/module_auth/request/forget_password_request/verify_new_password_request.dart';
import 'package:store_web/module_auth/ui/screen/forget_password_screen/forget_password_screen.dart';
import 'package:store_web/utils/helpers/custom_flushbar.dart';

class ForgotStatePhoneCodeSent extends States {
  bool retryEnabled = false;
  ForgotPassScreenState screen;
  ForgotStatePhoneCodeSent(this.screen, {String? error}) : super(screen) {
    Future.delayed(const Duration(seconds: 60), () {}).whenComplete(() {
      retryEnabled = true;
      screen.refresh();
    });
    if (error != null) {
      CustomFlushBarHelper.createError(
              title: S.current.warnning, message: error)
          .show(screen.context);
    }
  }

  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> _verifyKey = GlobalKey<FormState>();
  AutovalidateMode mode = AutovalidateMode.disabled;

  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _verifyKey,
            child: ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                const SizedBox(height: 150),
                CustomAuthFiled(
                  controller: codeController,
                  title: S.current.codeNumber,
                  icon: Icons.qr_code_scanner,
                  maxLength: 6,
                  numbers: true,
                  isLastFiled: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16, bottom: 8.0, top: 8.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_verifyKey.currentState?.validate() ?? false) {
                          screen.verifyCode(
                            VerifyResetPassCodeRequest(
                              code: codeController.text,
                            ),
                          );
                        }
                      },
                      child: Center(
                        child: screen.loadingSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                S.of(context).confirm,
                                style: const TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: retryEnabled
                      ? () {
                          retryEnabled = false;
                          Future.delayed(const Duration(seconds: 60), () {
                            retryEnabled = true;
                            screen.refresh();
                          });
                          screen.refresh();
                          //                  screen.resendCode(VerifyCodeRequest(userID: screen.userID));
                        }
                      : null,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, left: 32, right: 32, top: 8),
                      child: Text(
                        S.of(context).resendCode,
                        style: retryEnabled
                            ? TextStyle(
                                color: Theme.of(context).colorScheme.secondary)
                            : TextStyle(
                                color: Theme.of(context).disabledColor,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
