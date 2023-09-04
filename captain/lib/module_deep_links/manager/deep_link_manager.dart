// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/module_deep_links/repository/deep_link_local_repository.dart';
import 'package:c4d/module_deep_links/repository/deep_link_repository.dart';
import 'package:c4d/module_deep_links/request/geo_distance_request.dart';
import 'package:c4d/module_deep_links/response/geo_distance_x/geo_distance_x.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeepLinkManager {
  DeepLinkRepository _deepLinkRepository;
  DeepLinkLocalRepository _deepLinkLocalRepository;

  DeepLinkManager(
    this._deepLinkRepository,
    this._deepLinkLocalRepository,
  );

  Future<GeoDistanceX?> getDistance(GeoDistanceRequest g) async {
    var distance = await _deepLinkLocalRepository.getDistance(g);

    if (distance == null) {
      distance = await _deepLinkRepository.getDistance(g);
      if (distance != null) {
        _deepLinkLocalRepository.addDistance(g, distance);
      }
    }

    return distance;
  }
}
