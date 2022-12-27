import 'package:c4d/module_supplier/manager/supplier_manager.dart';
import 'package:c4d/module_supplier/model/ads_model.dart';
import 'package:c4d/module_supplier/model/inActiveModel.dart';
import 'package:c4d/module_supplier/model/porfile_model.dart';
import 'package:c4d/module_supplier/model/supplier_need_support.dart';
import 'package:c4d/module_supplier/request/enable_supplier.dart';
import 'package:c4d/module_supplier/request/filter_supplier_ads.dart';
import 'package:c4d/module_supplier/request/update_supplier_request.dart';
import 'package:c4d/module_supplier/response/in_active_supplier_response.dart';
import 'package:c4d/module_supplier/response/supplier_ads_response/ads_response.dart';
import 'package:c4d/module_supplier/response/supplier_profile_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';

import '../response/supplier_need_support_response/supplier_need_support_response.dart';

@injectable
class SupplierService {
  final SuppliersManager _manager;

  SupplierService(this._manager);

  Future<DataModel> updateSupplier(UpdateSupplierRequest request) async {
    ActionResponse? actionResponse = await _manager.updateSupplier(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> enableSupplier(EnableSupplierRequest request) async {
    ActionResponse? actionResponse = await _manager.enableSupplier(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getSuppliers() async {
    SupplierResponse? _ordersResponse = await _manager.getSuppliers();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return InActiveModel.withData(_ordersResponse.data!);
  }

  Future<DataModel> getInActiveSupplier() async {
    SupplierResponse? _ordersResponse = await _manager.getInActiveSupplier();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return InActiveModel.withData(_ordersResponse.data!);
  }

  Future<DataModel> getSupplierProfile(int id) async {
    SupplierProfileResponse? _storeResponse =
        await _manager.getSupplierProfile(id);
    if (_storeResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storeResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storeResponse.statusCode));
    }
    if (_storeResponse.data == null) return DataModel.empty();
    return ProfileSupplierModel.withData(_storeResponse.data!);
  }

  Future<DataModel> getSupplierSupport() async {
    SupplierNeedSupportResponse? _clients = await _manager.getSupplierSupport();
    if (_clients == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_clients.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_clients.statusCode));
    }
    if (_clients.data == null) return DataModel.empty();
    return SupplierNeedSupportModel.withData(_clients.data!);
  }

  Future<DataModel> getSupplierAds(FilterSupplierAds request) async {
    AdsResponse? _response = await _manager.getSupplierAds(request);
    if (_response == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_response.statusCode));
    }
    if (_response.data == null) return DataModel.empty();
    return SupplierAdsModel.withData(_response);
  }
}
