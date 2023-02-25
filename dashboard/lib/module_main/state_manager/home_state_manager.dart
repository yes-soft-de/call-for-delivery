import 'package:c4d/module_main/model/statistics_model.dart';
import 'package:c4d/module_main/sceen/home_state/new_home_state.dart';
import 'package:c4d/module_main/sceen/new_home_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_main/model/report_model.dart';
import 'package:c4d/module_main/sceen/home_screen.dart';
import 'package:c4d/module_main/sceen/home_state/home_state_loaded.dart';
import 'package:c4d/module_main/service/home_service.dart';

@injectable
class HomeStateManager {
  final HomeService _homeService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  HomeStateManager(this._homeService);

  void getReport(HomeScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _homeService.getReport().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(HomeLoadedState(screenState, null, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(HomeLoadedState(screenState, null, null));
      } else {
        ReportModel data = value as ReportModel;
        _stateSubject.add(HomeLoadedState(screenState, data, null));
      }
    });
  }

  void getStatistics(HomeScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _homeService.getStatistics().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(HomeLoadedState(screenState, null, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(HomeLoadedState(screenState, null, null));
      } else {
        StatisticsModel data = value as StatisticsModel;
        _stateSubject.add(HomeLoadedState(screenState, null, data.data));
      }
    });
  }

  void getNewStatistics(NewHomeScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _homeService.getStatistics().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            NewHomeLoadedState(screenState, null, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(NewHomeLoadedState(screenState, null, null));
      } else {
        StatisticsModel data = value as StatisticsModel;
        _stateSubject.add(NewHomeLoadedState(screenState, null, data.data));
      }
    });
  }
}
