import 'package:c4d/module_main/response/statistics_response/statistics_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_main/repository/home_repository.dart';
import 'package:c4d/module_main/response/report_response.dart';

@injectable
class HomeManager {
  final HomeRepository _homeRepository;

  HomeManager(this._homeRepository);

  Future<ReportResponse?> getReport() => _homeRepository.getReport();
  Future<StatisticsResponse?> getStatistics() =>
      _homeRepository.getStatistics();
}
