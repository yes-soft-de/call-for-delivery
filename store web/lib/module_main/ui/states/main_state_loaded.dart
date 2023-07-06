import 'package:store_web/abstracts/states/state.dart';
import 'package:flutter/material.dart';
import 'package:store_web/di/di_config.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:store_web/module_auth/authorization_routes.dart';
import 'package:store_web/module_auth/service/auth_service/auth_service.dart';
import 'package:store_web/module_main/ui/screen/main_screen.dart';

class MainStateLoaded extends States {
  MainScreenState screenState;

  MainStateLoaded(this.screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  screenState.deleteStore();
                },
                child: Text(S.current.deleteAccount),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  getIt<AuthService>().logout().then((value) {
                    Navigator.pushNamedAndRemoveUntil(context,
                        AuthorizationRoutes.LOGIN_SCREEN, (route) => false);
                  });
                },
                child: Text(S.current.signOut),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
