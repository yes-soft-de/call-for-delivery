import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/store_profile_model.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/request/edit_store_setting_request.dart';
import 'package:c4d/module_stores/request/welcome_package_payment_request.dart';
import 'package:c4d/module_stores/state_manager/edit_store_setting_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditStoreSettingScreen extends StatefulWidget {
  final EditStoreSettingStateManager stateManager;

  EditStoreSettingScreen(this.stateManager);

  @override
  State<EditStoreSettingScreen> createState() => EditStoreSettingScreenState();
}

class EditStoreSettingScreenState extends State<EditStoreSettingScreen> {
  bool flag = true;
  late States currentState;
  late StoreProfileModel model;
  int currentIndex = 0;
  bool refreshThePreviousScreen = false;
  bool shouldCreateNewSetting = false;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget.stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void updateStore(UpdateStoreRequest request, bool haveImage) {
    widget.stateManager.updateStore(this, request, haveImage);
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  void updateWelcomePackagePayment(
    WelcomePackagePaymentRequest request, [
    bool loading = false,
  ]) {
    widget.stateManager
        .updateWelcomePackagePayment(this, request, model.id, loading);
  }

  void createOrUpdateStoreSetting(EditStoreSettingRequest request) {
    widget.stateManager.createOrEditStoreSetting(this, request);
  }

  @override
  Widget build(BuildContext context) {
    if (flag) {
      var args = ModalRoute.of(context)?.settings.arguments as List;
      if (args.length > 0) {
        model = args[0] as StoreProfileModel;
        flag = false;
        widget.stateManager.getStoreSetting(this);
      }
      currentState = LoadingState(this);
    }
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, refreshThePreviousScreen);
        return true;
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(
          context,
          title: S.current.storeSetting,
          onTap: () {
            Navigator.maybePop(context);
          },
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          currentIndex = 0;
                          refresh();
                        },
                        child: AnimatedContainer(
                          height: 40,
                          padding: EdgeInsets.all(8),
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: currentIndex != 0
                                    ? Colors.grey
                                    : Colors.white,
                                width: 1),
                            borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(25),
                                bottomStart: Radius.circular(25)),
                            color: currentIndex == 0
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                          ),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                          child: Text(
                            S.current.profile,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: currentIndex != 0
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          currentIndex = 1;
                          refresh();
                        },
                        child: AnimatedContainer(
                          height: 40,
                          padding: EdgeInsets.all(8),
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: currentIndex != 1
                                      ? Colors.grey
                                      : Colors.white,
                                  width: 1),
                              borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(25),
                                  bottomEnd: Radius.circular(25)),
                              color: currentIndex == 1
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.background),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                          child: Text(
                            S.current.packages,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: currentIndex != 1
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            currentState.getUI(context),
          ],
        ),
      ),
    );
  }
}
