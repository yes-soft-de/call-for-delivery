import 'package:c4d/module_captain/model/captains_order_model.dart';
import 'package:c4d/module_captain/request/assign_order_to_captain_request.dart';
import 'package:c4d/module_captain/ui/screen/captains_assign_order_screen.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/costom_search.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CaptainAssignOrderLoadedState extends States {
  final CaptainAssignOrderScreenState screenState;
  final String? error;
  final bool empty;
  final List<CaptainOrderModel>? model;

  CaptainAssignOrderLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }

  String? id;
  String? search;
  TextStyle activeStyle = TextStyle(color: Colors.white);
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getCaptains();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getCaptains();
          });
    }
    return FixedContainer(
        child: Column(
      children: [
        Expanded(
          child: CustomListView.custom(children: getCaptains(context)),
        ),
        Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: TextButton(
                        style: TextButton.styleFrom(shape: StadiumBorder()),
                        onPressed: () {
                          var request = AssignOrderToCaptainRequest(
                              id: int.tryParse(id ?? ''),
                              orderId: screenState.orderID);
                          Navigator.pop(context);
                        },
                        child: Text(S.current.update)),
                  ),
                  Divider(
                    color: Theme.of(context).backgroundColor,
                    thickness: 2.5,
                    indent: 16,
                    endIndent: 16,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: TextButton(
                        style: TextButton.styleFrom(shape: StadiumBorder()),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(S.current.cancel)),
                  ),
                ],
              ),
            )),
      ],
    ));
  }

  List<Widget> getCaptains(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in model ?? <CaptainOrderModel>[]) {
      if (!element.captainName.contains(search ?? '') && search != null) {
        continue;
      }
      widgets.add(InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          if (element.chosen == false) {
            model?.forEach((element) {
              element.chosen = false;
            });
            element.chosen = true;
            id = element.captainID;
          } else {
            model?.forEach((element) {
              element.chosen = false;
            });
            id = null;
          }
          screenState.refresh();
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              boxShadow: element.chosen
                  ? [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        spreadRadius: 1.5,
                        offset: Offset(0.5, 0.5),
                        blurRadius: 6,
                      ),
                    ]
                  : null,
              gradient: element.chosen
                  ? LinearGradient(colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      Theme.of(context).colorScheme.primary.withOpacity(0.9),
                      Theme.of(context).colorScheme.primary,
                    ])
                  : null),
          child: Row(
            children: [
              CircleAvatar(
                child: CustomNetworkImage(
                  width: 50,
                  height: 50,
                  imageSource: element.image,
                ),
              ),
              Text(element.captainName),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.boxes,
                      color: element.chosen ? Colors.white : null,
                    ),
                    Text(
                      element.countOngoingOrders.toString() +
                          ' ${S.current.order}',
                      style: element.chosen ? activeStyle : null,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    }

    if (model != null) {
      widgets.insert(
          0,
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 16),
            child: CustomDeliverySearch(
              hintText: S.current.searchForCaptain,
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
          ));
    }

    return widgets;
  }
}
