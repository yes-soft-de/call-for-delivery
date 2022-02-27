import 'package:c4d/consts/country_code.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/request/register_request/register_request.dart';
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/utils/components/auth_buttons.dart';
import 'package:c4d/utils/effect/hidder.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';

class RegisterStateInit extends RegisterState {
  RegisterScreenState screenState;
  RegisterStateInit(this.screenState, {String? error, bool registered = false})
      : super(screenState) {
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

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Image.asset(
                        ImageAsset.LOGO,
                        width: 85,
                        height: 85,
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 85, right: 85, top: 24),
                child: Text(
                  S.of(context).name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.person),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    controller: nameController,
                    hintText: S.of(context).nameHint,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 85, right: 85, top: 8),
                child: Text(
                  S.of(context).phoneNumber,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.phone),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    controller: usernameController,
                    hintText: '5xxxxxxxxx',
                    phone: true,
                    contentPadding:
                        const EdgeInsets.only(left: 8, right: 8, top: 16),
                    sufIcon: const Padding(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 16),
                      child: Text(CountryCode.COUNTRY_CODE_KSA),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 85, right: 85, top: 8),
                child: Text(
                  S.of(context).password,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
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
                    contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    hintText: S.of(context).password,
                  ),
                ),
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
                            userID: usernameController.text,
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
