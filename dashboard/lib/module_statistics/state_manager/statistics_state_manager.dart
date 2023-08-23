// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/service/statistics_service.dart';
import 'package:c4d/module_statistics/ui/screen/statistics_screen.dart';
import 'package:c4d/module_statistics/ui/state/statistics_state/statistics_state_loaded.dart';
import 'package:injectable/injectable.dart';

@injectable
class StatisticsStateManager extends StateManagerHandler {
  final StatisticsService _statisticsService;

  StatisticsStateManager(
    this._statisticsService,
  );

  Stream<States> get stateStream => stateSubject.stream;

  void getStatistics(StatisticsScreenState screenState) async {
    stateSubject.add(LoadingState(screenState));
    var value = await _statisticsService.getStatistics();

    if (value.hasError) {
      stateSubject
          .add(StatisticsLoadedState(screenState, null, error: value.error));
    } else if (value.isEmpty) {
      stateSubject.add(StatisticsLoadedState(screenState, null));
    } else {
      StatisticsModel statistics = value as StatisticsModel;
      stateSubject.add(StatisticsLoadedState(screenState, statistics.data));
    }
  }
}
