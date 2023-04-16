import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_orders/orders_module.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
@injectable
class GlobalStateManager {
  final PublishSubject _stateSubject = PublishSubject();
  Stream get stateStream => _stateSubject.stream;

  void updateList() {
    _stateSubject.add(DateTime.now().toString());
  }

  void goToNonDeliveredOrder() {
    _stateSubject.add(getIt<OrdersModule>().pendingScreen);
  }
}
