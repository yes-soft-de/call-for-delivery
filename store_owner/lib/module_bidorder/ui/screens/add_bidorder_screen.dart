import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_bidorder/model/supplier_model/supplier_category_model.dart';
import 'package:c4d/module_bidorder/request/add_bidorder_request.dart';
import 'package:c4d/module_bidorder/state_manager/add_bidorder_state_manager.dart';
import 'package:c4d/module_bidorder/state_manager/open_order_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddBidOrderScreen extends StatefulWidget {
  final AddBidOrderStateManager _stateManager;

  AddBidOrderScreen(this._stateManager);

  @override
  AddBidOrderScreenState createState() => AddBidOrderScreenState();
}

class AddBidOrderScreenState extends State<AddBidOrderScreen> {
  late States currentState;
  StreamSubscription? _stateSubscription;

  void addNewOrder(AddBidOrderRequest request, List<BranchesModel> branches,
      List<SupplierCategoriesModel> categories) {
    widget._stateManager
        .createOrder(this, request, categories: categories, branches: branches);
  }

  void refresh() {
    setState(() {});
  }

  // New Order state controller
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  String? payments;
  int? branch;
  int? category;

  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this);
    widget._stateManager.getBranches(this);

    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    descriptionController.dispose();
//    noteController.dispose();
    titleController.dispose();
    _stateSubscription?.cancel();
    super.dispose();
  }

  void saveInfo(String info) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(context, title: S.current.newOrder),
        body: SafeArea(
          child: currentState.getUI(context),
        ),
      ),
    );
  }
}
