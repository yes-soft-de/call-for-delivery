import 'package:c4d/module_external_delivery_companies/manager/module_external_delivery_companies_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExternalDeliveryCompaniesService {
  final ExternalDeliveryCompaniesManager _manager;

  ExternalDeliveryCompaniesService(this._manager);
}
