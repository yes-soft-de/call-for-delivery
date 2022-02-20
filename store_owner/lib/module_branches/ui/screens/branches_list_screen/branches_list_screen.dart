import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart';
import 'package:c4d/module_branches/ui/state/branches_list_state/branches_list_state.dart';
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
    currentState = BranchListStateLoading(this);
    widget._manager.getBranchesList(this);
    widget._manager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void refresh() {
    setState(() {});
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
        appBar: AppBar(
          title: Text(S.of(context).updateBranches),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // Navigator.of(context)
                  //     .pushNamed(InitAccountRoutes.UPDATE_BRANCH_SCREEN);
                })
          ],
        ),
        body: currentState?.getUI(context),
      ),
    );
  }
}
