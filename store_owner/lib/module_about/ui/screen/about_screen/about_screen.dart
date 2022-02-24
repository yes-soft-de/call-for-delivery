import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:c4d/module_about/ui/states/about/about_state_page_owner.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  final AboutScreenStateManager _stateManager;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AboutScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> {
  AboutState? _currentState;
  int currentPage = 0;
  @override
  void initState() {
    _currentState = AboutStatePageOwner(this, []);
    widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: widget._scaffoldKey, body: _currentState?.getUI(context));
  }

  void refresh() {
    setState(() {});
  }
}
