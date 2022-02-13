import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:c4d/module_about/ui/states/about/about_state_page_owner.dart';
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
    widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: _currentState != null
                  ? _currentState!.getUI(context)
                  : SizedBox()),
          _currentState is AboutStatePageOwner && currentPage != 3
              ? SizedBox()
              : GestureDetector(
                  onTap: () {
                    // to Register
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.of(context).skip,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {
    });
  }
}
