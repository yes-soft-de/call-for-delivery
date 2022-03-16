import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/request/forget_password_request/reset_password_request.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/utils/components/auth_buttons.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/images/images.dart';

class LoginStateInit extends LoginState {
  LoginStateInit(LoginScreenState screen, {String? error}) : super(screen) {
    countryController.text = '966';
    if (error != null) {
      CustomFlushBarHelper.createError(
              title: S.current.warnning, message: error)
          .show(screen.context);
    }
  }
  TextEditingController usernameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  @override
  Widget getUI(BuildContext context) {
    return Form(
      key: _loginKey,
      child: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Visibility(
                  visible: MediaQuery.of(context).viewInsets.bottom == 0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32.0, top: 16),
                    child: Image.asset(
                      ImageAsset.LOGO,
                      width: 150,
                      height: 150,
                    ),
                  )),
              // phone number
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80, top: 8),
                child: Text(
                  S.of(context).phoneNumber,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16, bottom: 26.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.phone,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomLoginFormField(
                        controller: usernameController,
                        phone: true,
                        hintText: '5xxxxxxxx'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: SizedBox(
                      width: 125,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomLoginFormField(
                          halfField: true,
                          contentPadding:
                              EdgeInsets.only(left: 8.0, right: 8.0),
                          controller: countryController,
                          numbers: true,
                          phoneHint: false,
                          maxLength: 3,
                          hintText: S.current.countryCode,
                          sufIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 4.0, left: 4.0),
                            child: Container(
                              width: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // password
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: Text(
                  S.of(context).password,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.lock,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomLoginFormField(
                      last: true,
                      controller: passwordController,
                      password: true,
                      hintText: S.of(context).password,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  )
                ],
              ),
              Container(
                height: 16,
              ),
              InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (usernameController.text.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return CustomAlertDialog(
                                content: S.of(context).informSendCode,
                                onPressed: () {
                                  Navigator.pop(context);
                                  screen.restPass(ResetPassRequest(
                                      userID: countryController.text +
                                          usernameController.text));
                                });
                          });
                    } else {
                      CustomFlushBarHelper.createError(
                              title: S.current.warnning,
                              message: S.current.pleaseInputPhoneNumber)
                          .show(context);
                    }
                  },
                  child: Center(
                      child: Text(
                    S.of(context).forgotPass,
                    style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.bold),
                  ))),
              Container(
                height: 150,
              ),
            ],
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
                      .pushReplacementNamed(AuthorizationRoutes.REGISTER_SCREEN,
                          arguments: screen.args),
                  firstButtonTab: () {
                    if (_loginKey.currentState!.validate()) {
                      screen.loginClient(
                          countryController.text + usernameController.text,
                          passwordController.text);
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
