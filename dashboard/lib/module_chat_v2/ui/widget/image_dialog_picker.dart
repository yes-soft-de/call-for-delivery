import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:flutter/material.dart';

void showImageDialogPicker(context, {required Function() onGallery, required Function() onCamera}) {
  var isDark =
  getIt<ThemePreferencesHelper>().isDarkMode();
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).scaffoldBackgroundColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: TextButton(
                            style: TextButton.styleFrom(shape: const StadiumBorder()),
                            onPressed: onCamera,
                            child: Text(S.current.camera,
                                style: isDark
                                    ? const TextStyle(color: Colors.white70)
                                    : null)),
                      ),
                      Divider(
                        indent: 16,
                        endIndent: 16,
                        color: Theme.of(context).colorScheme.background,
                        thickness: 2.5,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: TextButton(
                            style: TextButton.styleFrom(shape: const StadiumBorder()),
                            onPressed: onGallery,
                            child: Text(S.current.gallery,
                                style: isDark
                                    ? const TextStyle(color: Colors.white70)
                                    : null)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, shape: const StadiumBorder()),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        S.current.close,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    )),
              ),
            )
          ],
        );
      });
}
