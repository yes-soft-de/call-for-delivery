import 'package:c4d/consts/country_code.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/request/register_request/register_request.dart';
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/auth_buttons.dart';
import 'package:c4d/utils/effect/hidder.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/images/images.dart';

class RegisterStateInit extends RegisterState {
  RegisterScreenState screenState;
  RegisterStateInit(this.screenState, {String? error, bool registered = false})
      : super(screenState) {
    if (error != null) {
      countryController.text = '966';
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

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController countryController = TextEditingController();
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  bool agreed = false;
  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _registerKey,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    ImageAsset.LOGO,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              // name
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: Text(
                  S.of(context).name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 0.0, right: 16.0, left: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomLoginFormField(
                      controller: nameController,
                      hintText: S.of(context).nameHint,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
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
                        bottom: 26.0, right: 16.0, left: 16.0),
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
                      hintText: '5xxxxxxxxx',
                      phone: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: SizedBox(
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomLoginFormField(
                          contentPadding:
                              EdgeInsets.only(left: 8.0, right: 8.0),
                          controller: countryController,
                          phone: true,
                          phoneHint: false,
                          hintText: S.current.countryCode,
                          sufIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Container(
                              width: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: Theme.of(context).textTheme.button,
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
                      controller: passwordController,
                      confirmationPassword: password2Controller.text,
                      password: true,
                      onChanged: (s) {
                        screenState.refresh();
                      },
                      hintText: S.of(context).password,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  )
                ],
              ),
              // confirmation password
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80, top: 8),
                child: Text(
                  S.of(context).confirmPasswordAgain,
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
                      controller: password2Controller,
                      confirmationPassword: passwordController.text,
                      password: true,
                      onChanged: (s) {
                        screenState.refresh();
                      },
                      hintText: S.of(context).writePasswordAgain,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CheckboxListTile(
                    value: agreed,
                    title: Text(
                        S.of(context).iAgreeToTheTermsOfServicePrivacyPolicy),
                    onChanged: (v) {
                      agreed = v ?? false;
                      screen.refresh();
                    }),
              ),
              Container(
                height: 175,
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
              secondButtonTab: () => Navigator.of(context).pushReplacementNamed(
                  AuthorizationRoutes.LOGIN_SCREEN,
                  arguments: screen.args),
              firstButtonTab: agreed
                  ? () {
                      if (_registerKey.currentState!.validate()) {
                        screen.registerClient(RegisterRequest(
                            userID: usernameController.text.trim() +
                                countryController.text.trim(),
                            password: passwordController.text,
                            userName: nameController.text));
                      }
                    }
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
