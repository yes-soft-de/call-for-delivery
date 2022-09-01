import 'dart:async';
import 'package:custom_marker/marker_icon.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:c4d/utils/components/google_map_widget.dart';
import 'package:c4d/utils/components/my_marker.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderMapPreview extends StatefulWidget {
  OrderMapPreview({Key? key}) : super(key: key);

  @override
  State<OrderMapPreview> createState() => _OrderMapPreviewState();
}

class _OrderMapPreviewState extends State<OrderMapPreview> {
  Completer<GoogleMapController> controller = Completer();
  late CustomInfoWindowController customInfoWindowController;
  final GlobalKey globalKey = GlobalKey();
  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    customInfoWindowController = CustomInfoWindowController();
    getIt<AppThemeDataService>().darkModeStream.listen((event) async {
      GoogleMapController control = await controller.future;
      await control.setMapStyle(getIt<ThemePreferencesHelper>().getStyleMode());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Google Map
        SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(
            children: [
              // marker
              MyMarker(globalKey),
              Positioned.fill(
                child: MapWidget(
                  markers: markers,
                  onTap: (position) {
                    customInfoWindowController.hideInfoWindow!();
                  },
                  onCameraMove: (position) {
                    customInfoWindowController.onCameraMove!();
                  },
                  onMapCreated: (con) async {
                    customInfoWindowController.googleMapController = con;
                    await con.setMapStyle(
                        getIt<ThemePreferencesHelper>().getStyleMode());
                    controller.complete(con);
                  },
                ),
              ),
              CustomInfoWindow(
                controller: customInfoWindowController,
                height: 100,
                width: 180,
                offset: 50,
              ),
            ],
          ),
        ),
        // Mentoring Panel
      ],
    );
  }

  // Future<Set<Marker>> getMarkers(
  //     List<CaptainsModel> captains, GlobalKey globalKey) async {
  //   Set<Marker> markers = {};
  //   for (var captain in captains) {
  //     if (captain.currentLocation == null) {
  //       continue;
  //     }
  //     markers.add(Marker(
  //         markerId: MarkerId(captain.uid),
  //         position: captain.currentLocation!,
  //         icon: await MarkerIcon.widgetToIcon(globalKey),
  //         onTap: () {}));
  //   }
  //   return markers;
  // }
}
