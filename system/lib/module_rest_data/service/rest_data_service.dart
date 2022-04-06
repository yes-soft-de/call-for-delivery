import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_check_api/manager/check_api_manager.dart';
import 'package:c4d/module_check_api/model/check_api_model.dart';
import 'package:c4d/module_check_api/response/check_api.dart';
import 'package:c4d/module_rest_data/manager/rest_data_manager.dart';
import 'package:c4d/module_rest_data/response/rest_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';

@injectable
class RestDataService {
  final RestDataManager _manager;

  RestDataService(this._manager);

  Future<DataModel> restData() async {
    RestDataResponse? response = await _manager.restData();

    if (response == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }
}