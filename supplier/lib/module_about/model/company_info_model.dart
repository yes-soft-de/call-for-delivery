import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_about/response/company_info_response/company_info_response.dart';
class CompanyInfoModel extends DataModel {
  String? phone;
  String? phone2;
  String? whatsapp;
  String? fax;
  String? bank;
  String? stc;
  String? email;
  CompanyInfoModel(
      {required this.bank,
      required this.email,
      required this.fax,
      required this.phone,
      required this.phone2,
      required this.stc,
      required this.whatsapp});

  late CompanyInfoModel _info;

  CompanyInfoModel.withData(CompanyInfoResponse response) {
    var element = response.data;
    _info = CompanyInfoModel(
        bank: element?.bankName,
        email: element?.email,
        fax: element?.fax,
        phone: element?.phone,
        phone2: element?.phoneTwo,
        stc: element?.stc,
        whatsapp: element?.whatsapp);
  }

  CompanyInfoModel get data => _info;
}
