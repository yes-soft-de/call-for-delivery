import 'dart:async';

import 'package:c4d/di/di_config.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/state_manager/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_loading/profile_loading.dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:c4d/module_profile/ui/states/profile_state_dirty_profile/profile_state_dirty_profile.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen();

  @override
  State<StatefulWidget> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  late ProfileState states;
  late EditProfileStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  @override
  void initState() {
    states = ProfileStateLoading(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      states = event;
      if (mounted) {
        setState(() {});
      }
    });
    _stateManager.getProfile(this);
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void saveProfile(ProfileRequest request) {
    _stateManager.submitProfile(this, request);
  }

  void uploadImage(ProfileRequest request, String? type, [String? image]) {
    _stateManager.uploadImage(this, request, type, image);
  }

  void showMessage(String msg, bool success) {
    if (success) {
      CustomFlushBarHelper.createSuccess(
              title: S.current.warnning, message: msg)
          .show(context);
    } else {
      CustomFlushBarHelper.createError(title: S.current.warnning, message: msg)
          .show(context);
    }
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
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
      child: Scaffold(
        appBar: states is ProfileStateDirtyProfile
            ? null
            : CustomC4dAppBar.appBar(
                context,
                title: S.of(context).profile,
              ),
        body: states.getUI(context),
      ),
    );
  }
}
