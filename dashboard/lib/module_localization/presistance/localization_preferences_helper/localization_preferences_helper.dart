import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocalizationPreferencesHelper {
  var prefs = Hive.box('Localization');

  void setLanguage(String lang) {
    prefs.put('lang', lang);
  }

  String? getLanguage() {
    return prefs.get('lang');
  }
}
