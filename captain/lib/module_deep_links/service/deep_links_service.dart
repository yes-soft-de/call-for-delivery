import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/manager/deep_link_manager.dart';
import 'package:c4d/module_deep_links/model/geo_model.dart';
import 'package:c4d/module_deep_links/request/geo_distance_request.dart';
import 'package:c4d/module_deep_links/response/geo_distance_x/geo_distance_x.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:uni_links/uni_links.dart';
import 'package:geolocator/geolocator.dart';
import 'package:c4d/utils/logger/logger.dart';

@injectable
class DeepLinksService {
  static DeepLinkManager _deepLinkManager = getIt();

  DeepLinksService();

  static Future<LatLng?> checkForGeoLink() async {
    var uri = await getInitialUri();

    if (uri == null) {
      return null;
    }
    if (uri.queryParameters['q'] == null) {
      return null;
    }

    return LatLng(
      double.parse(uri.queryParameters['q']!.split(',')[0]),
      double.parse(uri.queryParameters['q']!.split(',')[1]),
    );
  }

  static Future<LatLng?> defaultLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // if (!serviceEnabled) {
      // serviceEnabled = await Geolocator.requestPermission();
      //   serviceEnabled = await loc.Location().requestService();
      //   if (!serviceEnabled) {
      //     return null;
      //   }
      // }
      LocationPermission checkPermission = await Geolocator.checkPermission();
      //
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return null;
      }
      var myLocation = await Geolocator.getCurrentPosition(
          timeLimit: const Duration(seconds: 10));
      LatLng myPos = LatLng(myLocation.latitude, myLocation.longitude);
      return myPos;
    } catch (e) {
      Logger().error('Get Location', e.toString(), StackTrace.current);
      LocationPermission checkPermission = await Geolocator.checkPermission();
      var serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (LocationPermission.whileInUse == checkPermission && serviceEnabled) {
        var myLocation = await Geolocator.getLastKnownPosition();
        if (myLocation == null) {
          LatLng myPos =
              LatLng(myLocation?.latitude ?? 0, myLocation?.longitude ?? 0);
          return myPos;
        }
      }
      return null;
    }
  }

  static Future<double?> getDistance(LatLng headed) async {
    var currentLocation = await defaultLocation();
    if (currentLocation == null) return null;
    var straightDistance =
        const Distance().as(LengthUnit.Kilometer, currentLocation, headed);
    return straightDistance;
  }

  static double? getInitDistance(LatLng headed, LatLng? location) {
    var currentLocation = location;
    if (currentLocation == null) return null;
    var straightDistance =
        const Distance().as(LengthUnit.Kilometer, currentLocation, headed);
    return straightDistance;
  }

  static Future<DataModel> getGeoDistance(GeoDistanceRequest request) async {
    GeoDistanceX? response = await _deepLinkManager.getDistance(request);
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

  static Future<bool> canRequestLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
