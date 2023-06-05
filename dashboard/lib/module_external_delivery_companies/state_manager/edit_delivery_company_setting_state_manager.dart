import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_external_delivery_companies/service/external_delivery_companies_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class EditDeliveryCompanySettingScreenStateManager {
  final ExternalDeliveryCompaniesService _service;
  final PublishSubject<States> _stateSubject = PublishSubject();

  EditDeliveryCompanySettingScreenStateManager(this._service);

  Stream<States> get stateStream => _stateSubject.stream;
}
