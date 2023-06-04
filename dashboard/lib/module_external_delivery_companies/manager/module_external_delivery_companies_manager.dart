import 'package:c4d/module_external_delivery_companies/repository/module_external_delivery_companies_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExternalDeliveryCompaniesManager {
  final ExternalDeliveryCompaniesRepository _repository;

  ExternalDeliveryCompaniesManager(this._repository);
}
