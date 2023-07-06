import 'package:store_web/abstracts/states/state.dart';
import 'package:store_web/module_main/state_manager/main_state_manager.dart';
import 'package:store_web/module_main/ui/states/main_state_loaded.dart';
import 'package:store_web/utils/components/custom_app_bar.dart';
import 'package:store_web/utils/images/images.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

@injectable
class MainScreen extends StatefulWidget {
  final MainStateManager _stateManager;

  const MainScreen(this._stateManager);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late States _currentStates;

  @override
  void initState() {
    _currentStates = MainStateLoaded(this);
    super.initState();
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  void deleteStore() {
    widget._stateManager.deleteStore(this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(255, 233, 195, 113),
            ),
          ),
          Image.asset(
            ImageAsset.AUTH_BACKGROUND,
            fit: BoxFit.fill,
          ),
          Scaffold(
            appBar: CustomC4dAppBar.appBar(
              context,
              canGoBack: false,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: _currentStates.getUI(context),
          ),
        ],
      ),
    );
  }
}
