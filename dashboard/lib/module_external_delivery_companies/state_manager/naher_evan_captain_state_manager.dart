import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/naher_evan_captain_model.dart';
import 'package:c4d/module_external_delivery_companies/request/naher_evan_captain_request/naher_evan_captain_request.dart';
import 'package:c4d/module_external_delivery_companies/service/external_delivery_companies_service.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/naher_evan_captain_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/state/naher_evan_captain_state_loaded.dart';
import 'package:injectable/injectable.dart';

@injectable
class NaherEvanCaptainStateManger extends StateManagerHandler {
  final ExternalDeliveryCompaniesService _service;

  NaherEvanCaptainStateManger(this._service);

  Stream<States> get stateStream => stateSubject.stream;

  void getNaherEvanCaptain(
      NaherEvanCaptainScreenState screenState, NaherEvanCaptainRequest request,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _service.getNaherEvanCaptain(request).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getNaherEvanCaptain(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getNaherEvanCaptain(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as NaherEvanCaptainModel;
        stateSubject.add(NaherEvanCaptainStateLoaded(screenState, value.data));
      }
    });
  }
}
