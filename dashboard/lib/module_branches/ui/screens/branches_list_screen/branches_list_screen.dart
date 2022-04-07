import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/branches_routes.dart';
import 'package:c4d/module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class BranchesListScreen extends StatefulWidget {
  final BranchesListStateManager _manager;

  const BranchesListScreen(this._manager);
  @override
  BranchesListScreenState createState() => BranchesListScreenState();
}

class BranchesListScreenState extends State<BranchesListScreen> {
  States? currentState;
  String? storeID = '-1';

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._manager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    getIt<GlobalStateManager>().stateStream.listen((event) {
      widget._manager.getBranchesList(this, storeID ?? '-1');
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  void deleteBranch(int id) {
    widget._manager.deleteBranch(this, id, storeID ?? '-1');
  }

  @override
  Widget build(BuildContext context) {
    if (storeID == '-1') {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        storeID = arg.toString();
        widget._manager.getBranchesList(this, storeID ?? '-1');
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.branchManagement,
        actions: [
          CustomC4dAppBar.actionIcon(context, onTap: () {
            print("hihiStore" + storeID.toString());
            Navigator.of(context).pushNamed(BranchesRoutes.UPDATE_BRANCH_SCREEN,
                arguments: storeID);
          }, icon: Icons.add_rounded)
        ],
      ),
      body: currentState?.getUI(context),
    );
  }
}
