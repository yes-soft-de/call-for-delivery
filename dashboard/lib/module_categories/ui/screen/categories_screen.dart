import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_categories/request/active_package_request.dart';
import 'package:c4d/module_categories/request/package_category_request.dart';
import 'package:c4d/module_categories/state_manager/categories_state_manager.dart';
import 'package:c4d/module_categories/ui/widget/category_form.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/floated_button.dart';
import 'package:c4d/utils/effect/hidder.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen();

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  late States currentState;
  late PackageCategoriesStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  bool canAddCategories = true;

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

  void getPackagesCategories() {
    _stateManager.getCategories(this);
  }

  void addCategory(PackageCategoryRequest request) {
    _stateManager.createCategory(this, request);
  }

  void updateCategory(PackageCategoryRequest request) {
    _stateManager.updateCategory(this, request);
  }

  void deleteCategories(String id) {
    _stateManager.deleteCategories(this, id);
  }

  void enableCategories(ActivePackageRequest request) {
    _stateManager.enableCategories(this, request);
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
          title: S.of(context).categories, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
      floatingActionButton: Hider(
        active: canAddCategories,
        child: FloatedIconButton(
          text: S.current.addCategory,
          icon: Icons.add_circle_rounded,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return CategoryForm(
                    onSave: (request) {
                      addCategory(request);
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
