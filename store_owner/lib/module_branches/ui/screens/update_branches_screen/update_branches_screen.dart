import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_branches/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart';
import 'package:c4d/module_branches/ui/state/update_branches_state/update_branches_state.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    currentState = UpdateBranchStateLoaded(this);
    super.initState();
  }

  void updateBranch(UpdateBranchesRequest request) {
    widget._manager.updateBranch(this, request);
  }

  void createBranch(CreateBrancheRequest request) {
    widget._manager.createBranch(this, request);
  }

  void moveNext(bool success) {
    if (success) {
      // must update the screen before using global state manager
      Navigator.of(context).pop();
      Flushbar(
        title: S.of(context).updateBranch,
        message: S.of(context).updateBranchSuccess,
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      )..show(context);
    } else {
      Navigator.of(context).pop();
      Flushbar(
        title: S.of(context).updateBranch,
        message: S.of(context).updateBranchFailure,
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  void moveNextAfterCreate(bool success) {
    if (success) {
      Navigator.of(context).pop();
      // must update the screen before using global state manager
      Flushbar(
        title: S.of(context).addBranch,
        message: S.of(context).addBranchSuccess,
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      )..show(context);
    } else {
      Navigator.of(context).pop();
      Flushbar(
        title: S.of(context).addBranch,
        message: S.of(context).addBranchFailure,
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    BranchesModel? branchesModel = args is BranchesModel ? args : null;

    return Scaffold(
      appBar: CustomMandoobAppBar.appBar(context,
          title: branchesModel != null
              ? S.of(context).updateBranch
              : S.of(context).addBranch,
          canGoBack: Navigator.canPop(context)),
      body: currentState?.getUI(context),
    );
  }
}
