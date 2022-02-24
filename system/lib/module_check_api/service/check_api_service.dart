import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_check_api/manager/check_api_manager.dart';
import 'package:c4d/module_check_api/model/check_api_model.dart';
import 'package:c4d/module_check_api/response/check_api.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckApiService {
  final CheckApiManager _checkApiManager;

  CheckApiService(this._checkApiManager);

  Future<DataModel> checkApiHealth() async {
    CheckApiResponse? _checkApiResponse = await _checkApiManager.checkApiHealth();

    if (_checkApiResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_checkApiResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_checkApiResponse.statusCode));
    }
//    if (_checkApiResponse.data == null) return DataModel.withError(_error);
    return CheckApiModel.withData(_checkApiResponse.data!);
  }
}