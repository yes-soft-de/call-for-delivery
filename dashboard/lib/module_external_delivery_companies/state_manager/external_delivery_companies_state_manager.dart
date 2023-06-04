import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/service/module_external_delivery_companies_service.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_delivery_companies_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class ExternalDeliveryCompaniesStateManager {
  final ExternalDeliveryCompaniesService _service;
  final PublishSubject<States> _stateSubject = PublishSubject();

  ExternalDeliveryCompaniesStateManager(this._service);

  Stream<States> get stateStream => _stateSubject.stream;

  void getExternalCompanies(ExternalDeliveryCompaniesScreenState screenState) {
    _stateSubject.add(EmptyState(
      screenState,
      onPressed: () {
        getExternalCompanies(screenState);
      },
      hasAppbar: false,
      title: '',
      emptyMessage: S.current.homeDataEmpty,
    ));
  }
}
