// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_external_delivery_companies/response/naher_evan_captain_response/log.dart'
    as r;
import 'package:c4d/module_external_delivery_companies/response/naher_evan_captain_response/naher_evan_captain_response.dart';

class NaherEvanCaptainModel extends DataModel {
  late List<Log> logs;
  late num onlineHoursCount;
  late num createdOrderCount;
  late num deliveredOrderCount;
  late NaherEvanCaptainModel _model;

  NaherEvanCaptainModel({
    required this.logs,
    required this.onlineHoursCount,
    required this.createdOrderCount,
    required this.deliveredOrderCount,
  });

  NaherEvanCaptainModel.withData(NaherEvanCaptainResponse response)
      : super.withData() {
    var data = response.data;
    _model = NaherEvanCaptainModel(
      createdOrderCount: data?.createdOrderCount ?? 0,
      deliveredOrderCount: data?.deliveredOrderCount ?? 0,
      logs: Log.getLogs(data?.logs),
      onlineHoursCount: data?.onlineHoursCount ?? 0,
    );
  }
  NaherEvanCaptainModel get data => _model;
}

class Log {
  int id;
  int captainProfileId;
  bool isOnline;
  DateTime createdAt;

  Log({
    required this.id,
    required this.captainProfileId,
    required this.isOnline,
    required this.createdAt,
  });

  static List<Log> getLogs(List<r.Log>? responseList) {
    List<Log> list = [];

    responseList?.forEach(
      (element) {
        list.add(Log(
          id: element.id ?? 0,
          captainProfileId: element.captainProfileId ?? 0,
          isOnline: element.isOnline ?? false,
          createdAt: element.createdAt ?? DateTime(2020),
        ));
      },
    );

    return list;
  }
}
