import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/model/deep_links_model.dart';
import 'package:c4d/module_deep_links/model/geo_model.dart';
import 'package:c4d/module_deep_links/repository/deep_link_repository.dart';
import 'package:c4d/module_deep_links/request/geo_distance_request.dart';
import 'package:c4d/module_deep_links/response/geo_distance_x/geo_distance_x.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinksService {
  static Future<DeepLinksModel?> checkForGeoLink() async {
    var uri = await getInitialUri();

    if (uri == null) {
      return null;
    }
    if (uri.queryParameters['q'] == null) {
      return null;
    }

    return DeepLinksModel(
        location: LatLng(
          double.parse(uri.queryParameters['q']!.split(',')[0]),
          double.parse(uri.queryParameters['q']!.split(',')[1]),
        ),
        link: uri);
  }

  static Future<LatLng?> defaultLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    var myLocation = await Location.instance.getLocation();
    LatLng myPos = LatLng(myLocation.latitude ?? 0, myLocation.longitude ?? 0);
    return myPos;
  }

  static Future<double> getDistance(LatLng headed) async {
    var currentLocation = await defaultLocation();
    if (currentLocation == null) return 0.0;
    var straightDistance =
        const Distance().as(LengthUnit.Kilometer, currentLocation, headed);
    return straightDistance;
  }

  static Future<DataModel> getGeoDistance(GeoDistanceRequest request) async {
    GeoDistanceX? response =
        await getIt<DeepLinkRepository>().getDistance(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    GeoDistanceModel model =
        GeoDistanceModel(distance: response.data?.distance);
    return model;
  }
}
