import 'dart:async';
import 'package:store_web/module_auth/state_manager/reset_state_manager/reset_password_state_manager.dart';
import 'package:store_web/module_auth/ui/states/reset_password_state/reset_password.dart';
import 'package:store_web/module_main/main_routes.dart';
import 'package:store_web/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/abstracts/states/state.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:store_web/module_auth/request/forget_password_request/update_password_request.dart';
import 'package:store_web/utils/components/fixed_container.dart';
import 'package:store_web/utils/helpers/custom_flushbar.dart';

@injectable
class ResetPasswordScreen extends StatefulWidget {
  final ResetPasswordStateManager _stateManager;

  const ResetPasswordScreen(this._stateManager);

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late States _currentStates;
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
    _currentStates = ResetPasswordLoadedState(this);
    _stateSubscription =
        widget._stateManager.resetPasswordStateStream.listen((event) {
      if (mounted) {
        _currentStates = event;
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomC4dAppBar.appBar(context,
            title: S.of(context).changePassword, canGoBack: canPop),
        body: FixedContainer(
          child: _currentStates.getUI(context),
        ),
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

  void updatePassword(UpdatePassRequest request) {
    widget._stateManager.updatePassword(request, this);
  }
}
