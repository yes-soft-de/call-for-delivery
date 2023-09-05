import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/ui/widget/store_card.dart';
import 'package:c4d/module_supplier/model/supplier_need_support.dart';
import 'package:c4d/module_supplier/ui/screen/supplier_needs_support_screen.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';

class SupplierNeedSupportLoadedState extends States {
  final SupplierNeedsSupportScreenState screenState;
  final String? error;
  final bool empty;
  final List<SupplierNeedSupportModel>? model;

  SupplierNeedSupportLoadedState(this.screenState, this.model,
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
          screenState.getSupplierSupport();
        },
        error: error,
      );
    } else if (empty && search == null) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getSupplierSupport();
          });
    }
    return FixedContainer(
        child: ListView.builder(
      itemCount: model?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (model == null) return SizedBox();
        var element = model![index];
        return StoreCard(
          Id: element.id,
          name: element.captainName,
          image: element.image,
          onTap: () {
            Navigator.of(context).pushNamed(
              ChatRoutes.chatRoute,
              arguments: ChatArgument(
                roomID: element.roomID,
                userType: 'supplier',
                userID: int.parse(element.userId),
                name: element.captainName,
              ),
            );
          },
        );
      },
    ));
  }
}
