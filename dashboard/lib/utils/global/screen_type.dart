import 'package:flutter/material.dart';
import 'package:c4d/global_nav_key.dart';

class ScreenType {
  static String getCurrentScreenType() {
    var screenSize =
        MediaQuery.of(GlobalVariable.navState.currentContext!).size;

    if (screenSize.width >= 1200) {
      return 'Desktop';
    }
    if (screenSize.width >= 600) {
      return 'Tablet';
    }
    if (screenSize.width >= 250) {
      return 'Mobile';
    } else {
      return 'Watch';
    }
  }

  static bool isMobile(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (screenSize.width < 600) {
      return true;
    } else {
      return false;
    }
  }

  static bool isDesktop(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (screenSize.width >= 1200) {
      return true;
    } else {
      return false;
    }
  }

  static bool isTablet(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (screenSize.width > 600 && screenSize.width < 1200) {
      return true;
    } else {
      return false;
    }
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget? desktopBody;
  final Widget? tabletBody;

  ResponsiveLayout(
      {required this.mobileBody, this.desktopBody, this.tabletBody});

  @override
  Widget build(BuildContext context) {
    if (ScreenType.isMobile(context))
      return mobileBody;
    else if (ScreenType.isDesktop(context))
      return desktopBody ?? mobileBody;
    else if (ScreenType.isTablet(context))
      return tabletBody ?? desktopBody ?? mobileBody;
    else
      return mobileBody;
  }
}
