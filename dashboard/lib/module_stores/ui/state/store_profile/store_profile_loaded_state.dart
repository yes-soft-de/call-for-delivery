import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/hive/util/argument_hive_helper.dart';
import 'package:c4d/module_branches/branches_routes.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_stores/model/store_profile_model.dart';
import 'package:c4d/module_stores/request/active_store_request.dart';
import 'package:c4d/module_stores/stores_routes.dart';
import 'package:c4d/module_stores/ui/screen/store_info_screen.dart';
import 'package:c4d/module_subscriptions/subscriptions_routes.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
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
      Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.35,
            child: CustomNetworkImage(
              imageSource: profile?.image ?? '',
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.35,
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Theme.of(context).secondaryHeaderColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile?.storeOwnerName ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Row(
                            children: [
                              Text(
                                S.current.id + ': ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(profile?.id.toString() ?? ''),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              profile?.phone != null ||
                                      profile!.phone.isNotEmpty
                                  ? Clipboard.setData(
                                      ClipboardData(text: profile?.phone ?? ''))
                                  : null;
                              Fluttertoast.showToast(msg: S.current.copied);
                            },
                            child: Text(
                              profile?.phone ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.current.openingTime + ': ',
                                  style:
                                      TextStyle(color: Colors.green.shade900)),
                              Text(DateFormat.jm().format(
                                  profile?.openingTime ?? DateTime.now())),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.current.closingTime + ': ',
                                style: TextStyle(color: Colors.red.shade900),
                              ),
                              Text(DateFormat.jm().format(
                                  profile?.closingTime ?? DateTime.now())),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                S.current.bankName + ': ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(profile?.bankName ?? ''),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                S.current.city + ': ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(profile?.city ?? ''),
                            ],
                          ),
                          Text(
                            S.current.bankAccountNumber,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(profile?.bankNumber ?? ''),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
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
      Container(
          color: Colors.grey.shade200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(S.of(context).storeProfitMargin),
                Row(
                  children: [
                    Text(profile?.profitMargin.toString() ?? '0'),
                    Text(' ' + S.current.sar),
                  ],
                )
              ],
            ),
          )),
      Wrap(
        spacing: 8,
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        children: [
          cardTap(
              image: ImageAsset.ORDERS,
              title: S.of(context).storeOrders,
              onTapCard: () {
                Navigator.pushNamed(
                    screenState.context, StoresRoutes.LOGS_ORDERS_SCREEN,
                    arguments: profile);
              }),
          cardTap(
              image: ImageAsset.PAYMENT,
              title: S.of(context).subscriptionManagement,
              onTapCard: () {
                Navigator.of(context).pushNamed(
                    SubscriptionsRoutes.SUBSCRIPTIONS_MANAGEMENT,
                    arguments: profile ?? -1);
              }),
          cardTap(
              image: ImageAsset.BRANCH,
              title: S.of(context).manageBranch,
              onTapCard: () {
                Navigator.of(context).pushNamed(
                    BranchesRoutes.BRANCHES_LIST_SCREEN,
                    arguments: profile?.id ?? -1);
              }),
          cardTap(
              image: ImageAsset.CHAT,
              title: S.of(context).chatRoom,
              onTapCard: () {
                Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                    arguments: ChatArgument(
                        roomID: profile?.roomId ?? '',
                        userID: profile?.storeId,
                        userType: ''));
              }),
          cardTap(
              image: ImageAsset.PAYMENT,
              title: S.of(context).cashOrders,
              onTapCard: () {
                ArgumentHiveHelper()
                    .setCurrentStoreID(profile?.id.toString() ?? '-1');
                Navigator.of(context).pushNamed(
                  OrdersRoutes.ORDER_CASH_STORES,
                );
              }),
          // Visibility(
          //   visible: false,
          //   child: cardTap(
          //       image: ImageAsset.BID_ORDER,
          //       title: S.of(context).bidOrder,
          //       onTapCard: () {
          //         Navigator.pushNamed(
          //             screenState.context, BidOrderRoutes.BID_ORDER,
          //             arguments: profile?.id);
          //       }),
          // ),
          cardTap(
              image: ImageAsset.EDIT_PROFILE,
              title: S.of(context).editStoreSetting,
              onTapCard: () {
                Navigator.pushNamed(
                  context,
                  StoresRoutes.Edit_STORE_Setting_SCREEN,
                  arguments: [profile],
                ).then(
                  (value) {
                    if (value is bool && value) {
                      screenState.getStore(profile?.id ?? 0);
                    }
                  },
                );
              }),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).colorScheme.error,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      S.current.dangerZone,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      S.current.DeletingYourAccountHint,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return CustomAlertDialog(
                                    oneAction: false,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      screenState.stateManager.deleteStore(
                                          screenState, profile?.storeId ?? -1);
                                    },
                                    content: S.current
                                        .areSureAboutDeletingYourAccount);
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            S.current.deleteAccount,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ]));
  }

  Widget cardTap(
      {required String title,
      required String image,
      required Function() onTapCard}) {
    return GestureDetector(
      onTap: onTapCard,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: 165,
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    image,
                    height: 100,
                    width: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
