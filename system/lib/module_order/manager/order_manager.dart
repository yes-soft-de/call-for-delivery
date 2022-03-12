import 'package:c4d/module_order/repository/order_repository.dart';
import 'package:c4d/module_order/request/order_state_request.dart';
import 'package:c4d/module_users/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersManager {

  final OrdersRepository _repository;

  OrdersManager(this._repository);

  Future<ActionResponse?> updateStatus(UpdateOrderStateRequest request) => _repository.updateStatus(request);

}