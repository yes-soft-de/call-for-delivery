import 'package:c4d/utils/helpers/date_converter.dart';

import '../../abstracts/data_model/data_model.dart';
import '../../generated/l10n.dart';
import '../response/statistics_response/daily.dart';
import '../response/statistics_response/last_three_captains_active.dart';
import '../response/statistics_response/last_three_stores_active.dart';
import '../response/statistics_response/statistics_response.dart';

class StatisticsModel extends DataModel {
  late StatisticsOrder orders;
  late StatisticsCaptains captains;
  late StatisticsStores stores;
  late StatisticsModel _model;

  StatisticsModel(
      {required this.orders, required this.captains, required this.stores});

  StatisticsModel.withData(StatisticsResponse response) : super.withData() {
    var ordersR = response.data?.data?.orders?.counts;
    var captainsR = response.data?.data?.captains?.count;
    var storesR = response.data?.data?.stores?.counts;

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
        captains: _getLastThreeCaptain(captainsR?.lastThreeActive ?? []),
        nonActive: captainsR?.inactive ?? 0);

    StatisticsStores store = StatisticsStores(
        active: storesR?.active ?? 0,
        stores: _getLastThreeStore(storesR?.lastThreeActive ?? []),
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
    daily = daily.reversed.toList();
    return daily;
  }

  List<LastThreeActive> _getLastThreeCaptain(List<LastThreeCaptainsActive> d) {
    List<LastThreeActive> daily = [];
    d.forEach((element) {
      var date = '';
      date +=
          DateHelper.convert(element.createdAt?.timestamp).month.toString() +
              '-';
      date += DateHelper.convert(element.createdAt?.timestamp).day.toString();

      date += '  ';

      date += DateHelper.convert(element.createdAt?.timestamp).hour.toString()+
              ':';
      date +=
          DateHelper.convert(element.createdAt?.timestamp).minute.toString();
          
      daily.add(LastThreeActive(
          createAt: date,
          id: element.id ?? -1,
          image: element.images?.image ?? '',
          name: element.captainName ?? S.current.unknown));
    });
    return daily;
  }

  List<LastThreeActive> _getLastThreeStore(List<LastThreeStoresActive> d) {
    List<LastThreeActive> daily = [];
    d.forEach((element) {
      var date = '';
      date +=
          DateHelper.convert(element.createdAt?.timestamp).month.toString() +
              '-';
      date += DateHelper.convert(element.createdAt?.timestamp).day.toString();

      date += '  ';

      date += DateHelper.convert(element.createdAt?.timestamp).hour.toString()+
              ':';
      date +=
          DateHelper.convert(element.createdAt?.timestamp).minute.toString();

      daily.add(LastThreeActive(
          createAt: date,
          id: element.id ?? -1,
          image: element.images?.image ?? '',
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
  List<LastThreeActive> stores;

  StatisticsStores({
    required this.active,
    required this.nonActive,
    required this.stores,
  });
}

class LastThreeActive {
  int id;
  String name;
  String createAt;
  String image;
  LastThreeActive({
    required this.id,
    required this.name,
    required this.createAt,
    required this.image,
  });
}
