import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/branches_routes.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/ui/screens/branches_list_screen/branches_list_screen.dart';
import 'package:c4d/module_branches/ui/widget/branch_card.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class BranchListStateLoaded extends States {
  List<BranchesModel> branches;
  final BranchesListScreenState screenState;
  BranchListStateLoaded(
    this.branches,
    this.screenState,
  ) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return ListView.builder(
      itemCount: branches.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: BranchCardList(
              phone: branches[index].branchPhone,
              onDelete: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CustomAlertDialog(
                        onPressed: () {
                          Navigator.of(context).pop();
                          screenState.deleteBranch(branches[index].id);
                        },
                        content: S.current.confirmDeletionBranch,
                        oneAction: false,
                      );
                    });
              },
              onEdit: () {
                Navigator.pushNamed(
                    context, BranchesRoutes.UPDATE_BRANCH_SCREEN,
                    arguments: branches[index]);
              },
              branchName: branches[index].branchName),
        );
      },
    );
  }
}
