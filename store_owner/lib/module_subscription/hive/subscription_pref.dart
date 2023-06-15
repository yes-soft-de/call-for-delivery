import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubscriptionPref {
  var box = Hive.box('Subscription');

  void setIsOldSubscriptionPlan(bool isOldSubscriptionPlan) {
    box.put('IsOldSubscriptionPlan', isOldSubscriptionPlan);
  }

  /// if there no value the default will be old plan 
  bool getIsOldSubscriptionPlan() {
    var v = box.get('IsOldSubscriptionPlan');
    if (v is bool) return v;
    return true;
  }
}
