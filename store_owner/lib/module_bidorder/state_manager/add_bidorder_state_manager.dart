import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/branches_routes.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_bidorder/model/order/order_model.dart';
import 'package:c4d/module_bidorder/model/supplier_model/supplier_category_model.dart';
import 'package:c4d/module_bidorder/request/add_bidorder_request.dart';
import 'package:c4d/module_bidorder/request/filter_bidorder_request.dart';
import 'package:c4d/module_bidorder/service/bidorder_service.dart';
import 'package:c4d/module_bidorder/ui/screens/add_bidorder_screen.dart';
import 'package:c4d/module_bidorder/ui/screens/open_bidorder_screen.dart';
import 'package:c4d/module_bidorder/ui/states/add_bidorder/init_add_bidorder_state.dart';
import 'package:c4d/module_bidorder/ui/states/open_order_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class AddBidOrderStateManager {
  final BidOrderService _ordersService;

  final PublishSubject<States> _stateSubject = new PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  AddBidOrderStateManager(this._ordersService);


  void getBranches(AddBidOrderScreenState screenState) {
    getIt<BranchesListService>().getBranches().then((branches) {
      if (branches.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getBranches(screenState);
        }, title: '', error: branches.error, hasAppbar: false));
      } else if (branches.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          Navigator.of(screenState.context)
              .pushReplacementNamed(BranchesRoutes.BRANCHES_LIST_SCREEN);
        },
            title: '',
            buttonLabel: S.current.branchManagement,
            emptyMessage: S.current.thereIsNoBranches,
            hasAppbar: false));
      } else {
        branches as BranchesModel;
        _ordersService.getSupplierCategories().then((categories) {
          if(categories.hasError){
            _stateSubject.add(ErrorState(screenState, onPressed: () {
              getBranches(screenState);
            }, title: '', error: branches.error, hasAppbar: false));
          }else {
            categories as SupplierCategoriesModel;
            _stateSubject.add(NewBidOrderStateLoaded(branches.data,categories.data, screenState));
          }
        });

      }
    });
  }
//
  void createOrder(
      AddBidOrderScreenState screenState, AddBidOrderRequest request,{
      required  List<BranchesModel> branches,
    required List<SupplierCategoriesModel> categories}) {
    _stateSubject.add(LoadingState(screenState));
    _ordersService.addBidOrder(request).then((value) {
      if (value.hasError) {
//        _stateSubject.add(NewBidOrderStateLoaded(branches,categories, screenState));
        Navigator.pop(screenState.context);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
//        _stateSubject.add(NewBidOrderStateLoaded(branches,categories, screenState));
        Navigator.pop(screenState.context);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.orderCreatedSuccessfully)
            .show(screenState.context);
      }
    });
  }

}
