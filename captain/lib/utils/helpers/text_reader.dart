import 'dart:io';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';

@injectable
class FlutterTextToSpeech {
  Future<FlutterTts> init() async {
    FlutterTts flutterTts = FlutterTts();
    if (Platform.isIOS) {
      await flutterTts.setSharedInstance(true);
      await flutterTts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.ambient,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers
          ],
          IosTextToSpeechAudioMode.voicePrompt);
    }
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.awaitSynthCompletion(true);
    //
    List<dynamic> languages = await flutterTts.getLanguages;
    print(
        'language available -----------------------------------------------------');
    print(languages);
    print(
        'language available -----------------------------------------------------');
    await flutterTts.isLanguageAvailable("en-US");
    var currentLang = getIt<LocalizationService>().getLanguage();
    if (currentLang == 'en') {
      currentLang = currentLang + '-US';
      await flutterTts.setLanguage(currentLang);
    } else {
      currentLang = currentLang + '';
      await flutterTts.setLanguage(currentLang);
    }

    await flutterTts.setSpeechRate(0.5);

    await flutterTts.setVolume(1.0);

    await flutterTts.setPitch(1.0);

    await flutterTts.setVoice({"name": "Karen", "locale": currentLang});

    //  await flutterTts.isLanguageInstalled("en-AU");

    //    await flutterTts.areLanguagesInstalled(["en-AU", "en-US"]);

    await flutterTts.setQueueMode(1);

    await flutterTts.getMaxSpeechInputLength;
    return flutterTts;
  }
}
