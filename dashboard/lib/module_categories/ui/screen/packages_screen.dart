import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_categories/request/active_package_request.dart';
import 'package:c4d/module_categories/request/package_request.dart';
import 'package:c4d/module_categories/ui/widget/package_form.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/floated_button.dart';
import 'package:c4d/utils/effect/hidder.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/state_manager/packages_state_manager.dart';

@injectable
class PackagesScreen extends StatefulWidget {
  final PackagesStateManager _stateManager;

  PackagesScreen(this._stateManager);

  @override
  PackagesScreenState createState() => PackagesScreenState();
}

class PackagesScreenState extends State<PackagesScreen> {
  late States currentState;
  bool canAddPackage = false;

  String? id;

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

  void getCategories() {
    widget._stateManager.getCategories(this);
  }

  void getPackagesCategories(int id ,List<PackagesCategoryModel> categories) {
    widget._stateManager.getPackagesByCategory(this, id,categories);
  }

  void createPackage(PackageRequest request) {
    widget._stateManager.createPackage(this, request);
  }

  void updatePakage(PackageRequest request) {
    widget._stateManager.updatePackage(this, request);
  }
  void enablePackage(ActivePackageRequest request) {
    widget._stateManager.enablePackage(this, request);
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
                  return PackageForm(onSave: (request){
                    request.packageCategoryID = int.parse(id ?? '-1');
                    createPackage(request);
                  },);
                });
          },
        ),
      ),
    );
  }
}
