import 'package:store_web/module_auth/ui/screen/reset_password_screen/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:store_web/abstracts/states/state.dart';
import 'package:store_web/di/di_config.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:store_web/module_auth/request/forget_password_request/update_password_request.dart';
import 'package:store_web/module_auth/service/auth_service/auth_service.dart';
import 'package:store_web/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:store_web/utils/helpers/custom_flushbar.dart';
import 'package:store_web/utils/images/images.dart';

class ResetPasswordLoadedState extends States {
  ResetPasswordScreenState screenState;
  ResetPasswordLoadedState(this.screenState) : super(screenState);

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _verifyKey = GlobalKey<FormState>();
  TextStyle tileStyle = const TextStyle(fontWeight: FontWeight.w600);

  @override
  Widget getUI(BuildContext context) {
    return Form(
      key: _verifyKey,
      child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          Container(
            height: 50,
          ),
          MediaQuery.of(context).viewInsets.bottom == 0
              ? Image.asset(
                  ImageAsset.LOGO,
                  height: 250,
                  width: 150,
                )
              : Container(),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 8.0, left: 32, right: 32, top: 8),
            child: Text(
              S.of(context).newPassword,
              style: tileStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomLoginFormField(
              preIcon: Icon(
                Icons.lock,
                color: Theme.of(context).disabledColor,
              ),
              confirmationPassword: confirmPasswordController.text,
              controller: passwordController,
              password: true,
              hintText: S.of(context).newPassword,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 8.0, left: 32, right: 32, top: 8),
            child: Text(
              S.of(context).confirmNewPass,
              style: tileStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomLoginFormField(
              preIcon: Icon(
                Icons.lock,
                color: Theme.of(context).disabledColor,
              ),
              last: true,
              controller: confirmPasswordController,
              confirmationPassword: passwordController.text,
              password: true,
              hintText: S.of(context).confirmNewPass,
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
                    if (_verifyKey.currentState!.validate() &&
                        passwordController.text ==
                            confirmPasswordController.text) {
                      screenState.updatePassword(UpdatePassRequest(
                          userID: getIt<AuthService>().username,
                          newPassword: passwordController.text));
                    } else if (passwordController.text !=
                        confirmPasswordController.text) {
                      CustomFlushBarHelper.createError(
                              title: S.current.warnning,
                              message: S.current.passwordNotMatch)
                          .show(context);
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
                    child: Text(
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
    );
  }
}
