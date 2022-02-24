import 'package:flutter/material.dart';
import 'package:c4d/utils/global/screen_type.dart';

class CustomMandoobAppBar {
  static PreferredSizeWidget appBar(BuildContext context,
      {required title,
      GestureTapCallback? onTap,
      Color? colorIcon,
      Color? buttonBackground,
      IconData? icon,
      bool canGoBack = true,
      List<Widget>? actions}) {
    if (icon == Icons.menu && ScreenType.isDesktop(context)) {
      icon = null;
      onTap = null;
      canGoBack = false;
    }
    return AppBar(
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
                child: InkWell(
                  customBorder: CircleBorder(),
                  onTap: onTap ?? () => Navigator.of(context).pop(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).backgroundColor,
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
                              Theme.of(context).colorScheme.primary),
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
}
