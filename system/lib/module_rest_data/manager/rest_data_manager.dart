import 'package:c4d/module_rest_data/repository/rest_data_repository.dart';
import 'package:c4d/module_rest_data/response/rest_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class RestDataManager {

  final RestDataRepository _storesRepository;

  RestDataManager(this._storesRepository);

  Future<RestDataResponse?> restData() => _storesRepository.restData();

}