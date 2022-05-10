import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_orders/model/captain_cash_orders_finance.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/model/store_cash_orders_finance.dart';
import 'package:c4d/module_orders/request/captain_cash_finance_request.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/request/store_cash_finance_request.dart';
import 'package:c4d/module_orders/response/orders_cash_finances_for_captain_response/orders_cash_finances_for_captain_response.dart';
import 'package:c4d/module_orders/response/orders_cash_finances_for_store_response/orders_cash_finances_for_store_response.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersService {
  final OrdersManager _ordersManager;
  OrdersService(this._ordersManager);

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

  Future<DataModel> getOrderCashFinancesForStore(
      StoreCashFinanceRequest request) async {
    OrdersCashFinancesForStoreResponse? response =
        await _ordersManager.getOrderCashFinancesForStore(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return StoreCashOrdersFinanceModel.withData(response);
  }

  Future<DataModel> getOrderCashFinancesForCaptain(
      CaptainCashFinanceRequest request) async {
    OrdersCashFinancesForCaptainResponse? response =
        await _ordersManager.getOrderCashFinancesForCaptain(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return CaptainCashOrdersFinanceModel.withData(response);
  }
}
