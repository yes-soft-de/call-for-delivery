import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/state_manager/edit_profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileScreen extends StatefulWidget {
  final EditProfileStateManager _stateManager;

  ProfileScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  States? states;

  void saveProfile(ProfileRequest request) {
    widget._stateManager.updateProfile(this, request);
  }

  void getProfile() {
    widget._stateManager.getProfile(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    widget._stateManager.stateStream.listen((event) {
      states = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.getProfile(this);
    super.initState();
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
        body: states?.getUI(context),
      ),
    );
  }
}
