import 'package:c4d/module_about/service/about_service/about_service.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:c4d/module_about/ui/states/about/about_state_request_appointment.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class AboutScreenStateManager {
  final LocalizationService _localizationService;
  final AboutService _aboutService;

  final stateStack = <AboutState>[];
  final _stateSubject = PublishSubject<AboutState>();

  Stream<AboutState> get stateStream => _stateSubject.stream;

  AboutScreenStateManager(
    this._localizationService,
    this._aboutService,
  );

  void setLanguage(String lang) {
    _localizationService.setLanguage(lang);
  }

  void requestBooking() {
   // _stateSubject.add(AboutStateRequestBooking());
  }

  void moveNext() {
      // _stateSubject.add(AboutStateLoading(this));
      // _initAccountService.getPackages().then((packages) {
      //   _stateSubject.add(AboutStatePageOwner(this, packages));
      // });
  }
  
}
