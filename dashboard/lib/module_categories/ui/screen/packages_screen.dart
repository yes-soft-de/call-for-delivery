import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_categories/request/active_package_request.dart';
import 'package:c4d/module_categories/request/package_request.dart';
import 'package:c4d/module_categories/state_manager/packages_state_manager.dart';
import 'package:c4d/module_categories/ui/widget/package_form.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/floated_button.dart';
import 'package:c4d/utils/effect/hidder.dart';
import 'package:flutter/material.dart';

class PackagesScreen extends StatefulWidget {
  PackagesScreen();

  @override
  PackagesScreenState createState() => PackagesScreenState();
}

class PackagesScreenState extends State<PackagesScreen> {
  late States currentState;
  late PackagesStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  bool canAddPackage = false;

  String? id;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    _stateManager.getCategories(this);
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void getCategories() {
    _stateManager.getCategories(this);
  }

  void getPackagesCategories(int id, List<PackagesCategoryModel> categories) {
    _stateManager.getPackagesByCategory(this, id, categories);
  }

  void createPackage(PackageRequest request) {
    _stateManager.createPackage(this, request);
  }

  void updatePakage(PackageRequest request) {
    _stateManager.updatePackage(this, request);
  }

  void enablePackage(ActivePackageRequest request, bool loading) {
    _stateManager.enablePackage(this, request, loading);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  bool flagArgs = true;
  int? storeId;

  @override
  Widget build(BuildContext context) {
    if (id != null) {
      canAddPackage = true;
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).packages, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
      floatingActionButton: Hider(
        active: canAddPackage,
        child: FloatedIconButton(
          text: S.current.addPackage,
          icon: Icons.add_circle_rounded,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return PackageForm(
                    onSave: (request) {
                      request.packageCategoryID = int.parse(id ?? '-1');
                      createPackage(request);
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
