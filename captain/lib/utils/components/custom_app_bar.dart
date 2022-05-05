import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/global/screen_type.dart';

class CustomC4dAppBar {
  static PreferredSizeWidget appBar(BuildContext context,
      {required title,
      GestureTapCallback? onTap,
      Color? colorIcon,
      Color? buttonBackground,
      IconData? icon,
      Widget? widget,
      bool canGoBack = true,
      List<Widget>? actions,
      PreferredSizeWidget? bottom
      }) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();
    if (icon == Icons.menu && ScreenType.isDesktop(context)) {
      icon = null;
      onTap = null;
      canGoBack = false;
    }
    return AppBar(
      bottom: bottom,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      leading: canGoBack
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: widget ??
                    InkWell(
                      customBorder: CircleBorder(),
                      onTap: onTap ?? () => Navigator.of(context).pop(),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: isDark
                                    ? Theme.of(context)
                                        .colorScheme
                                        .background
                                        .withOpacity(0.5)
                                    : Theme.of(context).backgroundColor,
                                spreadRadius: 1.5,
                                blurRadius: 6,
                                offset: Offset(-0.2, 0))
                          ],
                          color: buttonBackground ??
                              Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(icon ?? Icons.arrow_back,
                              color: colorIcon ??
                                  (isDark
                                      ? null
                                      : Theme.of(context).colorScheme.primary)),
                        ),
                      ),
                    ),
              ),
            )
          : Container(),
      elevation: 0,
      actions: actions,
    );
  }

  static Widget actionIcon(context,
      {required Function() onTap,
      Color? buttonBackground,
      required IconData icon,
      Color? colorIcon}) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: isDark
                      ? Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.5)
                      : Theme.of(context).backgroundColor,
                  spreadRadius: 1.5,
                  blurRadius: 6,
                  offset: Offset(-0.2, 0))
            ],
            color:
                buttonBackground ?? Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon,
                color: colorIcon ??
                    (isDark ? null : Theme.of(context).colorScheme.primary)),
          ),
        ),
      ),
    );
  }
}
