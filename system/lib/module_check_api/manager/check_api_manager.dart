import 'package:c4d/module_check_api/repository/check_api_repository.dart';
import 'package:c4d/module_check_api/response/check_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckApiManager {

  final CheckApiRepository _storesRepository;

  CheckApiManager(this._storesRepository);

  Future<CheckApiResponse?> checkApiHealth() => _storesRepository.checkApiHealth();

}