import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/hive/order_hive_helper.dart';
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/model/order_status_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/response/company_info/company_info.dart';
import 'package:c4d/module_orders/response/order_details/order_details_response.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:c4d/module_profile/response/order_info_respons.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersService {
  final OrdersManager _ordersManager;
  final ProfileService _profileService;

  OrdersService(this._ordersManager, this._profileService);

  Future<DataModel> getMyOrders() async {
    OrdersResponse? response = await _ordersManager.getMyOrders();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderModel.withData(response);
  }

  Future sendOrderReportState(var orderId, bool answer) async {
    OrderHiveHelper().setConfirmOrderState(orderId, answer);
    var result = await _ordersManager.sendToRecord(orderId, answer);
    return result;
  }

  Future<DataModel> getOrderDetails(int orderId) async {
    OrderStatusResponse? response =
        await _ordersManager.getOrderDetails(orderId);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderStatusModel.withData(response);
  }

  Future<DataModel> addNewOrder(CreateOrderRequest request) async {
    ActionResponse? response = await _ordersManager.addNewOrder(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    await FireStoreHelper().insertWatcher();
    return DataModel.empty();
  }

  // Future<OrderInfoRespons> getOrder(int orderId) async {
  //   Map response = await _ordersManager.getOrder(orderId);
  //   if (response == null) return null;
  //   return OrderInfoRespons.fromJson(response);
  // }

  Future<DataModel> deleteOrder(int id) async {
    ActionResponse? response = await _ordersManager.deleteOrder(id);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    await FireStoreHelper().insertWatcher();
    return DataModel.empty();
  }
}
