import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/response/get_categories_response.dart';

class SupplierCategoryModel extends DataModel {
    int id = -1;
   String name = '';

    SupplierCategoryModel(
      {required this.id,
        required this.name,
      });
    List<SupplierCategoryModel> _categories = [];
    SupplierCategoryModel.withData(GetCategoriesResponse response) {
    var data = response.data;
    data?.forEach((element) {
      _categories.add(new SupplierCategoryModel(
          id: element.id ?? -1,
          name: element.name ?? S.current.unknown,
      ));
    });
  }
    List<SupplierCategoryModel> get data => _categories;
}