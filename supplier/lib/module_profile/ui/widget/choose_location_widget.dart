import 'dart:async';
import 'dart:math';

import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/utils/components/google_map_widget.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../module_theme/pressistance/theme_preferences_helper.dart';

class ChooseLocation extends StatefulWidget {
  final Function saveLocation;
  final LatLng? lastLocation;

  const ChooseLocation({required this.saveLocation, this.lastLocation});
  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  Completer<GoogleMapController> controller = Completer();
  late CustomInfoWindowController customInfoWindowController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Stack(
          children: [
            // Google Map
            SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: MapWidget(
                      markers: markers,
                      onTap: (position) {
                        print('hhhhhhhhh');
                        print(position);
                        _getMarkers(context, potions: position);
                      },
                      onCameraMove: (position) {
                        customInfoWindowController.onCameraMove!();
                      },
                      onMapCreated: (con) async {
                        try {
                          customInfoWindowController.googleMapController = con;
                          await con.setMapStyle(
                              getIt<ThemePreferencesHelper>().getStyleMode());
                          controller.complete(con);
                        } catch (e) {}
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
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 100.0, right: 8, left: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
//                    var myLocation = await DeepLinksService.defaultLocation();
//                    LatLng myPos = LatLng(
//                        myLocation?.latitude ?? 0, myLocation?.longitude ?? 0);
                    LatLng myPos = markers.first.position;
                    customInfoWindowController.googleMapController
                        ?.animateCamera(CameraUpdate.newCameraPosition(
                            CameraPosition(target: myPos, zoom: 15)));
//                        saveMarker(myPos);
//                        screenState.refresh();
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.maxFinite,
                      height: 55,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(S.of(context).save),
                          onPressed: () {
                            widget.saveLocation(markers.first.position);
                            Navigator.pop(context);
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    customInfoWindowController = CustomInfoWindowController();
    updateLocation();
  }

  void _getMarkers(BuildContext context, {LatLng? potions}) async {
    markers = {};
    LatLng myPos;
    if (potions != null) {
      myPos = potions;
    } else {
      var myLocation = await DeepLinksService.defaultLocation();
      myPos = LatLng(myLocation?.latitude ?? 0, myLocation?.longitude ?? 0);
    }
    markers = {
      Marker(
        markerId: MarkerId(Random().nextInt(1000).toString()),
        position: myPos,
        icon: await BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed),
      )
    };
    setState(() {});
  }

  void updateLocation() async {
    if (widget.lastLocation != null) {
      print('location Not null');
      print(widget.lastLocation);
      markers = {
        Marker(
          markerId: MarkerId(Random().nextInt(1000).toString()),
          position: widget.lastLocation ?? LatLng(0, 0),
          icon: await BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed),
        )
      };
      setState(() {});
    } else{
      print('location null');
      _getMarkers(context);

    }
  }
}
