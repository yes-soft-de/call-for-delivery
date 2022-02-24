import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/painting.dart';
import 'package:lottie/lottie.dart';
import '../../widget/login_widgets/custem_button.dart';

class LoginStateInit extends LoginState {
  LoginStateInit(LoginScreenState screen, {String? error}) : super(screen) {
    if (error != null) {
      CustomFlushBarHelper.createError(
              title: S.current.warnning, message: error)
          .show(screen.context);
    }
  }
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _loginKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Lottie.asset(LottieAsset.LOGIN_IMAGE,fit: BoxFit.fill),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                    child: ListView(
                      children: <Widget>[
                        Text(
                          'Welcome to System control',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          'Sign in to continue',
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          S.of(context).username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).backgroundColor,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.supervised_user_circle),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomLoginFormField(
                              controller: usernameController,
                              hintText: '5xxxxxxxxx',
                              phone: false,
                            ),
                          ),
                        ),
                        Text(
                          S.of(context).password,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).backgroundColor,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.lock),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomLoginFormField(
                              last: true,
                              controller: passwordController,
                              password: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              hintText: S.of(context).password,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          buttonTab: () {
                            if (_loginKey.currentState!.validate()) {
                              screen.loginClient(usernameController.text,
                                  passwordController.text);
                            }
                          },
                          loading: screen.loadingSnapshot.connectionState ==
                              ConnectionState.waiting,
                          text: S.of(context).login,
                          bgColor: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
