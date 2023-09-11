import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/naher_evan_captains_model.dart';
import 'package:c4d/module_external_delivery_companies/service/external_delivery_companies_service.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/naher_evan_captains_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/state/naher_evan_captains_state_loaded.dart';
import 'package:injectable/injectable.dart';

@injectable
class NaherEvanCaptainsStateManger extends StateManagerHandler {
  final ExternalDeliveryCompaniesService _service;

  NaherEvanCaptainsStateManger(this._service);

  Stream<States> get stateStream => stateSubject.stream;

  void getNaherEvanCaptains(NaherEvanCaptainsScreenState screenState,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _service.getNaherEvanCaptains().then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getNaherEvanCaptains(screenState);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getNaherEvanCaptains(screenState);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as NaherEvanCaptainsModel;
        stateSubject.add(NaherEvanCaptainsStateLoaded(screenState, value.data));
      }
    });
  }
}
