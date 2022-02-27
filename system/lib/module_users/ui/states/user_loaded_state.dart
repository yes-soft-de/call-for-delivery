import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_users/model/users_model.dart';
import 'package:c4d/module_users/request/filter_user_request.dart';
import 'package:c4d/module_users/request/update_pass_request.dart';
import 'package:c4d/module_users/ui/screen/users_screen.dart';
import 'package:c4d/module_users/ui/widget/chip_choose.dart';
import 'package:c4d/module_users/ui/widget/update_pass_dialog.dart';
import 'package:c4d/module_users/ui/widget/user_card.dart';
import 'package:c4d/utils/components/costom_search.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';

class UsersLoadedState extends States{
  final UsersScreenState screenState;
  final String? error;
  final bool empty;
  final List<UsersModel>? model;


  UsersLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }
  String? search;
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
//          screenState.getUsers();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.noUser,
          onRefresh: () {
//           screenState.getUsers();
          });
    }
    return SingleChildScrollView(
      child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomDeliverySearch(
          hintText: S.current.searchForUser,
          onChanged: (s) {
            if (s == '' || s.isEmpty) {
              search = null;
              screenState.refresh();
            } else {
              search = s;
              screenState.refresh();
            }
          },
        ),
      ),
        Wrap(
          spacing: 6,
          direction: Axis.horizontal,
          children: roleChips(context),
        ),
      Divider(),
      CustomListView.customGrid(children: getUsers(context))
    ]),
    );

  }
  List<Widget> getUsers(BuildContext context) {
    List<Widget> widgets = [];
    for (UsersModel element in model ?? <UsersModel>[]) {
      if (!element.userID.contains(search ?? '') && search != null) {
        continue;
      }
      widgets.add(
          UserCard(usersModel: element,
            updatePassword: (){
              showDialog(
                context: screenState.context,
                builder: (context) {
                  return CustomDialogBox(title:S.of(context).changePassword,
                    updatePass: (newPass){
                    newPass as String;
                    screenState.updatePassword(UpdatePassRequest(element.id, newPass));

                    });
                });

          },));
    }
    return widgets;
  }

  List<Widget> roleChips(BuildContext context) {
    List<Widget> widgets = [];
    for (RoleEnum element in RoleEnum.values) {
      widgets.add(
          ChipChoose(title: StatusHelper.getOrderStatusMessages(element),
            selected:screenState.request.type ==StatusHelper.getEnumStatus(element) ?true: false,
          onTap: (){
           screenState.request = FilterUserRequest(type: StatusHelper.getEnumStatus(element));
            screenState.getUsers( screenState.request);
          },
          ));
    }
    return widgets;
  }
}