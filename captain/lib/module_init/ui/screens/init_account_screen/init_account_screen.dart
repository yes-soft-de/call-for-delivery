import 'dart:async';
import 'package:c4d/abstracts/states/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:c4d/module_init/state_manager/init_account/init_account.state_manager.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class InitAccountScreen extends StatefulWidget {
  final InitAccountStateManager _stateManager;
  InitAccountScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => InitAccountScreenState();
}

class InitAccountScreenState extends State<InitAccountScreen> {
  StreamSubscription? _streamSubscription;
  States? currentState;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final carController = TextEditingController();
  final phoneController = TextEditingController();
  final bankNameController = TextEditingController();
  final bankAccountNumberController = TextEditingController();
  final stcPayController = TextEditingController();
  final countryCodeController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void showMessage(String msg, bool success) {
    if (success) {
      CustomFlushBarHelper.createSuccess(
              title: S.current.warnning, message: msg)
          .show(context);
    } else {
      CustomFlushBarHelper.createError(title: S.current.warnning, message: msg)
          .show(context);
    }
  }

  void submitProfile(CreateCaptainProfileRequest request) {
    widget._stateManager.submitProfile(request, this);
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) async {
      await Future.delayed(Duration(seconds: 5)).whenComplete(() {
        FeatureDiscovery.discoverFeatures(
          context,
          const <String>{
            'myLocation',
            'selectedMenu',
          },
        );
      });
    });
    _streamSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    getRoleInitState();
    super.initState();
  }

  void getRoleInitState() {
    widget._stateManager.getRoleInit(this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final node = FocusScope.of(context);
        if (node.canRequestFocus) {
          node.unfocus();
        }
      },
      child: Scaffold(
        body: currentState?.getUI(context),
      ),
    );
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
