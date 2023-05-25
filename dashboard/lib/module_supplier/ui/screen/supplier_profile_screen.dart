import 'package:c4d/module_captain/request/update_captain_request.dart';
import 'package:c4d/module_supplier/request/enable_supplier.dart';
import 'package:c4d/module_supplier/state_manager/supplier_profile_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';

@injectable
class SupplierProfileScreen extends StatefulWidget {
  final SupplierProfileStateManager _stateManager;

  SupplierProfileScreen(this._stateManager);

  @override
  SupplierProfileScreenState createState() => SupplierProfileScreenState();
}

class SupplierProfileScreenState extends State<SupplierProfileScreen> {
  late States currentState;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    super.initState();
  }

  void getSupplier() {
    widget._stateManager.getSupplierProfile(this, captainId);
  }

  void enableCaptain(bool status) {
    widget._stateManager.enableSupplier(
        this, captainId, EnableSupplierRequest(id: captainId, status: status));
  }

  void updateCaptainProfile(UpdateCaptainRequest request) {
//    widget._stateManager.updateCaptainProfile(this, request);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  int captainId = -1;

  @override
  Widget build(BuildContext context) {
    if (captainId == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        captainId = arg;
        widget._stateManager.getSupplierProfile(this, captainId);
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context, title: S.current.profile),
      body: currentState.getUI(context),
    );
  }
}
