import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:uni_links/uni_links.dart';
import 'package:geolocator/geolocator.dart';
import 'package:c4d/utils/logger/logger.dart';

class DeepLinksService {
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
      if (!serviceEnabled) {
        serviceEnabled = await loc.Location().requestService();
        if (!serviceEnabled) {
          return null;
        }
      }
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
      var myLocation =
          await Geolocator.getCurrentPosition(timeLimit: const Duration(seconds: 10));
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
}
