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
    return Color.fromRGBO(33, 32, 156, 1);
  }

  static Color get PrimaryDarker {
    return Colors.orange;
  }

  static Color get AccentColor {
    return Colors.orangeAccent;
  }

  ThemeData getActiveTheme() {
    var dark = _preferencesHelper.isDarkMode();
    final lightScheme = ColorScheme.fromSeed(seedColor: PrimaryColor);
    final darkScheme = ColorScheme.fromSeed(
        seedColor: PrimaryColor, brightness: Brightness.dark);
    if (dark == true) {
      return ThemeData(
        brightness: Brightness.dark,
        primaryColor: PrimaryColor,
        primaryColorDark: PrimaryDarker,
        colorScheme: darkScheme,
        useMaterial3: true,
        //     colorScheme: darkScheme,
        primarySwatch: Colors.orange,
        focusColor: PrimaryColor,
        cardColor: Colors.grey[150],
        fontFamily: GoogleFonts.almarai().fontFamily,
        textTheme: TextTheme(
          button:TextStyle(color:Colors.white)
        )
      );
    }
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: PrimaryColor,
        primaryColorDark: PrimaryDarker,
        colorScheme: lightScheme,
        useMaterial3: true,
        //    colorScheme: lightScheme,
        focusColor: PrimaryColor,
        primarySwatch: Colors.orange,
        cardColor: Color.fromRGBO(245, 245, 245, 1),
        backgroundColor: Color.fromRGBO(236, 239, 241, 1),
         textTheme: TextTheme(
          button:TextStyle(color:Colors.white)
        ),
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
