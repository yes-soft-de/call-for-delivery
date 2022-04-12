import 'package:c4d/module_supplier_categories/repository/categories_repository.dart';
import 'package:c4d/module_supplier_categories/request/active_category_request.dart';
import 'package:c4d/module_supplier_categories/request/supplier_category_request.dart';
import 'package:c4d/module_supplier_categories/response/supplier_category_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class SupplierCategoriesManager {
  final SupplierCategoriesRepository _categoriesRepository;

  SupplierCategoriesManager(this._categoriesRepository);

  Future<SupplierCategoryResponse?> getCategories() =>
      _categoriesRepository.getCategories();

  Future<ActionResponse?> createCategory(SupplierCategoryRequest request) =>
      _categoriesRepository.addCategory(request);

  Future<ActionResponse?> updateCategory(SupplierCategoryRequest request) =>
      _categoriesRepository.updateCategory(request);

  Future<ActionResponse?> enableCategory(ActiveCategoryRequest request) =>
      _categoriesRepository.enableCategory(request);

  Future<ActionResponse?> deleteCategories(String id) =>
      _categoriesRepository.deleteCategories(id);
}
