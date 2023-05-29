import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart';
import 'package:c4d/module_auth/request/register_request/verfy_code_request.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:flutter/material.dart';

class LoginStateCodeSent extends LoginState {
  final _confirmationController = TextEditingController();
  bool retryEnabled = false;
  bool loading = false;

  LoginStateCodeSent(LoginScreenState screen) : super(screen) {
    Future.delayed(const Duration(seconds: 30), () {
      retryEnabled = true;
      screen.refresh();
    });
  }

  @override
  Widget getUI(BuildContext context) {
    return Form(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MediaQuery.of(context).viewInsets.bottom == 0
              ? Image.asset('assets/images/logo.jpg')
              : Container(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
                controller: _confirmationController,
                decoration: InputDecoration(
                  labelText: S.of(context).confirmCode,
                  hintText: '12345',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null) {
                    return S.of(context).pleaseInputPhoneNumber;
                  }
                  return null;
                }),
          ),
          OutlinedButton(
            onPressed: retryEnabled
                ? () {
                    screen.resendCode(VerifyCodeRequest(
                        userID: getIt<AuthService>().username,
                        password: getIt<AuthPrefsHelper>().getPassword()));
                  }
                : null,
            child: Text(
              S.of(context).resendCode,
              style: TextStyle(
                color:
                    retryEnabled ? Theme.of(context).colorScheme.primary : null,
              ),
            ),
          ),
          loading
              ? Text(S.of(context).loading)
              : Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).colorScheme.secondary),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      loading = true;
                      Future.delayed(const Duration(seconds: 10), () {
                        loading = false;
                      });
                      screen.refresh();
                      screen.verifyClient(VerifyCodeRequest(
                          userID: getIt<AuthService>().username,
                          code: _confirmationController.text));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            S.of(context).confirm,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
