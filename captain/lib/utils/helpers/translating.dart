import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:translator/translator.dart';

class Trans {
  static String localString(String word, BuildContext context) {
    if (Localizations.localeOf(context).languageCode == 'en') {
      return word;
    }
    late String newWord;
    newWord = word.replaceAll('minutes', ' ' + S.current.minutes + ' ');
    newWord = newWord.replaceAll('minute', ' ' + S.current.minute + ' ');
    newWord = newWord.replaceAll('seconds', ' ' + S.current.second + ' ');
    newWord = newWord.replaceAll('second', ' ' + S.current.seconds + ' ');
    newWord = newWord.replaceAll('hours', ' ' + S.current.hours + ' ');
    newWord = newWord.replaceAll('hour', ' ' + S.current.hour + ' ');
    newWord = newWord.replaceAll('days', ' ' + S.current.days + ' ');
    newWord = newWord.replaceAll('day', ' ' + S.current.day + ' ');
    return newWord;
  }
   static Future<String> translateService(String word) async {
    var reg = RegExp(
        r'[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc]');
    if (reg.hasMatch(word) &&
        getIt<LocalizationService>().getLanguage() == 'ar') {
      return word;
    }
    final translator = GoogleTranslator();
    var translation = await translator.translate(word,
        to: getIt<LocalizationService>().getLanguage());
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    print('source ${translation.source} translated to ${translation.text}');
    print(
        'source ${translation.sourceLanguage} target ${translation.targetLanguage}');
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++');

    return translation.text;
  }
}
