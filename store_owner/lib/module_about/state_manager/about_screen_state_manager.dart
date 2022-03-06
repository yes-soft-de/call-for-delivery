import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/service/about_service/about_service.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:c4d/module_about/ui/states/about/about_state_page_owner.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:c4d/module_subscription/model/packages.model.dart';
import 'package:c4d/module_subscription/response/package_categories_response/package.dart';
import 'package:c4d/module_subscription/service/subscription_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  void requestBooking() {
    // _stateSubject.add(AboutStateRequestBooking());
  }
  void getPackages(AboutScreenState screenState) async {
    getIt<SubscriptionService>().getPackages().then((value) {
      if (value.hasError) {
        Fluttertoast.showToast(msg: value.error ?? S.current.errorHappened);
      } else if (value.isEmpty) {
        Fluttertoast.showToast(msg: S.current.homeDataEmpty);
      } else {
        value as PackageModel;
        _stateSubject.add(AboutStatePageOwner(
          screenState,
          value.data,
          currentPage: 3
        ));
      }
    });
  }
}
