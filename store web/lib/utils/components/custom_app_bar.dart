import 'package:store_web/di/di_config.dart';
import 'package:store_web/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:store_web/utils/global/screen_type.dart';

class CustomC4dAppBar {
  static PreferredSizeWidget appBar(
    BuildContext context, {
    String? title,
    GestureTapCallback? onTap,
    Color? colorIcon,
    Color? buttonBackground,
    Color? backgroundColor,
    IconData? icon,
    Widget? widget,
    bool canGoBack = true,
    List<Widget>? actions,
  }) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();
    if (icon == Icons.menu && ScreenType.isDesktop(context)) {
      icon = null;
      onTap = null;
      canGoBack = false;
    }
    return AppBar(
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Visibility(
        visible: title != null,
        child: Text(
          title ?? '',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      leading: canGoBack
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: widget ??
                    InkWell(
                      customBorder: const CircleBorder(),
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
                                    : Theme.of(context).colorScheme.background,
                                spreadRadius: 1.5,
                                blurRadius: 6,
                                offset: const Offset(-0.2, 0))
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
      String? message,
      Color? colorIcon}) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Tooltip(
        message: message ?? '',
        child: InkWell(
          customBorder: const CircleBorder(),
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
                        : Theme.of(context).colorScheme.background,
                    spreadRadius: 1.5,
                    blurRadius: 6,
                    offset: const Offset(-0.2, 0))
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
      ),
    );
  }
}
