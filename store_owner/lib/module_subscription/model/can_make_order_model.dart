import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/balance_status.dart';
import 'package:c4d/module_subscription/response/can_make_order_response/can_make_order_response.dart';
import 'package:c4d/utils/helpers/subscription_status_helper.dart';

class CanMakeOrderModel extends DataModel {
  late bool canCreateOrder;
  late String status;

  CanMakeOrderModel({
    required this.canCreateOrder,
    required this.status,
  });

  late CanMakeOrderModel _model;

  CanMakeOrderModel.withData(CanMakeOrderResponse response) {
    var data = response.data;
    _model = CanMakeOrderModel(
        canCreateOrder: data?.canCreateOrder ?? true,
        status:data?.subscriptionStatus ?? 'inactive');
  }
  CanMakeOrderModel get data => _model;
}
