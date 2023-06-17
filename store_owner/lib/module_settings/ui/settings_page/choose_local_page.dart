import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_settings/widget/selectable_item.dart';
import 'package:c4d/module_splash/splash_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:c4d/utils/images/images.dart';

@injectable
class ChooseLocalScreen extends StatefulWidget {
  final LocalizationService _localizationService;
  const ChooseLocalScreen(
    this._localizationService,
  );

  @override
  _ChooseLocalScreenState createState() => _ChooseLocalScreenState();
}

class _ChooseLocalScreenState extends State<ChooseLocalScreen> {
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return Stack(
      children: [
        Image.asset(
          ImageAsset.LANGUAGE_BACKGROUND,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.current.selectLanguage,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 24,
                        color: Color.fromARGB(209, 63, 63, 63),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 40),
                _LanguageCard(
                  widget: widget,
                  myLocale: myLocale,
                ),
                _ContinueButton(widget: widget, myLocale: myLocale),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({
    required this.widget,
    required this.myLocale,
  });

  final ChooseLocalScreen widget;
  final Locale myLocale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff03816A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Text(
                S.current.continueWord,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Color(0xffFFE9D1),
                    ),
              ),
            ),
          ),
          onPressed: () {
            widget._localizationService.setLanguage(myLocale.languageCode);
            Navigator.of(context).pushNamedAndRemoveUntil(
                SplashRoutes.SPLASH_SCREEN, (route) => false);
          },
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.widget,
    required this.myLocale,
  });

  final ChooseLocalScreen widget;
  final Locale myLocale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.7,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xffFFE9D1),
      ),
      child: SizedBox(
        height: 172,
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
                flex: 6,
                child: Container(
                  color: Color(0xff03816A),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectableItem<Locale>(
                          onTap: () {
                            widget._localizationService.setLanguage('ar');
                          },
                          value: Locale('ar'),
                          selectedValue: myLocale,
                          title: S.current.arabic,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectableItem<Locale>(
                          onTap: () {
                            widget._localizationService.setLanguage('en');
                          },
                          value: Locale('en'),
                          selectedValue: myLocale,
                          title: S.current.english,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  SvgAsset.LanguageSVG,
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
