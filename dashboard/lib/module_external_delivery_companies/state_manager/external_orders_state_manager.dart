import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/external_order.dart';
import 'package:c4d/module_external_delivery_companies/request/external_order_request/external_orders_request.dart';
import 'package:c4d/module_external_delivery_companies/service/external_delivery_companies_service.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_orders_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/state/external_orders_state_loaded.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExternalOrdersStateManager extends StateManagerHandler {
  final ExternalDeliveryCompaniesService _service;

  ExternalOrdersStateManager(this._service);

  Stream<States> get stateStream => stateSubject.stream;

  void getPendingOrders(
      ExternalOrderScreenState screenState, ExternalOrderRequest request,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _service.getExternalOrders(request).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getPendingOrders(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getPendingOrders(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as ExternalOrder;
        stateSubject.add(ExternalOrdersLoadedState(screenState, value.data));
      }
    });
  }
}
