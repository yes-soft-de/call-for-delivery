import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/model/deep_links_model.dart';
import 'package:c4d/module_deep_links/model/geo_model.dart';
import 'package:c4d/module_deep_links/repository/deep_link_repository.dart';
import 'package:c4d/module_deep_links/request/geo_distance_request.dart';
import 'package:c4d/module_deep_links/response/geo_distance_x/geo_distance_x.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:uni_links/uni_links.dart';
import 'package:uri/uri.dart';

class DeepLinksService {
  static Future<String> _getFirebaseDynamicLinkData(String link) async {
    try {
      final dio = Dio();
      final response = await dio.get(link);
      print(response.headers);
      print(response.redirects.first.location.toString());
      return response.redirects.first.location.toString();
    } catch (e) {
      return link;
    }
  }

  static Future<String> extractCoordinatesFromUrl(String url) async {
    Uri uri = Uri.parse(url);

    if (uri.host == 'www.google.com' && uri.path.startsWith('/maps/place/')) {
      return _extractCoordinatesFromGoogleMapsUrl(uri);
    } else if (uri.scheme == 'comgooglemaps' &&
        uri.queryParameters.containsKey('daddr')) {
      return _extractCoordinatesFromComGoogleMapsUrl(uri);
    } else {
      print('Invalid URL format.');
      return _getFirebaseDynamicLinkData(url);
    }
  }

  static Future<DeepLinksModel?> checkForGeoLink() async {
    var uri = await getInitialUri();
    if (uri == null) {
      return null;
    }
    if (uri.queryParameters['q'] == null) {
      return null;
    }
    var model;
    if (uri.toString().contains('+') == true) {
      var end = uri.toString().indexOf('?');
      var query = uri.toString().substring(4, end);
      model = DeepLinksModel(
          location: LatLng(
            double.parse(query.split(',')[0].trim()),
            double.parse(query.split(',')[1].trim()),
          ),
          link: uri);
    } else {
      model = DeepLinksModel(
          location: LatLng(
            double.parse(uri.queryParameters['q']!.split(',')[0]),
            double.parse(uri.queryParameters['q']!.split(',')[1]),
          ),
          link: uri);
    }
    return model;
  }

  static Future<LatLng?> defaultLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      // if (!serviceEnabled) {
      //   serviceEnabled = await loc.Location().requestService();
      //   if (!serviceEnabled) {
      //     return null;
      //   }
      // }
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
          await Geolocator.getCurrentPosition(timeLimit: Duration(seconds: 10));
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

  static Future<double> getDistance(LatLng headed) async {
    var currentLocation = await defaultLocation();
    if (currentLocation == null) return 0.0;
    var straightDistance =
        const Distance().as(LengthUnit.Kilometer, currentLocation, headed);
    return straightDistance;
  }

  static double? getInitDistance(LatLng headed, LatLng? currentLocation) {
    if (currentLocation == null) return null;
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

  static Future<DataModel> getGeoDistanceWithDeliveryCost(
      GeoDistanceRequest request) async {
    GeoDistanceX? response =
        await getIt<DeepLinkRepository>().getDistanceWithDeliveryCost(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    GeoDistanceModel model = GeoDistanceModel(
        distance: response.data?.distance,
        costDeliveryOrder: response.data?.costDeliveryOrder);
    return model;
  }

  static String _extractCoordinatesFromGoogleMapsUrl(Uri uri) {
    UriTemplate template = UriTemplate('/maps/place/{latitude},{longitude}');
    UriParser parser = UriParser(template);
    UriMatch? match = parser.match(uri);

    if (match != null) {
      String latitude = match.parameters['latitude']!;
      String longitude = match.parameters['longitude']!;

      print('Latitude: $latitude');
      print('Longitude: $longitude');
      return 'https://maps.google.com?q=$latitude,$longitude';
    } else {
      print('URL does not contain latitude and longitude.');
    }
    return uri.toString();
  }

  static String _extractCoordinatesFromComGoogleMapsUrl(Uri uri) {
    String daddr = uri.queryParameters['daddr']!;
    List<String> coordinates = daddr.split(',');

    if (coordinates.length == 2) {
      String latitude = coordinates[0];
      String longitude = coordinates[1];

      print('Latitude: $latitude');
      print('Longitude: $longitude');
      return 'https://maps.google.com?q=$latitude,$longitude';
    } else {
      print('Invalid coordinates format.');
    }
    return uri.toString();
  }
}
