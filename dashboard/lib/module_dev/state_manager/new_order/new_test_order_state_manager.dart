import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_dev/request/create_test_order_request.dart';
import 'package:c4d/module_dev/service/orders/dev.service.dart';
import 'package:c4d/module_dev/ui/screens/new_test_order/new_test_order_screen.dart';
import 'package:c4d/module_dev/ui/state/new_order/new_test_order.state.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class NewTestOrderStateManager {
  final DevService _devService;
  final PublishSubject<States> _stateSubject = new PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;
  NewTestOrderStateManager(this._devService);
  void getStores(NewTestOrderScreenState screenState) {
    getIt<StoresService>().getStores().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getStores(screenState);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getStores(screenState);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as StoresModel;
        _stateSubject
            .add(NewTestOrderStateBranchesLoaded(value.data, [], screenState));
      }
    });
  }

  void getBranches(NewTestOrderScreenState screenState, int storeID,
      List<StoresModel> stores) {
    getIt<BranchesListService>().getBranches(storeID.toString()).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            ;
        _stateSubject
            .add(NewTestOrderStateBranchesLoaded(stores, [], screenState));
      } else if (value.isEmpty) {
        _stateSubject
            .add(NewTestOrderStateBranchesLoaded(stores, [], screenState));
      } else {
        value as BranchesModel;
        _stateSubject.add(
            NewTestOrderStateBranchesLoaded(stores, value.data, screenState));
      }
    });
  }

  void createOrder(
      NewTestOrderScreenState screenState, CreateTestOrderRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _devService.createOrder(request).then((value) {
      if (value.hasError) {
        screenState.clear();
        getStores(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            ;
      } else {
        screenState.clear();
        getStores(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.orderCreatedSuccessfully)
            ;
        FireStoreHelper().backgroundThread('Trigger');
      }
    });
  }
}
