import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_external_delivery_companies/model/company.dart';
import 'package:c4d/module_external_delivery_companies/service/module_external_delivery_companies_service.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_delivery_companies_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/state/external_delivery_companies_state_loaded.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class ExternalDeliveryCompaniesStateManager {
  final ExternalDeliveryCompaniesService _service;
  final PublishSubject<States> _stateSubject = PublishSubject();

  ExternalDeliveryCompaniesStateManager(this._service);

  Stream<States> get stateStream => _stateSubject.stream;

  void getExternalCompanies(ExternalDeliveryCompaniesScreenState screenState) {
    var companies = [
      Company(id: 1, name: 'مرسول', isActive: true),
      Company(id: 2, name: 'طلباتي', isActive: false),
      Company(id: 3, name: 'وصللي', isActive: true),
      Company(id: 4, name: 'مرسول', isActive: true),
      Company(id: 5, name: 'طلباتي', isActive: false),
      Company(id: 6, name: 'وصللي', isActive: true),
    ];

    _stateSubject
        .add(ExternalDeliveryCompaniesStateLoaded(screenState, companies));
  }
}
