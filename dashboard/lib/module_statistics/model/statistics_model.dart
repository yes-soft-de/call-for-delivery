// ignore_for_file: unused_local_variable

import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/response/orders_counts/daily.dart';
import 'package:c4d/module_statistics/response/statistics_response/statistics_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/module_statistics/response/stores_counts/store.dart' as r;
import 'package:c4d/module_statistics/response/captains_counts/captain.dart'
    as r;

class StatisticsModel extends DataModel {
  late StatisticsOrder orders;
  late StatisticsCaptains captains;
  late StatisticsStores stores;
  late StatisticsModel _model;

  StatisticsModel(
      {required this.orders, required this.captains, required this.stores});

  StatisticsModel.withData(StatisticsResponse response) : super.withData() {
    var ordersR = response.data?.data?.orders?.count;
    var captainsR = response.data?.data?.captains?.count;
    var storesR = response.data?.data?.stores?.count;

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
        lastActorsActive: _getCaptainsList(captainsR?.lastThreeActive ?? []),
        lastActorsMadeTransactions:
            _getCaptainsList(captainsR?.lastFiveDeliveredOrdersCaptains ?? []),
        nonActive: captainsR?.inactive ?? 0);

    StatisticsStores store = StatisticsStores(
        active: storesR?.active ?? 0,
        lastActorsActive: _getStoresList(storesR?.lastThreeActive ?? []),
        lastActorsMadeTransactions:
            _getStoresList(storesR?.lastFiveCreatedOrderStores ?? []),
        nonActive: storesR?.inactive ?? 0);

    _model = StatisticsModel(captains: captain, orders: order, stores: store);
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

  List<Actor> _getCaptainsList(List<r.Captain> d) {
    List<Actor> daily = [];
    d.forEach((element) {
      var date = DateHelper.convert(element.createdAt?.timestamp ?? 0);

      daily.add(Captain(
          createAt: date,
          id: element.id ?? -1,
          image: element.images?.image ?? '',
          name: element.captainName ?? S.current.unknown));
    });
    return daily;
  }

  List<Actor> _getStoresList(List<r.Store> d) {
    List<Actor> daily = [];
    d.forEach((element) {
      var date = DateHelper.convert(element.createdAt?.timestamp ?? 0);

      daily.add(Store(
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

/// it can be either [StatisticsCaptains] or [StatisticsStores]
abstract class StatisticsActors {
  num active;
  num nonActive;
  List<Actor> lastActorsActive;
  List<Actor> lastActorsMadeTransactions;

  StatisticsActors({
    required this.active,
    required this.nonActive,
    required this.lastActorsActive,
    required this.lastActorsMadeTransactions,
  });
}

class StatisticsCaptains extends StatisticsActors {
  StatisticsCaptains(
      {required num active,
      required num nonActive,
      required List<Actor> lastActorsActive,
      required List<Actor> lastActorsMadeTransactions})
      : super(
            active: active,
            nonActive: nonActive,
            lastActorsActive: lastActorsActive,
            lastActorsMadeTransactions: lastActorsMadeTransactions);
}

class StatisticsStores extends StatisticsActors {
  StatisticsStores(
      {required num active,
      required num nonActive,
      required List<Actor> lastActorsActive,
      required List<Actor> lastActorsMadeTransactions})
      : super(
            active: active,
            nonActive: nonActive,
            lastActorsActive: lastActorsActive,
            lastActorsMadeTransactions: lastActorsMadeTransactions);
}

/// it can be either  [Captain] or [Store]
abstract class Actor {
  int id;
  String name;
  DateTime createAt;
  String image;
  Actor({
    required this.id,
    required this.name,
    required this.createAt,
    required this.image,
  });
}

class Captain extends Actor {
  Captain(
      {required int id,
      required String name,
      required DateTime createAt,
      required String image})
      : super(id: id, name: name, createAt: createAt, image: image);
}

class Store extends Actor {
  Store(
      {required int id,
      required String name,
      required DateTime createAt,
      required String image})
      : super(id: id, name: name, createAt: createAt, image: image);
}
