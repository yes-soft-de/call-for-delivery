import 'package:c4d/module_orders/ui/screens/terms/terms.dart';
import 'package:c4d/module_orders/ui/state/terms/terms_state.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class TermsStateManager {
  final ProfileService _profileService;

  TermsStateManager(this._profileService);

  final PublishSubject<TermsListState> _stateSubject =
      PublishSubject<TermsListState>();

  Stream<TermsListState> get termsStream => _stateSubject.stream;

  dispose() {
    _stateSubject.close();
  }

  void getTerms(TermsScreenState screenState) {
    _stateSubject.add(TermsListStateLoading(screenState));
    _profileService.getTerms().then((dynamic value) {
      _stateSubject.add(TermsListStateInit(value, screenState));
    });
  }
}
