import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';

@injectable
class AppThemeDataService {
  static final PublishSubject<ThemeData> _darkModeSubject =
      PublishSubject<ThemeData>();

  Stream<ThemeData> get darkModeStream => _darkModeSubject.stream;

  final ThemePreferencesHelper _preferencesHelper;

  AppThemeDataService(this._preferencesHelper);

  static Color get PrimaryColor {
    return Colors.blue.shade900;
  }

  static Color get PrimaryDarker {
    return Colors.blue.shade900;
  }

  static Color get AccentColor {
    return Colors.blue.shade900;
  }

  ThemeData getActiveTheme() {
    var dark = _preferencesHelper.isDarkMode();
    final lightScheme = ColorScheme.fromSeed(seedColor: Colors.blue.shade900);
    final darkScheme = ColorScheme.fromSeed(
        seedColor:Colors.blue.shade900, brightness: Brightness.dark);
    if (dark == true) {
      return ThemeData(
        brightness: Brightness.dark,
        primaryColor: PrimaryColor,
        primaryColorDark: PrimaryDarker,
        useMaterial3: true,
   //     colorScheme: darkScheme,
        primarySwatch: Colors.blue,
        focusColor: PrimaryColor,
        cardColor: Colors.grey[150],
        fontFamily: GoogleFonts.almarai().fontFamily,
      );
    }
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: PrimaryColor,
        primaryColorDark: PrimaryDarker,
        useMaterial3: true,
    //    colorScheme: lightScheme,
        focusColor: PrimaryColor,
        primarySwatch: Colors.blue,
        cardColor: Color.fromRGBO(245, 245, 245, 1),
        backgroundColor: Color.fromRGBO(236, 239, 241, 1),
        fontFamily: GoogleFonts.almarai().fontFamily,
        timePickerTheme: TimePickerThemeData(
          dialBackgroundColor: Color.fromRGBO(235, 235, 235, 1),
          dayPeriodBorderSide:
              BorderSide(color: Color.fromRGBO(235, 235, 235, 1)),
        ));
  }

  void switchDarkMode(bool darkMode) async {
    if (darkMode) {
      _preferencesHelper.setDarkMode();
    } else {
      _preferencesHelper.setDayMode();
    }
    var activeTheme = await getActiveTheme();
    _darkModeSubject.add(activeTheme);
  }
}
