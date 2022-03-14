import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/model/captain_offer_model.dart';
import 'package:c4d/module_captain/ui/screen/captains_offer_screen.dart';
import 'package:c4d/module_captain/ui/widget/captain_offer_form.dart';
import 'package:c4d/module_captain/ui/widget/offer_card.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/costom_search.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';

class CaptainOffersLoadedState extends States {
  final CaptainOffersScreenState screenState;
  final String? error;
  final bool empty;
  final List<CaptainsOffersModel>? model;

  CaptainOffersLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.canAddCategories = false;
      screenState.refresh();
    }
  }

  String? search;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getCaptainOffer();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getCaptainOffer();
          });
    }
    return Container(
      width: double.maxFinite,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: CustomListView.custom(children: getCategories()),
        ),
      ),
    );
  }

  List<Widget> getCategories() {
    var context = screenState.context;
    List<Widget> widgets = [];
    if (model == null) {
      return widgets;
    }
    if (model!.isEmpty) return widgets;
    for (var element in model ?? <CaptainsOffersModel>[]) {
//      if (!element.categoryName.contains(search ?? '') && search != null) {
//        continue;
//      }

      widgets.add(CaptainOfferCard(
        model: element,
        onEdit: () {
          showDialog(
              context: context,
              builder: (_) {
                return CaptainOfferForm(
                  request: element,
                  onSave: (request){
                  screenState.updateCaptainOffer(request);
                },);
              });
        },
        ),
      );
    }

    if (model != null) {
      widgets.insert(
          0,
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 16),
            child: CustomDeliverySearch(
              hintText: S.current.search,
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
    widgets.add(SizedBox(
      height: 50,
    ));
    return widgets;
  }
}
