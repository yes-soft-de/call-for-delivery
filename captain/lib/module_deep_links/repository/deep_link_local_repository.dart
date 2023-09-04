import 'package:c4d/module_deep_links/model/geo_hive.dart';
import 'package:c4d/module_deep_links/request/geo_distance_request.dart';
import 'package:c4d/module_deep_links/response/geo_distance_x/geo_distance_x.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:hive_flutter/hive_flutter.dart';

@injectable
class DeepLinkLocalRepository {
  DeepLinkLocalRepository();

  static final _box = Hive.box('DeepLinkLocalRepository');
  static const cachedDistance = 'cachedDistance';

  Future<GeoDistanceX?> getDistance(GeoDistanceRequest g) async {
    try {
      var distanceList = _getDistanceList();

      GeoHive? matchedValue =
          distanceList.firstWhere((element) => element.request == g);

      return matchedValue.response;
    } catch (e) {
      Logger
          .error('DeepLinkLocalRepository', e.toString(), StackTrace.current);
      return null;
    }
  }

  void addDistance(GeoDistanceRequest request, GeoDistanceX response) {
    try {
      List<GeoHive> list = _getDistanceList();

      list.add(GeoHive(request: request, response: response));

      _setDistanceList(list);
    } catch (e) {
      Logger
          .error('DeepLinkLocalRepository', e.toString(), StackTrace.current);
    }
  }

  List<GeoHive> _getDistanceList() {
    try {
      List<String>? distanceListAsString =
          _box.get(cachedDistance) as List<String>?;
      List<GeoHive>? distanceList = distanceListAsString
          ?.map(
            (e) => GeoHive.fromJson(e),
          )
          .toList();
      return distanceList ?? [];
    } catch (e) {
      Logger
          .error('DeepLinkLocalRepository', e.toString(), StackTrace.current);
      return [];
    }
  }

  void _setDistanceList(List<GeoHive> list) async {
    try {
      List<String> distanceListAsString = list
          .map(
            (e) => e.toJson(),
          )
          .toList();
      _box.put(cachedDistance, distanceListAsString);
    } catch (e) {
      Logger.error('DeepLinkLocalRepository', e.toString(), StackTrace.current);
    }
  }

  static void clearCachedDistances() {
    _box.delete(cachedDistance);
  }
}
