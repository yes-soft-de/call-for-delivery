// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/service/statistics_service.dart';
import 'package:c4d/module_statistics/ui/screen/statistics_screen.dart';
import 'package:c4d/module_statistics/ui/state/statisics_state/statistics_state_loaded.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class StatisticsStateManager {
  final StatisticsServiec _statisticsServiec;
  final PublishSubject<States> _stateSubject = PublishSubject();

  StatisticsStateManager(
    this._statisticsServiec,
  );

  Stream<States> get stateStream => _stateSubject.stream;

  void getStatistics(StatisticsScreenState screenState) async {
    _stateSubject.add(LoadingState(screenState));
    var value = await _statisticsServiec.getStatistics();

    if (value.hasError) {
      _stateSubject.add(StatisticsLoadedState(screenState, null, error: value.error));
    } else if (value.isEmpty) {
      // TODO: it may need to set empty to true
      _stateSubject.add(StatisticsLoadedState(screenState, null));
    } else {
      StatisticsModel statistics = value as StatisticsModel;
      _stateSubject.add(StatisticsLoadedState(screenState, statistics.data));
    }
  }
}
