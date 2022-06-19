import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/balance_status.dart';
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart';
import 'package:c4d/module_orders/hive/order_hive_helper.dart';
import 'package:c4d/module_subscription/response/can_make_order_response/can_make_order_response.dart';
import 'package:c4d/utils/helpers/subscription_status_helper.dart';

class CanMakeOrderModel extends DataModel {
  late bool canCreateOrder;
  late String status;
  late String percentageOfOrdersConsumed;
  late bool consumingAlert;
  late bool unlimitedPackage;
  CanMakeOrderModel(
      {required this.canCreateOrder,
      required this.status,
      required this.percentageOfOrdersConsumed,
      required this.consumingAlert,
      required this.unlimitedPackage});

  late CanMakeOrderModel _model;

  CanMakeOrderModel.withData(CanMakeOrderResponse response) {
    var data = response.data;
    _model = CanMakeOrderModel(
        canCreateOrder: data?.canCreateOrder ?? true,
        status: data?.subscriptionStatus ?? 'inactive',
        percentageOfOrdersConsumed: data?.percentageOfOrdersConsumed ?? '0%',
        consumingAlert: false,
        unlimitedPackage:
            data?.packageName == 'الباقة الذهبية Ultimate' ? true : false);
    // alert detect
    var total = _model.percentageOfOrdersConsumed.replaceAll('%', ' ').trim();
    var totalOrder = num.tryParse(total)?.toInt() ?? 0;
    var alert = false;
    if (totalOrder >= 80) {
      _model.percentageOfOrdersConsumed = '80%';
      totalOrder = 80;
      alert = _subscriptionAlert(totalOrder);
    } else if (totalOrder >= 75) {
      totalOrder = 75;
      alert = _subscriptionAlert(totalOrder);
      _model.percentageOfOrdersConsumed = '75%';
    } else if (totalOrder >= 40.0) {
      totalOrder = 40;
      alert = _subscriptionAlert(totalOrder);
      _model.percentageOfOrdersConsumed = '40%';
    } else if (totalOrder >= 35.0) {
      totalOrder = 35;
      alert = _subscriptionAlert(totalOrder);
      _model.percentageOfOrdersConsumed = '35%';
    } else {
      alert = _subscriptionAlert(totalOrder);
    }
    _model.consumingAlert = alert;
  }
  bool _subscriptionAlert(num percent) {
    var user = AuthPrefsHelper().getUsername();
    var box = OrderHiveHelper().box;
    if (percent < 35) {
      box.delete('$user consumed 80%');
      box.delete('$user consumed 75%');
      box.delete('$user consumed 40%');
      box.delete('$user consumed 35%');
      return false;
    }
    bool seen = box.get('$user consumed $percent%') ?? false;
    if (!seen) {
      box.put('$user consumed $percent%', true);
      return true;
    }
    return false;
  }

  CanMakeOrderModel get data => _model;
}
