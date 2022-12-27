import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_main/response/statistics_response/daily.dart';
import 'package:c4d/module_main/response/statistics_response/last_three_active_captain.dart';
import 'package:c4d/module_main/response/statistics_response/last_three_active_store.dart';
import 'package:c4d/module_main/response/statistics_response/statistics_response.dart';
import '../../abstracts/data_model/data_model.dart';

class StatisticsModel extends DataModel {
  late StatisticsOrder orders;
  late StatisticsCaptains captains;
  late StatisticsStores stores;
  StatisticsModel(
      {required this.orders, required this.captains, required this.stores});
  late StatisticsModel _model;
  StatisticsModel.withData(StatisticsResponse response) : super.withData() {
    var ordersR = response.dataum?.data?.orders?.countOrders;
    var captainsR = response.dataum?.data?.captains?.countCaptains;
    var storesR = response.dataum?.data?.stores?.countStores;
    StatisticsOrder order = StatisticsOrder(
        allOrders: ordersR?.allOrders ?? 0,
        dailyOrders:
            _getDailyOrder(ordersR?.delivered?.lastSevenDays?.daily ?? []),
        lastSevenDays: ordersR?.delivered?.lastSevenDays?.sum ?? 0,
        maxDeliveredPerDay:
            ordersR?.delivered?.lastSevenDays?.maxDeliveredCountPerDay ?? 0,
        minDeliveredPerDay:
            ordersR?.delivered?.lastSevenDays?.minDeliveredCountPerDay ?? 0,
        ongoing: ordersR?.onGoing ?? 0,
        pending: ordersR?.pending ?? 0);
    StatisticsCaptains captain = StatisticsCaptains(
        active: captainsR?.active ?? 0,
        captains:
            _getLastThreeCaptain(captainsR?.lastThreeActiveCaptains ?? []),
        nonActive: captainsR?.inactive ?? 0);
    StatisticsStores store = StatisticsStores(
        active: storesR?.active ?? 0,
        captains: _getLastThreeStore(storesR?.lastThreeActiveStores ?? []),
        nonActive: storesR?.inactive ?? 0);
    _model = StatisticsModel(captains: captain, orders: order, stores: store);
    print(_model);
  }
  List<DailyOrder> _getDailyOrder(List<Daily> d) {
    List<DailyOrder> daily = [];
    d.forEach((element) {
      daily.add(DailyOrder(
          count: element.count ?? 0, date: element.date?.substring(5) ?? ''));
    });
    return daily;
  }

  List<LastThreeActive> _getLastThreeCaptain(List<LastThreeActiveCaptain> d) {
    List<LastThreeActive> daily = [];
    d.forEach((element) {
      daily.add(LastThreeActive(
          createAt: '',
          id: element.id ?? -1,
          images: element.images?.image ?? '',
          name: element.captainName ?? S.current.unknown));
    });
    return daily;
  }

  List<LastThreeActive> _getLastThreeStore(List<LastThreeActiveStore> d) {
    List<LastThreeActive> daily = [];
    d.forEach((element) {
      daily.add(LastThreeActive(
          createAt: '',
          id: element.id ?? -1,
          images: element.images?.image ?? '',
          name: element.storeOwnerName ?? S.current.unknown));
    });
    return daily;
  }

  StatisticsModel get data => _model;
}

// order classes
class StatisticsOrder {
  int allOrders;
  int pending;
  int ongoing;
  int lastSevenDays;
  int minDeliveredPerDay;
  int maxDeliveredPerDay;
  List<DailyOrder> dailyOrders;
  StatisticsOrder({
    required this.allOrders,
    required this.pending,
    required this.ongoing,
    required this.lastSevenDays,
    required this.minDeliveredPerDay,
    required this.maxDeliveredPerDay,
    required this.dailyOrders,
  });
}

class DailyOrder {
  int count;
  String date;
  DailyOrder({
    required this.count,
    required this.date,
  });
}

class StatisticsCaptains {
  num active;
  num nonActive;
  List<LastThreeActive> captains;
  StatisticsCaptains({
    required this.active,
    required this.nonActive,
    required this.captains,
  });
}

class StatisticsStores {
  num active;
  num nonActive;
  List<LastThreeActive> captains;
  StatisticsStores({
    required this.active,
    required this.nonActive,
    required this.captains,
  });
}

class LastThreeActive {
  int id;
  String name;
  String createAt;
  String images;
  LastThreeActive({
    required this.id,
    required this.name,
    required this.createAt,
    required this.images,
  });
}
