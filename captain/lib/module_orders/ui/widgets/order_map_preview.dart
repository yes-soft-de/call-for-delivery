import 'dart:async';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/helper/laubcher_link_helper.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:c4d/utils/components/google_map_widget.dart';
import 'package:c4d/utils/components/my_marker.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderMapPreview extends StatefulWidget {
  final OrderModel order;
  const OrderMapPreview({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderMapPreview> createState() => _OrderMapPreviewState();
}

class _OrderMapPreviewState extends State<OrderMapPreview> {
  Completer<GoogleMapController> controller = Completer();
  late CustomInfoWindowController customInfoWindowController;
  final GlobalKey branchKey = GlobalKey();
  final GlobalKey clientKey = GlobalKey();
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
    LatLng? branch = LatLng(widget.order.location?.latitude ?? 0,
        widget.order.location?.longitude ?? 0);
    return CustomGoogleMapMarkerBuilder(
      customMarkers: [
        MarkerData(
          marker: Marker(
              markerId: const MarkerId('branch'),
              position: LatLng(widget.order.location?.latitude ?? 0,
                  widget.order.location?.longitude ?? 0),
              onTap: () {
                var url = LauncherLinkHelper.getMapsLink(
                    widget.order.location?.latitude ?? 0,
                    widget.order.location?.longitude ?? 0);
                canLaunch(url).then((value) {
                  if (value) {
                    launch(url);
                  } else {
                    Fluttertoast.showToast(msg: S.current.invalidMapLink);
                  }
                });
              }),
          child: MyMarker(),
        ),
        MarkerData(
            marker: Marker(
                markerId: const MarkerId('client'),
                position: LatLng(widget.order.destination?.latitude ?? 0,
                    widget.order.destination?.longitude ?? 0),
                onTap: () {
                  var url = widget.order.destinationLink ?? '';
                  canLaunch(url).then((value) {
                    if (value) {
                      launch(url);
                    } else {
                      Fluttertoast.showToast(msg: S.current.invalidMapLink);
                    }
                  });
                }),
            child: Visibility(
                replacement: const SizedBox(
                  width: 15,
                  height: 15,
                ),
                visible: widget.order.destination != null,
                child: const ClientMarker())),
      ],
      builder: (context, Set<Marker>? markers) {
        return MapWidget(
          ploylines: widget.order.destination != null
              ? {
                  Polyline(
                    polylineId: const PolylineId('1'),
                    points: [
                      LatLng(widget.order.location?.latitude ?? 0,
                          widget.order.location?.longitude ?? 0),
                      LatLng(widget.order.destination?.latitude ?? 0,
                          widget.order.destination?.longitude ?? 0)
                    ],
                    color: Colors.green.withOpacity(0.65),
                    width: 5,
                    endCap: Cap.roundCap,
                    startCap: Cap.roundCap,
                  ),
                }
              : {},
          markers: markers ?? {},
          onTap: (position) {},
          currentLocation: branch,
          onCameraMove: (position) {},
          onMapCreated: (con) async {
            await con
                .setMapStyle(getIt<ThemePreferencesHelper>().getStyleMode());
            controller.complete(con);
          },
        );
      },
    );
  }
}
