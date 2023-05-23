import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_supplier/state_manager/supplier_list.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';

import '../../../utils/global/global_state_manager.dart';

@injectable
class SuppliersScreen extends StatefulWidget {
  final SuppliersStateManager _stateManager;

  SuppliersScreen(this._stateManager);

  @override
  SuppliersScreenState createState() => SuppliersScreenState();
}

class SuppliersScreenState extends State<SuppliersScreen> {
  late States currentState;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    getIt<GlobalStateManager>().stateStream.listen((event) {
      getCaptains();
    });
    widget._stateManager.getSuppliers(this);
    super.initState();
  }

  void getCaptains() {
    widget._stateManager.getSuppliers(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).suppliers, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}
