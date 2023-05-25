import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_delivary_car/model/car_model.dart';
import 'package:c4d/module_delivary_car/ui/screen/cars_screen.dart';
import 'package:c4d/module_delivary_car/ui/widget/car_card.dart';
import 'package:c4d/module_delivary_car/ui/widget/car_form.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';

class CarsLoadedState extends States {
  final CarsScreenState screenState;
  final String? error;
  final bool empty;
  final List<CarsModel>? model;

  CarsLoadedState(this.screenState, this.model,
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
          screenState.getCars();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getCars();
          });
    }
    return Container(
      width: double.maxFinite,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: CustomListView.custom(
              children: getCategories(screenState.currentIndex, context)),
        ),
      ),
    );
  }

  List<Widget> getCategories(int currentIndex, context) {
    List<Widget> widgets = [];
    if (model == null) {
      return widgets;
    }
    if (model!.isEmpty) return widgets;
    for (var element in model ?? <CarsModel>[]) {
      widgets.add(
        CarCard(
          model: element,
          edit: () {
            showDialog(
                context: context,
                builder: (_) {
                  return CarsForm(
                    request: element,
                    onSave: (request) {
                      screenState.updateCars(request);
                    },
                  );
                });
          },
        ),
      );
    }
    return widgets;
  }
}
