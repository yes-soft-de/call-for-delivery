import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/manager/about_manager.dart';
import 'package:c4d/module_about/model/company_info_model.dart';
import 'package:c4d/module_about/response/company_info_response/company_info_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class AboutService {
  final AboutManager _manager;
  AboutService(this._manager);

  Future<bool> isInited() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var inited = await preferences.getBool('inited');
    return inited == true;
  }

  Future<void> setInited() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('inited', true);
  }
  Future<DataModel> getCompanyInfo() async {
    CompanyInfoResponse? response = await _manager.getCompanyInfo();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return CompanyInfoModel.withData(response);
  }
}
