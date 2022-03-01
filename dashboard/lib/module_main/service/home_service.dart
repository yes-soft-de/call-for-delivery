import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_main/manager/home_manager.dart';
import 'package:c4d/module_main/model/report_model.dart';
import 'package:c4d/module_main/response/report_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';

@injectable
class HomeService {
  final HomeManager _homeManager;

  HomeService(this._homeManager);

  Future<DataModel> getReport() async {
    ReportResponse? _storesResponse = await _homeManager.getReport();
    if (_storesResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storesResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storesResponse.statusCode));
    }
    if (_storesResponse.data == null) return DataModel.empty();
    return ReportModel.withData(_storesResponse.data!);
  }
}
