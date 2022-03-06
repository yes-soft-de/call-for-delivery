import 'package:c4d/module_categories/model/packages_model.dart';
import 'package:c4d/module_categories/request/active_package_request.dart';
import 'package:c4d/module_categories/request/package_category_request.dart';
import 'package:c4d/module_categories/request/package_request.dart';
import 'package:c4d/module_categories/response/package_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/manager/categories_manager.dart';

import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_categories/response/package_category_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';

@injectable
class CategoriesService {
  final CategoriesManager _categoriesManager;

  CategoriesService(this._categoriesManager);

  Future<DataModel> getCategories() async {
    PackageCategoryResponse? _ordersResponse =
        await _categoriesManager.getCategories();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return PackagesCategoryModel.withData(_ordersResponse.data!);
  }
  Future<DataModel> createCategory(PackageCategoryRequest request) async {
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
  Future<DataModel> updateCategory(
      PackageCategoryRequest request) async {
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

  Future<DataModel> updatePackage(
      PackageRequest request) async {
    ActionResponse? actionResponse =
    await _categoriesManager.updatePackage(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getPackagesByCategory(int id) async {
    PackagesResponse? _productCategories =
        await _categoriesManager.getPackagesByCategory(id);
    if (_productCategories == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_productCategories.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _productCategories.statusCode));
    }
    if (_productCategories.data == null) return DataModel.empty();

    return PackagesModel.withData(_productCategories.data!);
  }
  Future<DataModel> createPackage(PackageRequest request) async {
    ActionResponse? actionResponse =
    await _categoriesManager.createPackage(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> enablePackage(ActivePackageRequest request) async {
    ActionResponse? actionResponse = await _categoriesManager.enablePackage(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }


  Future<DataModel> deleteCategories(String id) async {
    ActionResponse? actionResponse =
        await _categoriesManager.deleteCategories(id);
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

}
