import 'package:store_web/di/di_config.dart';
import 'package:store_web/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:flutter/material.dart';

class CustomNavTile extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  const CustomNavTile(
      {Key? key, required this.icon, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            splashColor: isDark
                ? null
                : Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.5),
            highlightColor: Theme.of(context).colorScheme.background,
            splashFactory: InkRipple.splashFactory,
            onTap: onTap,
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isDark
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon,
                      color: isDark
                          ? null
                          : Theme.of(context).colorScheme.primary),
                ),
              ),
              title: Text(title),
            ),
          ),
        ));
  }
}
