import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_orders/response/order_details_response/order_details_response.dart';
import 'package:c4d/module_stores/model/order/order_captain_not_arrived.dart';
import 'package:c4d/module_stores/model/store_need_support.dart';
import 'package:c4d/module_stores/model/stores_dues/stores_dues.dart';
import 'package:c4d/module_stores/model/top_active_store_model.dart';
import 'package:c4d/module_stores/request/active_store_request.dart';
import 'package:c4d/module_stores/request/captain_not_arrived_request.dart';
import 'package:c4d/module_stores/request/filter_store_activity_request.dart';
import 'package:c4d/module_stores/request/order_filter_request.dart';
import 'package:c4d/module_stores/request/stores_dues_request.dart';
import 'package:c4d/module_stores/response/order/order_captain_not_arrived/orders_not_arrived_response.dart';
import 'package:c4d/module_stores/response/store_need_support_response/store_need_support_response.dart';
import 'package:c4d/module_stores/response/stores_dues_response/stores_dues_response/stores_dues_response.dart';
import 'package:c4d/module_stores/response/top_active_store.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/manager/stores_manager.dart';
import 'package:c4d/module_stores/model/store_balance_model.dart';
import 'package:c4d/module_stores/model/store_profile_model.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/response/store_balance_response/store_balance_response.dart';
import 'package:c4d/module_stores/response/store_profile_response.dart';
import 'package:c4d/module_stores/response/stores_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';

import '../../module_orders/model/order/order_model.dart';
import '../../module_orders/model/order_details_model.dart';
import '../../module_orders/response/orders_response/orders_response.dart';

@injectable
class StoresService {
  final StoreManager _storeManager;
  final OrdersManager _ordersManager;

  StoresService(this._storeManager, this._ordersManager);

  Future<DataModel> getStores() async {
    StoresResponse? _storesResponse = await _storeManager.getStores();
    if (_storesResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storesResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storesResponse.statusCode));
    }
    if (_storesResponse.data == null) return DataModel.empty();
    return StoresModel.withData(_storesResponse.data!);
  }

  Future<DataModel> getStoresInActive() async {
    StoresResponse? _storesResponse = await _storeManager.getStoresInActive();
    if (_storesResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storesResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storesResponse.statusCode));
    }
    if (_storesResponse.data == null) return DataModel.empty();
    return StoresModel.withData(_storesResponse.data!);
  }

  Future<DataModel> getStoreProfile(int id) async {
    StoreProfileResponse? _storeResponse =
        await _storeManager.getStoreProfile(id);
    if (_storeResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storeResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storeResponse.statusCode));
    }
    if (_storeResponse.data == null) return DataModel.empty();
    return StoreProfileModel.withData(_storeResponse.data!);
  }

  Future<DataModel> updateStore(UpdateStoreRequest request) async {
    ActionResponse? actionResponse = await _storeManager.updateStore(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> enableStore(ActiveStoreRequest request) async {
    ActionResponse? actionResponse = await _storeManager.enableStore(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> deleteStore(int storeID) async {
    ActionResponse? actionResponse = await _storeManager.deleteStore(storeID);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getStoreBalance(int id) async {
    StoreBalanceResponse? _storeResponse =
        await _storeManager.getStoreAccountBalance(id);
    if (_storeResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storeResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storeResponse.statusCode));
    }
    if (_storeResponse.data == null) return DataModel.empty();
    return StoreBalanceModel.withData(_storeResponse.data!);
  }

  Future<DataModel> getStoreNeedSupport() async {
    StoreNeedSupportResponse? _clients = await _storeManager.getStoreSupport();
    if (_clients == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_clients.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_clients.statusCode));
    }
    if (_clients.data == null) return DataModel.empty();
    return StoresNeedSupportModel.withData(_clients.data!);
  }

  Future<DataModel> getOrdersNotArrivedCaptainFilter(
      FilterOrderCaptainNotArrivedRequest request) async {
    OrderCaptainResponse? response =
        await _storeManager.getOrdersNotArrivedCaptainFilter(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderCaptainNotArrivedModel.withData(response);
  }

  Future<DataModel> getStoreOrdersFilter(FilterOrderRequest request) async {
    OrdersResponse? response =
        await _storeManager.getStoreOrdersFilter(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderModel.withData(response);
  }

  Future<DataModel> getOrderDetails(int orderId) async {
    OrderDetailsResponse? response =
        await _storeManager.getOrderDetails(orderId);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderDetailsModel.withData(response, null);
  }

  Future<DataModel> getTopActiveStore() async {
    TopActiveStoreResponse? response = await _storeManager.getTopStoreActive();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return TopActiveStoreModel.withData(response.data!);
  }

  Future<DataModel> filterStoreActivity(
      FilterStoreActivityRequest request) async {
    TopActiveStoreResponse? response =
        await _storeManager.filterStoreActivity(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return TopActiveStoreModel.withData(response.data!);
  }

  Future<DataModel> getStoresDues(StoresDuesRequest request) async {
    StoresDuesResponse? response = await _storeManager.getStoresDues(request);

    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return StoresDuesModel.withData(response);
  }
}
