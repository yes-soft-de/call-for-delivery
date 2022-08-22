import 'dart:async';
import 'package:c4d/module_auth/state_manager/reset_state_manager/reset_password_state_manager.dart';
import 'package:c4d/module_auth/ui/states/reset_password_state/reset_password.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/request/forget_password_request/update_password_request.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class ResetPasswordScreen extends StatefulWidget {
  final ResetPasswordStateManager _stateManager;

  ResetPasswordScreen(this._stateManager);

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
        OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
    CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.passwordUpdatedSuccess)
        .show(context);
  }

  void updatePassword(UpdatePassRequest request) {
    widget._stateManager.updatePassword(request, this);
  }
}
