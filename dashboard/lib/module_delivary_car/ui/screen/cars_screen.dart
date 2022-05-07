import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_delivary_car/request/car_request.dart';
import 'package:c4d/module_delivary_car/state_manager/cars_state_manager.dart';
import 'package:c4d/module_delivary_car/ui/widget/car_form.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/floated_button.dart';
import 'package:c4d/utils/effect/hidder.dart';

@injectable
class CarsScreen extends StatefulWidget {
  final CarsStateManager _stateManager;

  CarsScreen(this._stateManager);

  @override
  CarsScreenState createState() => CarsScreenState();
}

class CarsScreenState extends State<CarsScreen> {
  late States currentState;
  bool canAddCategories = true;
  int currentIndex = 0;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    widget._stateManager.getCars(this);
    super.initState();
  }

  void getCars() {
    widget._stateManager.getCars(this);
  }

  void addCars(CarRequest request) {
    widget._stateManager.addCars(this, request);
  }

//  void updateCars(CarsRequest request) {
//    widget._stateManager.updateCars(this, request);
//  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).deliveryCars, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
      floatingActionButton: Hider(
        active: canAddCategories,
        child: FloatedIconButton(
          text: S.current.addCars,
          icon: Icons.add_circle_rounded,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return CarsForm(
                    onSave: (request) {
                      addCars(request);
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
