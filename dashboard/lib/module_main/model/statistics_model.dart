import '../../abstracts/data_model/data_model.dart';

class StatisticsModel extends DataModel {
  late StatisticsOrder orders;

  StatisticsModel({required this.orders});

  StatisticsModel.withData(response) : super.withData() {}
}

// order classes
class StatisticsOrder {
  num allOrders;
  num pending;
  num ongoing;
  num lastSevenDays;
  num minDeliveredPerDay;
  num maxDeliveredPerDay;
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
  String data;
  DailyOrder({
    required this.count,
    required this.data,
  });
}

class StatisticsCaptain {
  num active;
  num nonActive;
  List<LastThreeActive> captains;
  StatisticsCaptain({
    required this.active,
    required this.nonActive,
    required this.captains,
  });
}

class LastThreeActive {
  int id;
  String captainName;
  String createAt;
  String images;
  LastThreeActive({
    required this.id,
    required this.captainName,
    required this.createAt,
    required this.images,
  });
}
