import 'dart:isolate';

import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:c4d/module_orders/model/roomId/room_id_model.dart';
import 'package:c4d/module_orders/request/add_extra_distance_request.dart';
import 'package:c4d/module_orders/request/cancel_order_request.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:c4d/module_orders/response/enquery_response/enquery_response.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:c4d/module_orders/response/order_details_response/order_details_response.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_orders/model/order/action_state_model.dart';
import 'package:c4d/module_orders/model/order/order_details_model.dart';
import 'package:c4d/module_orders/model/order/order_logs.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/response/company_info/company_info.dart';
import 'package:c4d/module_orders/response/order_status/order_action_response.dart';
import 'package:c4d/module_orders/response/orders_logs_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:translator/translator.dart';

@injectable
class OrdersService {
  final OrdersManager _ordersManager;

  OrdersService(this._ordersManager);

//////////////////////////////////////////////////////////////////////

  Future<DataModel> getMyOrdersFilter(FilterOrderRequest request) async {
    OrdersResponse? response = await _ordersManager.getMyOrdersFilter(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200' && response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderModel.withData(response);
  }

  Future<DataModel> getOrderDetails(int orderId) async {
    OrderDetailsResponse? _ordersResponse =
        await _ordersManager.getOrderDetails(orderId);
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    if (_ordersResponse.data?.note != null) {
      _ordersResponse.data?.note =
          await translateService(_ordersResponse.data!.note!);
    }
    // var currentLocation = await DeepLinksService.defaultLocation();
    return OrderDetailsModel.withData(_ordersResponse);
  }

  Future<DataModel> getNearbyOrders() async {
    OrdersResponse? response = await _ordersManager.getNearbyOrders();
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    }
    String code = response.statusCode.toString();
    if (code != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(code));
    }
    if (response.data == null) return DataModel.empty();
    LatLng? myLocation = await DeepLinksService.defaultLocation();
    return OrderModel.withData(response);
  }

  Future<ActionStateModel> updateOrder(UpdateOrderRequest request) async {
    OrderActionResponse? actionResponse =
        await _ordersManager.updateOrder(request);
    if (actionResponse == null) {
      return ActionStateModel.error(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return ActionStateModel.error(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return ActionStateModel.empty();
  }

  Future<ActionStateModel> updateCashStatus(UpdateOrderRequest request) async {
    OrderActionResponse? actionResponse =
        await _ordersManager.updateCashStatus(request);
    if (actionResponse == null) {
      return ActionStateModel.error(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return ActionStateModel.error(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return ActionStateModel.empty();
  }

  Future<DataModel> createChatRoom(int orderId) async {
    EnquiryResponse? actionResponse =
        await _ordersManager.createChatRoom(orderId);
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    if (actionResponse.data == null) {
      return DataModel.empty();
    }
    return RoomId.withData(actionResponse);
  }

  Future<DataModel> getCaptainOrders() async {
    OrdersResponse? response = await _ordersManager.getCaptainOrders();
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    }
    String code = response.statusCode.toString();
    if (response.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(code));
    }
    if (response.data == null) return DataModel.empty();
    return OrderModel.withData(response);
  }

  Future<DataModel> updateExtraDistanceToOrder(
      AddExtraDistanceRequest request) async {
    ActionResponse? response =
        await _ordersManager.updateExtraDistanceToOrder(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      if (response.statusCode == '405') {
        return DataModel.withError('you can edit only once');
      }

      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<OrderLogsModel> getOrdersLogs() async {
    OrdersLogsResponse? _ordersResponse = await _ordersManager.getOrdersLogs();
    if (_ordersResponse == null) {
      return OrderLogsModel.Error(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200' &&
        _ordersResponse.statusCode != '204') {
      return OrderLogsModel.Error(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return OrderLogsModel.Empty();
    return OrderLogsModel.Data(_ordersResponse);
  }

  Future<DataModel> removeOrderSub(OrderNonSubRequest request) async {
    ActionResponse? response = await _ordersManager.removeOrderSub(request);
    await FireStoreHelper().backgroundThread('Trigger');
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> cancelOrder(CancelOrderRequest request) async {
    ActionResponse? response = await _ordersManager.cancelOrder(request);
    await FireStoreHelper().backgroundThread('Trigger');
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

////////////////////////////////////////////////////////////////////////////
  Future<CompanyInfoResponse?> getCompanyInfo() async {
    CompanyInfoResponse? response = await _ordersManager.getCompanyInfo();
    if (response == null) return null;
    return response;
  }

  Future<String> translateService(String word) async {
    var reg = RegExp(
        r'[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc]');
    if (reg.hasMatch(word) &&
        getIt<LocalizationService>().getLanguage() == 'ar') {
      return word;
    }
    final translator = GoogleTranslator();
    var translation = await translator.translate(word,
        to: getIt<LocalizationService>().getLanguage());
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    print('source ${translation.source} translated to ${translation.text}');
    print(
        'source ${translation.sourceLanguage} target ${translation.targetLanguage}');
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++');

    return translation.text;
  }
}
