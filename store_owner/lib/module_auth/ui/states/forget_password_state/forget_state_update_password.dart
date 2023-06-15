import 'package:c4d/module_auth/ui/widget/custom_auth_filed.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/request/forget_password_request/update_password_request.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/screen/forget_password_screen/forget_password_screen.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

class ForgotStateUpdatePassword extends States {
  ForgotPassScreenState screenState;
  ForgotStateUpdatePassword(this.screenState) : super(screenState);

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _verifyKey = GlobalKey<FormState>();
  TextStyle tileStyle = const TextStyle(fontWeight: FontWeight.w600);

  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Form(
        key: _verifyKey,
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            const SizedBox(height: 150),
            _PassWordFields(
              passwordController: passwordController,
              password2Controller: confirmPasswordController,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0, left: 16, bottom: 8.0, top: 8.0),
              child: SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      if (_verifyKey.currentState!.validate()) {
                        screenState.updatePassword(UpdatePassRequest(
                            userID: getIt<AuthService>().username,
                            newPassword: passwordController.text));
                      } else {
                        CustomFlushBarHelper.createError(
                                title: S.current.warnning,
                                message: S.current.passwordNotMatch)
                            .show(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      textStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: screenState.loadingSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              S.of(context).update,
                              style: const TextStyle(color: Colors.white),
                            ),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _PassWordFields extends StatefulWidget {
  const _PassWordFields({
    required this.passwordController,
    required this.password2Controller,
  });

  final TextEditingController passwordController;
  final TextEditingController password2Controller;

  @override
  State<_PassWordFields> createState() => _PassWordFieldsState();
}

class _PassWordFieldsState extends State<_PassWordFields> {
  bool hidePassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAuthFiled(
          title: S.current.newPassword,
          controller: widget.passwordController,
          confirmPassword: widget.password2Controller.text,
          isPassword: true,
          icon: Icons.lock,
          hintText: S.current.password,
          hidePassword: hidePassword,
          onChanged: (value) {
            setState(() {});
          },
          onHidePassWordChange: (value) {
            setState(() {
              hidePassword = value;
            });
          },
        ),
        // confirm password
        CustomAuthFiled(
          title: S.current.confirmPasswordAgain,
          controller: widget.password2Controller,
          confirmPassword: widget.passwordController.text,
          isPassword: true,
          icon: Icons.lock,
          isLastFiled: true,
          hintText: S.current.confirmPasswordAgain,
          hidePassword: hidePassword,
          onChanged: (value) {
            setState(() {});
          },
          onHidePassWordChange: (value) {
            setState(() {
              hidePassword = value;
            });
          },
        ),
      ],
    );
  }
}
