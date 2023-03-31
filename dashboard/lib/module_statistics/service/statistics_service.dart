// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/manager/statistic_manager.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/response/statistics_response/statistics_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';

@injectable
class StatisticsServiec {
  final StatisticManager _statisticManager;

  StatisticsServiec(
    this._statisticManager,
  );

  Future<DataModel> getStatistics() async {
    StatisticsResponse? response = await _statisticManager.getStatistics();

    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200')
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(response.statusCode));

    // TODO: data before datum
    if (response.data == null) return DataModel.empty();

    return StatisticsModel.withData(response);
  }
}
