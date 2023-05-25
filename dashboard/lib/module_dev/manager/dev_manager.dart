import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/module_dev/repository/dev_repository.dart';
import 'package:c4d/module_dev/request/create_test_order_request.dart';
import 'package:injectable/injectable.dart';

@injectable
class DevManager {
  final DevRepository _repository;

  DevManager(
    this._repository,
  );
  Future<ActionResponse?> createOrder(CreateTestOrderRequest request) =>
      _repository.createOrder(request);
}
