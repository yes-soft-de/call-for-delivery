import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/request/forget_password_request/reset_password_request.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/module_auth/ui/widget/custom_auth_filed.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/auth_buttons.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

class LoginStateInit extends LoginState {
  LoginStateInit(LoginScreenState screen, {String? error}) : super(screen) {
    screen.countryController.text = '966';
    if (error != null) {
      CustomFlushBarHelper.createError(
              title: S.current.warnning, message: error)
          .show(screen.context);
    }
  }
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _loginKey,
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: Text(
                      S.current.login,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Color(0xff03816A),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                // phone number
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 6,
                      child: CustomAuthFiled(
                        title: S.current.phoneNumber,
                        controller: screen.usernameController,
                        hintText: '55xxxxxxx',
                        isPhone: true,
                        maxLength: 9,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CustomAuthFiled(
                        controller: screen.countryController,
                        hintText: '966',
                        maxLength: 3,
                        icon: Icons.phone,
                      ),
                    ),
                  ],
                ),
                // password
                Password(
                  screen: screen,
                  isLastFiled: true,
                ),

                CheckboxListTile(
                    title: Text(S.current.rememberMe),
                    value: screen.rememberMe,
                    onChanged: (check) {
                      screen.rememberMe = check ?? false;
                      screen.refresh();
                    }),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 75,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (screen.usernameController.text.isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return CustomAlertDialog(
                                      content: S.of(context).informSendCode,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        screen.restPass(ResetPassRequest(
                                            userID:
                                                screen.countryController.text +
                                                    screen.usernameController
                                                        .text));
                                      });
                                });
                          } else {
                            CustomFlushBarHelper.createError(
                              title: S.current.warnning,
                              message: S.current.pleaseInputPhoneNumber,
                            ).show(context);
                          }
                        },
                        child: Text(
                          S.of(context).forgotPass,
                          style: TextStyle(
                              color: Theme.of(context).disabledColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),

                Visibility(
                  visible: MediaQuery.of(context).viewInsets.bottom == 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AuthButtons(
                        firstButtonTitle: S.of(context).login,
                        secondButtonTitle: S.of(context).register,
                        loading: screen.loadingSnapshot.connectionState ==
                            ConnectionState.waiting,
                        secondButtonTab: () => Navigator.of(context)
                            .pushReplacementNamed(
                                AuthorizationRoutes.REGISTER_SCREEN,
                                arguments: screen.args),
                        firstButtonTab: () {
                          if (_loginKey.currentState!.validate()) {
                            screen.loginClient(
                              screen.countryController.text +
                                  screen.usernameController.text,
                              screen.passwordController.text,
                            );
                          }
                        }),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Password extends StatefulWidget {
  final bool isLastFiled;

  const Password({
    required this.screen,
    this.isLastFiled = false,
  });

  final LoginScreenState screen;

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool hidePassword = false;

  @override
  Widget build(BuildContext context) {
    return CustomAuthFiled(
      title: S.current.password,
      controller: widget.screen.passwordController,
      isPassword: true,
      icon: Icons.lock,
      hintText: S.current.password,
      hidePassword: hidePassword,
      isLastFiled: widget.isLastFiled,
      onHidePassWordChange: (value) {
        setState(() {
          hidePassword = value;
        });
      },
    );
  }
}
