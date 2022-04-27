import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/store_profile_model.dart';
import 'package:c4d/module_stores/request/active_store_request.dart';
import 'package:c4d/module_stores/ui/screen/store_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class StoreProfileLoadedState extends States {
  final StoreInfoScreenState screenState;
  final StoreProfileModel? profile;
  final String? error;
  final bool empty;

  StoreProfileLoadedState(this.screenState, this.profile,
      {this.error, this.empty = false})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStore(screenState.model?.id ?? -1);
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getStore(screenState.model?.id ?? -1);
          });
    }
    return FixedContainer(
        child: CustomListView.custom(children: [
      Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.30,
        child: CustomNetworkImage(
          imageSource: profile?.image ?? '',
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.30,
        ),
      ),
      Container(
        color: profile?.status == 'active' ? Colors.green : Colors.red.shade900,
        child: ListTileSwitch(
            switchActiveColor: Colors.green.shade200,
            switchInactiveColor: Colors.red.shade200,
            title: Text(
              profile?.status == 'active'
                  ? S.current.active
                  : S.current.inactive,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            value: profile?.status == 'active',
            onChanged: (v) {
              if (v) {
                profile?.status = 'active';
                screenState.enableStore(
                    ActiveStoreRequest(
                      id: profile!.id,
                      status: 'active',
                    ),
                    false);
              } else {
                profile?.status = 'inactive';
                screenState.enableStore(
                    ActiveStoreRequest(id: profile!.id, status: 'inactive'),
                    false);
              }
              screenState.refresh();
            }),
      ),
      CustomListTile(
        title: S.current.storeName,
        subTitle: profile?.storeOwnerName,
      ),
      CustomListTile(
        title: S.current.storePhone,
        subTitle: profile?.phone,
      ),
      CustomListTile(
        title: S.current.bankName,
        subTitle: profile?.bankName,
      ),
      CustomListTile(
        title: S.current.bankAccountNumber,
        subTitle: profile?.bankNumber,
      ),
      CustomListTile(
        title: S.current.city,
        subTitle: profile?.city,
      ),
      CustomListTile(
        title: S.current.openingTime,
        subTitle: profile?.openingTime,
      ),
      CustomListTile(
        title: S.current.closingTime,
        subTitle: profile?.closingTime,
      ),
      Container(
        width: double.maxFinite,
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16.0, bottom: 16, left: 8, right: 8),
          child: Text(''),
        ),
      ),
    ]));
  }

  Widget CustomListTile(
      {required String title, String? subTitle, bool? serve}) {
    var context = screenState.context;
    if (serve != null) {
      return Flex(
        direction: Axis.horizontal,
        children: [
          Container(
            width: 130,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.symmetric(
                  horizontal: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 1),
                )),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 16, left: 8, right: 8),
              child: Text(title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Container(
            width: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ],
      );
    }
    return Flex(
      direction: Axis.horizontal,
      children: [
        Container(
          width: 130,
          height: 60,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.symmetric(
                horizontal: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor, width: 1),
              )),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ),
        Container(
          width: 4,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        Expanded(
            child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              border: Border.symmetric(
                horizontal: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor, width: 1),
              )),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                subTitle ?? '',
                style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ))
      ],
    );
  }
}
