// ignore_for_file: unused_local_variable
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_supplier/model/ads_model.dart';
import 'package:c4d/module_supplier/ui/screen/supplier_ads_screen.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';

class SupplierAdsLoadedState extends States {
  final SupplierAdsScreenState screenState;
  final String? error;
  final bool empty;
  final List<SupplierAdsModel>? model;

  SupplierAdsLoadedState(this.screenState, this.model,
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
//          screenState.getCaptains();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
//            screenState.getCaptains();
          });
    }
    return FixedContainer(
      child: ListView.builder(
        itemCount: model?.length ?? 0,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Text('');
        },
      ),
    );
  }
}
