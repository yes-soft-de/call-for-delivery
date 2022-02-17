import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/ui/screens/branches_list_screen/branches_list_screen.dart';
import 'package:flutter/material.dart';


class BranchListStateLoading extends States {
  BranchListStateLoading(BranchesListScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class BranchListStateError extends States {
  String errorMsg;

  BranchListStateError(
    this.errorMsg,
    BranchesListScreenState screenState,
  ) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('${errorMsg}'),
    );
  }
}

class BranchListStateLoaded extends States {
  List<BranchesModel> branches;
  BranchListStateLoaded(
    this.branches,
    BranchesListScreenState screenState,
  ) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return branches.isNotEmpty
        ? ListView.builder(
            itemCount: branches.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ListTile(
                    onTap: () {
                      // Navigator.pushNamed(
                      //     context, InitAccountRoutes.UPDATE_BRANCH_SCREEN,
                      //     arguments: branches[index]);
                    },
                    tileColor: Theme.of(context).primaryColor,
                    leading: Icon(
                      Icons.store,
                      color: Colors.white,
                    ),
                    title: Text(
                      branches[index].branchName,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            })
        : Center(
            child: Text('Empty List'),
          );
  }
}
