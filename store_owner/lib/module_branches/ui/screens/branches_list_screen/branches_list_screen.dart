import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/branches_routes.dart';
import 'package:c4d/module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart';
import 'package:c4d/module_branches/ui/state/branches_list_state/branches_list_state.dart';
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

  @override
  void initState() {
    widget._manager.getBranchesList(this);
    widget._manager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    getIt<GlobalStateManager>().stateStream.listen((event) {
      print('===============================================');
      widget._manager.getBranchesList(this);
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
    widget._manager.deleteBranch(this, id);
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    var changed = args is bool ? args : false;

    return WillPopScope(
      onWillPop: () async {
        if (changed) {
          // await Navigator.of(context).pushNamedAndRemoveUntil(
          //     OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
        }
        return await !changed;
      },
      child: Scaffold(
        appBar: CustomMandoobAppBar.appBar(
          context,
          title: S.current.branchManagement,
          actions: [
            CustomMandoobAppBar.actionIcon(context, onTap: () {
              Navigator.of(context)
                  .pushNamed(BranchesRoutes.UPDATE_BRANCH_SCREEN);
            }, icon: Icons.add_rounded)
          ],
        ),
        body: currentState?.getUI(context),
      ),
    );
  }
}
