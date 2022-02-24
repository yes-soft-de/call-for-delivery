import 'package:c4d/module_theme/map_style.dart';
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

  ThemeData getActiveTheme() {
    var dark = _preferencesHelper.isDarkMode();
    final lightScheme = ColorScheme.fromSeed(seedColor: PrimaryColor);
    final darkScheme = ColorScheme.fromSeed(
        seedColor: PrimaryColor, brightness: Brightness.dark);
    if (dark == true) {
      mapStyle(dark);
      return ThemeData(
          brightness: Brightness.dark,
          colorScheme: darkScheme,
          useMaterial3: true,
          primarySwatch: Colors.indigo,
          focusColor: PrimaryColor,
          checkboxTheme: CheckboxThemeData(
            checkColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              const Set<MaterialState> interactiveStates = <MaterialState>{
                MaterialState.pressed,
                MaterialState.hovered,
                MaterialState.focused,
              };
              if (states.any(interactiveStates.contains)) {
                return Colors.grey;
              }
              return Colors.white;
            }),
            fillColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              const Set<MaterialState> interactiveStates = <MaterialState>{
                MaterialState.pressed,
                MaterialState.hovered,
                MaterialState.focused,
              };
              if (states.any(interactiveStates.contains)) {
                return Colors.black;
              }
              return Colors.indigo;
            }),
          ),
          cardColor: Colors.grey[150],
          fontFamily: 'Dubai',
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          )),
          textTheme: TextTheme(button: TextStyle(color: Colors.white)));
    }
    mapStyle(dark);
    return ThemeData(
        brightness: Brightness.light,
        //       primaryColor: PrimaryColor,
        colorScheme: lightScheme,
        useMaterial3: true,
        //    colorScheme: lightScheme,
        focusColor: PrimaryColor,
        primarySwatch: Colors.indigo,
        cardColor: Color.fromRGBO(245, 245, 245, 1),
        backgroundColor: Color.fromRGBO(236, 239, 241, 1),
        textTheme: TextTheme(button: TextStyle(color: Colors.white)),
        fontFamily: 'Dubai',
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

  void mapStyle(bool darkMode) {
    String darkStyle = MapStyle.darkStyle;

    String lightStyle = '''[]''';

    if (darkMode) {
      _preferencesHelper.setMapStyle(darkStyle);
    } else {
      _preferencesHelper.setMapStyle(lightStyle);
    }
  }
}
