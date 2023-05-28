import 'dart:async';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:c4d/module_auth/request/forget_password_request/verify_new_password_request.dart';
import 'package:c4d/module_auth/ui/screen/forget_password_screen/forget_password_screen.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:c4d/utils/text_style/text_style.dart';

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
        Form(
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
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 32, right: 32, top: 8),
                child: Text(
                  S.of(context).codeNumber,
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
                        hintText: S.of(context).codeNumber,
                        prefixIcon: const Icon(Icons.confirmation_num),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.background,
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
                child: SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        screen.verifyCode(VerifyResetPassCodeRequest(
                          code: codeController.text,
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).colorScheme.secondary,
                        textStyle: const TextStyle(color: Colors.white),
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
                                style: const TextStyle(color: Colors.white),
                              ),
                      )),
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
                          ? TextStyle(color: Theme.of(context).colorScheme.secondary)
                          : TextStyle(color: Theme.of(context).disabledColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
