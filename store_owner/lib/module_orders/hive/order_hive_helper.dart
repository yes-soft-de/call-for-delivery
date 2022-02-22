import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderHiveHelper {
  var box = Hive.box('Order');

  bool getConfirmOrderState(var orderId) {
    var confirm = box.get('captain is in store owner for order $orderId');
    return confirm == null;
  }

  void setConfirmOrderState(var orderId, bool answar) {
   box.put(
        'captain is in store owner for order $orderId', answar);
  }

}
