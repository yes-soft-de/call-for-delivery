import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomListTile extends StatelessWidget {
  String title;
  String? subTitle;
  IconData iconData;
  CustomListTile(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? icon;
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();

    if (title == S.current.myStatus) {
      icon = PhysicalModel(
          color: Theme.of(context).scaffoldBackgroundColor,
          elevation: 5,
          shape: BoxShape.circle,
          child: Icon(
            Icons.circle,
            color: subTitle == 'active' ? Colors.green : Colors.red,
            size: 30,
          ));
      subTitle = subTitle == 'active'
          ? S.current.accountActivated
          : S.current.accountInActivated;
    }
    return ListTile(
      leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(iconData,
                color:isDark ? null : Theme.of(context).colorScheme.primaryContainer),
          )),
      title: Text(
        title,
      ),
      trailing: icon,
      subtitle: Text(
        subTitle ?? S.current.unknown,
        textDirection: S.current.phoneNumber == title &&
                Localizations.localeOf(context).languageCode == 'ar'
            ? TextDirection.ltr
            : null,
        textAlign: S.current.phoneNumber == title &&
                Localizations.localeOf(context).languageCode == 'ar'
            ? TextAlign.right
            : null,
      ),
    );
  }
}
