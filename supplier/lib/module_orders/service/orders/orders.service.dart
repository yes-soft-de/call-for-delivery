import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:c4d/utils/response/action_response.dart';
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

  Future<DataModel> getMyOrdersFilter(FilterOrderRequest request) async {
    OrdersResponse? response = await _ordersManager.getMyOrdersFilter(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderModel.withData(response);
  }


//  Future<DataModel> getOrderDetails(int orderId) async {
//    OrderDetailsResponse? response =
//        await _ordersManager.getOrderDetails(orderId);
//    if (response == null) return DataModel.withError(S.current.networkError);
//    if (response.statusCode != '200') {
//      return DataModel.withError(
//          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
//    }
//    if (response.data == null) return DataModel.empty();
//    var location = await DeepLinksService.defaultLocation();
//    return OrderDetailsModel.withData(response, location);
//  }



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
