import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/state_manager/edit_delivery_company_setting_state_manager.dart';
import 'package:c4d/module_external_delivery_companies/ui/state/edit_delivery_company_setting_state_loaded.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditDeliveryCompanySettingScreen extends StatefulWidget {
  final EditDeliveryCompanySettingScreenStateManager _stateManager;
  const EditDeliveryCompanySettingScreen(this._stateManager);

  @override
  State<EditDeliveryCompanySettingScreen> createState() =>
      EditDeliveryCompanySettingScreenState();
}

class EditDeliveryCompanySettingScreenState
    extends State<EditDeliveryCompanySettingScreen> {
  late States currentState;
  late CompanySetting companySetting;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription? _stateSubscription;

  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this);

    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;

      if (mounted) {
        setState(() {});
      }
    });
  }

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      var arg = ModalRoute.of(context)?.settings.arguments as List;
      companySetting = arg[0] as CompanySetting;

      bool isNewSetting = false;
      if (arg.length > 1) isNewSetting = arg[1] as bool;

      currentState = EditDeliveryCompanySettingScreenStateLoaded(
          this, companySetting, isNewSetting);
    }

    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(
          context,
          title: companySetting.companyName,
        ),
        key: _scaffoldKey,
        body: SafeArea(
          child: currentState.getUI(context),
        ),
      ),
    );
  }
}
