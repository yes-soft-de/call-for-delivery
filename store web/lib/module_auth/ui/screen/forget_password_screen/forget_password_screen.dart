
import 'dart:async';
import 'package:store_web/module_main/main_routes.dart';
import 'package:store_web/utils/components/custom_app_bar.dart';
import 'package:store_web/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/abstracts/states/state.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:store_web/module_auth/request/forget_password_request/update_password_request.dart';
import 'package:store_web/module_auth/request/forget_password_request/verify_new_password_request.dart';
import 'package:store_web/module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart';
import 'package:store_web/module_auth/ui/states/forget_password_state/forget_password_code_sent.dart';
import 'package:store_web/utils/components/fixed_container.dart';
import 'package:store_web/utils/helpers/custom_flushbar.dart';

@injectable
class ForgotPassScreen extends StatefulWidget {
  final ForgotPassStateManager _stateManager;

  const ForgotPassScreen(this._stateManager);

  @override
  ForgotPassScreenState createState() => ForgotPassScreenState();
}

class ForgotPassScreenState extends State<ForgotPassScreen> {
  late States _currentStates;
  late AsyncSnapshot loadingSnapshot;
  late StreamSubscription _stateSubscription;
  bool deepLinkChecked = false;

  void refresh() {
    if (mounted) setState(() {});
  }

  late bool canPop;
  @override
  void initState() {
    super.initState();
    canPop = Navigator.of(context).canPop();
    loadingSnapshot = const AsyncSnapshot.nothing();
    _currentStates = ForgotStatePhoneCodeSent(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        _currentStates = event;
        setState(() {});
      }
    });
    widget._stateManager.loadingStream.listen((event) {
      if (mounted) {
        loadingSnapshot = event;
        setState(() {});
      }
    });
  }

  dynamic args;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
        child: Container(
          color: const Color.fromARGB(255, 233, 195, 113),
        ),
      ),
          Image.asset(
            ImageAsset.AUTH_BACKGROUND,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: CustomC4dAppBar.appBar(
              context,
              backgroundColor: Colors.transparent,
              title: S.of(context).forgotPass,
              canGoBack: canPop,
            ),
            body: FixedContainer(
              child: loadingSnapshot.connectionState != ConnectionState.waiting
                  ? _currentStates.getUI(context)
                  : Stack(
                      children: [
                        _currentStates.getUI(context),
                        Container(
                          width: double.maxFinite,
                          color: Colors.transparent.withOpacity(0.0),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }

  void moveToLogin() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        MainRoutes.MAIN_SCREEN, (route) => false);
    CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.passwordUpdatedSuccess)
        .show(context);
  }

  void verifyCode(VerifyResetPassCodeRequest request) {
    widget._stateManager.verifyResetPassCodeRequest(request, this);
  }

  void updatePassword(UpdatePassRequest request) {
    widget._stateManager.updatePassword(request, this);
  }
}
