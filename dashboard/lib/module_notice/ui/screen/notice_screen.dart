import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_notice/request/notice_request.dart';
import 'package:c4d/module_notice/state_manager/notice_state_manager.dart';
import 'package:c4d/module_notice/ui/widget/notice_form.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/floated_button.dart';
import 'package:c4d/utils/effect/hidder.dart';

class NoticeScreen extends StatefulWidget {
  NoticeScreen();

  @override
  NoticeScreenState createState() => NoticeScreenState();
}

class NoticeScreenState extends State<NoticeScreen> {
  late States currentState;
  late NoticeStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  bool canAddCategories = true;
  int currentIndex = 0;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    _stateManager.getNotice(this);
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void getNotice() {
    _stateManager.getNotice(this);
  }

  void addNotice(NoticeRequest request) {
    _stateManager.addNotice(this, request);
  }

  void updateNotice(NoticeRequest request) {
    _stateManager.updateNotice(this, request);
  }

  void deleteCategories(String id) {
//    _stateManager.deleteCategories(this, id);
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
          title: S.of(context).notice, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
      floatingActionButton: Hider(
        active: canAddCategories,
        child: FloatedIconButton(
          text: S.current.addAds,
          icon: Icons.add_circle_rounded,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return NoticeForm(
                    onSave: (request) {
                      addNotice(request);
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
