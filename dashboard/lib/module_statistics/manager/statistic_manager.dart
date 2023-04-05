import 'package:c4d/module_statistics/repository/statistics_repository.dart';
import 'package:c4d/module_statistics/response/statistics_response/statistics_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class StatisticManager {
  StatisticsRepository _statisticsRepository;

  StatisticManager(
    this._statisticsRepository,
  );

  Future<StatisticsResponse?> getStatistics() =>
      _statisticsRepository.getStatistics();
}
