import 'package:c4d/module_profile/repository/profile/profile.repository.dart';
import 'package:c4d/module_profile/response/get_categories_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoryManager {
  final ProfileRepository _repository;

  CategoryManager(
      this._repository,
      );

  Future<GetCategoriesResponse?> getCategories() => _repository.getCategories();
}