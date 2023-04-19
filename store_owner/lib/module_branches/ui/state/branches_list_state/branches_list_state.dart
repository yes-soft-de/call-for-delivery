import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/branches_routes.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/ui/screens/branches_list_screen/branches_list_screen.dart';
import 'package:c4d/module_branches/ui/widget/branch_card.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
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
    return CustomListView.custom(children: getBranches(context));
  }

  List<Widget> getBranches(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in branches) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: BranchCardList(
            branchId: element.id.toString(),
            phone: element.branchPhone,
            onDelete: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                      onPressed: () {
                        Navigator.of(context).pop();
                        screenState.deleteBranch(element.id);
                      },
                      content: S.current.confirmDeletionBranch,
                    );
                  });
            },
            onEdit: () {
              Navigator.pushNamed(context, BranchesRoutes.UPDATE_BRANCH_SCREEN,
                  arguments: element);
            },
            branchName: element.branchName),
      ));
    }
    return widgets;
  }
}
