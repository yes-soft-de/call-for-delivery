import 'package:injectable/injectable.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class AboutRepository {
  final ApiClient _apiClient;
  AboutRepository(this._apiClient);
}
