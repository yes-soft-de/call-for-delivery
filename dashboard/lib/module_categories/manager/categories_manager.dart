import 'package:c4d/module_categories/request/active_package_request.dart';
import 'package:c4d/module_categories/request/package_category_request.dart';
import 'package:c4d/module_categories/request/package_request.dart';
import 'package:c4d/module_categories/response/package_response.dart';
import 'package:c4d/module_stores/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_categories/repository/categories_repository.dart';
import 'package:c4d/module_categories/response/package_category_response.dart';

@injectable
class CategoriesManager {
  final CategoriesRepository _categoriesRepository;

  CategoriesManager(this._categoriesRepository);



  Future<PackageCategoryResponse?> getCategories() =>
      _categoriesRepository.getPackagesCategories();

  Future<ActionResponse?> createCategory(PackageCategoryRequest request) =>
      _categoriesRepository.addCategory(request);

  Future<ActionResponse?> updateCategory(
      PackageCategoryRequest request) =>
      _categoriesRepository.updateCategory(request);


  Future<ActionResponse?> updatePackage(
      PackageRequest request) =>
      _categoriesRepository.updatePackage(request);

  Future<PackagesResponse?> getPackagesByCategory(int id) =>
      _categoriesRepository.getPackageByCategory(id);

  Future<ActionResponse?> createPackage(PackageRequest request) =>
      _categoriesRepository.addPackage(request);

  Future<ActionResponse?> enablePackage(ActivePackageRequest request) =>
      _categoriesRepository.enablePackage(request);

  Future<ActionResponse?> deleteCategories(String id) =>
      _categoriesRepository.deleteCategories(id);

}
