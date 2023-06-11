import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_external_delivery_companies/response/delivery_companies_response/delivery_companies_response.dart';

class CompanyModel extends DataModel {
  late int id;
  late String name;
  late bool isActive;

  CompanyModel({required this.id, required this.name, required this.isActive});

  CompanyModel.empty()
      : id = -1,
        name = '',
        isActive = false;

  late List<CompanyModel> _companies = [];

  CompanyModel.withData(DeliveryCompaniesResponse response) {
    var data = response.data;

    data?.forEach(
      (element) {
        _companies.add(CompanyModel(
          id: element.id ?? -1,
          name: element.companyName ?? '',
          isActive: element.status ?? false,
        ));
      },
    );
  }

  List<CompanyModel> get data => _companies;
}
