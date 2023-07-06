import 'package:store_web/generated/l10n.dart';
import 'package:store_web/module_auth/authorization_routes.dart';
import 'package:store_web/module_auth/request/register_request/register_request.dart';
import 'package:store_web/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:store_web/module_auth/ui/states/register_states/register_state.dart';
import 'package:store_web/module_auth/ui/widget/custom_auth_filed.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:store_web/utils/components/auth_buttons.dart';
import 'package:store_web/utils/effect/hidder.dart';
import 'package:store_web/utils/helpers/custom_flushbar.dart';

class RegisterStateInit extends RegisterState {
  RegisterScreenState screenState;
  RegisterStateInit(this.screenState, {String? error, bool registered = false})
      : super(screenState) {
    countryController.text = '966';
    if (error != null) {
      if (registered) {
        screenState.userRegistered().whenComplete(() {
          CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: error)
              .show(screenState.context);
        });
      } else {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: error)
            .show(screenState.context);
      }
    }
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController countryController = TextEditingController();
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  bool agreed = false;
  @override
  Widget getUI(BuildContext context) {
    return Form(
      key: _registerKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          physics: const BouncingScrollPhysics(),
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
            const SizedBox(height: 30),
            // phone number
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 6,
                  child: CustomAuthFiled(
                    title: S.current.phoneNumber,
                    controller: usernameController,
                    hintText: '55xxxxxxx',
                    isPhone: true,
                    maxLength: 9,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CustomAuthFiled(
                    controller: countryController,
                    hintText: '966',
                    maxLength: 3,
                    icon: Icons.phone,
                  ),
                ),
              ],
            ),
            // password
            _PassWordFields(
              passwordController: passwordController,
              password2Controller: password2Controller,
            ),
            // policy agreement
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text.rich(
                        style: Theme.of(context).textTheme.bodyMedium,
                        TextSpan(
                          children: [
                            TextSpan(text: S.current.iAgreeOn + ' '),
                            TextSpan(
                              text: S.current.terms,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  
                                },
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff03816A),
                              ),
                            ),
                            TextSpan(text: S.current.and),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  
                                },
                              text: S.current.privacy,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff03816A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Checkbox(
                    value: agreed,
                    onChanged: (v) {
                      agreed = v ?? false;
                      screen.refresh();
                    },
                  ),
                ],
              ),
            ),
            Hider(
              active: MediaQuery.of(context).viewInsets.bottom == 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AuthButtons(
                  firstButtonTitle: S.of(context).register,
                  secondButtonTitle: S.of(context).iHaveAnAccount,
                  loading: screen.loadingSnapshot.connectionState ==
                      ConnectionState.waiting,
                  secondButtonTab: () => Navigator.of(context)
                      .pushReplacementNamed(AuthorizationRoutes.LOGIN_SCREEN,
                          arguments: screen.args),
                  firstButtonTab: agreed
                      ? () {
                          if (_registerKey.currentState!.validate()) {
                            if (usernameController.text
                                .trim()
                                .startsWith('0')) {
                              CustomFlushBarHelper.createError(
                                      title: S.current.warnning,
                                      message:
                                          S.current.yourNumberStartWithZero)
                                  .show(context);
                            } else {
                              screen.registerClient(RegisterRequest(
                                userID: countryController.text.trim() +
                                    usernameController.text.trim(),
                                password: passwordController.text,
                              ));
                            }
                          }
                        }
                      : null,
                ),
              ),
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
          title: S.current.password,
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
