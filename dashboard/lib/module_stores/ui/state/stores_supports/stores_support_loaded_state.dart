import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/model/store_need_support.dart';
import 'package:c4d/module_stores/ui/screen/stores_needs_support_screen.dart';
import 'package:c4d/module_stores/ui/widget/store_card.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';

class StoresNeedSupportLoadedState extends States {
  final StoreNeedsSupportScreenState screenState;
  final String? error;
  final bool empty;
  final List<StoresNeedSupportModel>? model;

  StoresNeedSupportLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }

  String? id;
  String? search;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getClients();
        },
        error: error,
      );
    } else if (empty && search == null) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getClients();
          });
    }
    return FixedContainer(
        child: CustomListView.custom(children: getClients(context)));
  }

  List<Widget> getClients(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in model ?? <StoresNeedSupportModel>[]) {
      widgets.add(StoreCard(
        Id: element.id,
        name: element.storeName,
        image: element.image,
        onTap: () {
          Navigator.of(context).pushNamed(
            ChatRoutes.chatRoute,
            arguments: ChatArgument(
                roomID: element.roomID,
                userType: 'store',
                userID: int.parse(element.id)),
          );
        },
      ));
    }
    return widgets;
  }
}
