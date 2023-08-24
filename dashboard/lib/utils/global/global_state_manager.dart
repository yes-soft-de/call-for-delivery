import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_captain/ui/screen/captains_list_screen.dart';
import 'package:c4d/module_captain/ui/screen/in_active_captains_screen.dart';
import 'package:c4d/module_orders/orders_module.dart';
import 'package:c4d/module_stores/stores_module.dart';
import 'package:c4d/module_stores/ui/screen/stores_screen.dart';
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
    _stateSubject.add(CaptainsScreen());
  }

  void goToInActiveCaptain() {
    _stateSubject.add(InActiveCaptainsScreen());
  }

  void goToStores() {
    _stateSubject.add(StoresScreen());
  }

  void goToInActiveStores() {
    _stateSubject.add(getIt<StoresModule>().storesInActiveScreen);
  }
}
