import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/model/store_need_support.dart';
import 'package:c4d/module_stores/ui/screen/stores_needs_support_screen.dart';
import 'package:c4d/module_stores/ui/widget/store_card.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/costom_search.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
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
        child: Visibility(
      visible: model != null,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 16),
            child: CustomDeliverySearch(
              hintText: S.current.searchForStore,
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
          Flexible(
            child: ListView.builder(
              itemCount: model?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var element = model![index];
                if (element.storeName
                        .toLowerCase()
                        .contains(search?.toLowerCase() ?? '') ==
                    false) {
                  return SizedBox();
                }
                return StoreCard(
                  Id: element.id,
                  name: element.storeName,
                  image: element.image,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ThemePreferencesHelper().getChatRoute(),
                      arguments: ChatArgument(
                        roomID: element.roomID,
                        userType: 'store',
                        userID: int.parse(element.userId),
                        name: element.storeName,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
