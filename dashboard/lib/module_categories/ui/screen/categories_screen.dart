import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_categories/request/package_category_request.dart';
import 'package:c4d/module_categories/ui/widget/category_form.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_categories/state_manager/categories_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/floated_button.dart';
import 'package:c4d/utils/effect/hidder.dart';

@injectable
class CategoriesScreen extends StatefulWidget {
  final PackageCategoriesStateManager _stateManager;

  CategoriesScreen(this._stateManager);

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  late States currentState;
  bool canAddCategories = true;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    widget._stateManager.getCategories(this);
    super.initState();
  }

  void getPackagesCategories() {
    widget._stateManager.getCategories(this);
  }

  void addCategory(PackageCategoryRequest request) {
    widget._stateManager.createCategory(this, request);
  }

  void updateCategory(PackageCategoryRequest request) {
    widget._stateManager.updateCategory(this, request);
  }

  void deleteCategories(String id) {
    widget._stateManager.deleteCategories(this, id);
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
