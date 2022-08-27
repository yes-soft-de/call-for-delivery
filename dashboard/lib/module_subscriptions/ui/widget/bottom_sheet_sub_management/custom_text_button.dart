import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  const CustomTextButton(
      {Key? key, required this.onPressed, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = getIt<ThemePreferencesHelper>().isDarkMode();
    return SizedBox(
      width: double.maxFinite,
      child: TextButton(
          style: TextButton.styleFrom(shape: StadiumBorder()),
          onPressed: onPressed,
          child: Text(
            label,
            style: isDark ? TextStyle(color: Colors.white70) : null,
          )),
    );
  }
}
