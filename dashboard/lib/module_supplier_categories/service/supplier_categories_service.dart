import 'package:c4d/module_supplier_categories/manager/categories_manager.dart';
import 'package:c4d/module_supplier_categories/model/supplier_categories_model.dart';
import 'package:c4d/module_supplier_categories/request/active_category_request.dart';
import 'package:c4d/module_supplier_categories/request/supplier_category_request.dart';
import 'package:c4d/module_supplier_categories/response/supplier_category_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';

@injectable
class SupplierCategoriesService {
  final SupplierCategoriesManager _categoriesManager;

  SupplierCategoriesService(this._categoriesManager);

  Future<DataModel> getCategories() async {
    SupplierCategoryResponse? _ordersResponse =
        await _categoriesManager.getCategories();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return SupplierCategoryModel.withData(_ordersResponse.data!);
  }

  Future<DataModel> createCategory(SupplierCategoryRequest request) async {
    ActionResponse? actionResponse =
        await _categoriesManager.createCategory(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateCategory(SupplierCategoryRequest request) async {
    ActionResponse? actionResponse =
        await _categoriesManager.updateCategory(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> enableCategory(ActiveCategoryRequest request) async {
    ActionResponse? actionResponse =
        await _categoriesManager.enableCategory(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
}
