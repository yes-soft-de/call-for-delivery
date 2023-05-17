import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_captain/captains_module.dart';
import 'package:c4d/module_orders/orders_module.dart';
import 'package:c4d/module_stores/stores_module.dart';
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

  void goToCaptains() {
    _stateSubject.add(getIt<CaptainsModule>().captainsScreen);
  }

  void goToInActiveCaptain() {
    _stateSubject.add(getIt<CaptainsModule>().inActiveCaptains);
  }

  void goToStores() {
    _stateSubject.add(getIt<StoresModule>().storesScreen);
  }

  void goToInActiveStores() {
    _stateSubject.add(getIt<StoresModule>().storesInActiveScreen);
  }
}
