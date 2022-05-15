import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/hive/order_hive_helper.dart';
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_orders/model/company_info_model.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/request/confirm_captain_location_request.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:c4d/module_orders/response/company_info_response/company_info_response.dart';
import 'package:c4d/module_orders/response/order_details_response/order_details_response.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:c4d/utils/request/rating_request.dart';
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

  Future sendOrderReportState(var orderId, bool answer) async {
    OrderHiveHelper().setConfirmOrderState(orderId, answer);
    var result = await _ordersManager.sendToRecord(orderId, answer);
    return result;
  }

  Future<DataModel> getOrderDetails(int orderId) async {
    OrderDetailsResponse? response =
        await _ordersManager.getOrderDetails(orderId);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    var location = await DeepLinksService.defaultLocation();
    return OrderDetailsModel.withData(response, location);
  }

  Future<DataModel> getCompanyInfo() async {
    CompanyInfoResponse? response = await _ordersManager.getCompanyInfo();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return CompanyInfoModel.withData(response);
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

  Future<DataModel> removeOrderSub(OrderNonSubRequest request) async {
    ActionResponse? response = await _ordersManager.removeOrderSub(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    await FireStoreHelper().insertWatcher();
    return DataModel.empty();
  }

  Future<DataModel> addNewOrderLink(CreateOrderRequest request) async {
    ActionResponse? response = await _ordersManager.addNewOrderLink(request);
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
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    await FireStoreHelper().insertWatcher();
    return DataModel.empty();
  }

  Future<DataModel> ratingCaptain(RatingRequest request) async {
    ActionResponse? response = await _ordersManager.ratingCaptain(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> confirmCaptainLocation(
      ConfirmCaptainLocationRequest request) async {
    ActionResponse? response =
        await _ordersManager.confirmCaptainLocation(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getHiddenOrders() async {
    OrdersResponse? response = await _ordersManager.getHiddenOrder();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderModel.withData(response);
  }
}
