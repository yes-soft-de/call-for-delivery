import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/manager/category/category_manager.dart';
import 'package:c4d/module_profile/model/category_model/category_model.dart';
import 'package:c4d/module_profile/response/get_categories_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoryService {
  final CategoryManager _manager;

  CategoryService(
      this._manager,
      );
  Future<DataModel> getCategories() async {
    GetCategoriesResponse? response = await _manager.getCategories();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) {
      return DataModel.empty();
    }
    return SupplierCategoryModel.withData(response);
  }
}