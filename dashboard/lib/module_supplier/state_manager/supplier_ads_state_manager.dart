import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_supplier/model/ads_model.dart';
import 'package:c4d/module_supplier/request/filter_supplier_ads.dart';
import 'package:c4d/module_supplier/service/supplier_service.dart';
import 'package:c4d/module_supplier/ui/screen/supplier_ads_screen.dart';
import 'package:c4d/module_supplier/ui/state/supplier_ads/supplier_ads_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@injectable
class SupplierAdsStateManager {
  final SupplierService _service;

  final PublishSubject<States> _stateSubject = PublishSubject();
  SupplierAdsScreenState? _screenState;

  Stream<States> get stateStream => _stateSubject.stream;
  SupplierAdsScreenState? get state => _screenState;

  SupplierAdsStateManager(this._service);

  void getSupplierAds(
      SupplierAdsScreenState screenState, FilterSupplierAds request) {
    _stateSubject.add(LoadingState(screenState));
    _service.getSupplierAds(request).then((value) {
      if (value.hasError) {
        _stateSubject
            .add(SupplierAdsLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(
            SupplierAdsLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        SupplierAdsModel _model = value as SupplierAdsModel;
        _stateSubject.add(SupplierAdsLoadedState(screenState, _model.data));
      }
    });
  }
}
