import 'dart:async';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_branches/request/create_list_branches/create_list_branches.dart';
import 'package:c4d/module_branches/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart';
import 'package:c4d/module_branches/ui/state/update_branches_state/update_branches_state.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateBranchScreen extends StatefulWidget {
  final UpdateBranchStateManager _manager;

  UpdateBranchScreen(this._manager);

  @override
  UpdateBranchScreenState createState() => UpdateBranchScreenState();
}

class UpdateBranchScreenState extends State<UpdateBranchScreen> {
  States? currentState;
  String? storeID = '-1';
  BranchesModel? branchesModel;
  // google map controller
  Completer<GoogleMapController> controller = Completer();
  late CustomInfoWindowController customInfoWindowController;

  @override
  void initState() {
    canPop = Navigator.canPop(context);
    currentState = UpdateBranchStateLoaded(this);
    customInfoWindowController = CustomInfoWindowController();
    widget._manager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void updateBranch(UpdateBranchesRequest request) {
    widget._manager.updateBranch(this, request);
  }

  void createBranch(CreateListBranchesRequest request) {
    widget._manager.createBranch(this, request);
  }

  void moveNext(bool success) {
    if (success) {
      // must update the screen before using global state manager
      getIt<GlobalStateManager>().updateList();
      Navigator.of(context).pop();
      CustomFlushBarHelper.createSuccess(
        title: S.of(context).updateBranch,
        message: S.of(context).updateBranchSuccess,
      );
    } else {
      Navigator.of(context).pop();
      CustomFlushBarHelper.createError(
        title: S.of(context).updateBranch,
        message: S.of(context).updateBranchFailure,
      );
    }
  }

  void moveNextAfterCreate(bool success) {
    if (success) {
      // must update the screen before using global state manager
      getIt<GlobalStateManager>().updateList();
      Navigator.of(context).pop();
      CustomFlushBarHelper.createSuccess(
        title: S.of(context).addBranch,
        message: S.of(context).addBranchSuccess,
      );
    } else {
      Navigator.of(context).pop();
      CustomFlushBarHelper.createError(
        title: S.of(context).addBranch,
        message: S.of(context).addBranchFailure,
      );
    }
  }

  void refresh() {
    setState(() {});
  }

  bool canPop = false;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (storeID == '-1' && args != null) {
      if (args is String) {
        storeID = args;
      } else if (args is BranchesModel) {
        branchesModel = args;
      }
    }

    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: branchesModel != null
              ? S.of(context).updateBranch
              : S.of(context).addBranch,
          canGoBack: canPop),
      body: currentState?.getUI(context),
    );
  }
}
