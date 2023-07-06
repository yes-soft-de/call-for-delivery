import 'package:store_web/utils/effect/scaling.dart';
import 'package:store_web/utils/images/images.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final void Function(GoogleMapController)? onMapCreated;
  final Set<Marker> markers;
  final Function(LatLng)? onTap;
  final Function(CameraPosition)? onCameraMove;
  const MapWidget(
      {Key? key,
      this.onMapCreated,
      this.onTap,
      this.onCameraMove,
      this.markers = const <Marker>{}})
      : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      child: GoogleMap(
          onTap: widget.onTap,
          onCameraMove: widget.onCameraMove,
          compassEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          onMapCreated: widget.onMapCreated,
          markers: widget.markers,
          mapToolbarEnabled: false,
          initialCameraPosition:
              const CameraPosition(target: LatLng(36.747061, 36.1618916))),
    );
  }
}

class MyMarker extends StatelessWidget {
  // declare a global key and get it trough Constructor

  const MyMarker(this.globalKeyMyWidget, {super.key});
  final GlobalKey globalKeyMyWidget;

  @override
  Widget build(BuildContext context) {
    // wrap your widget with RepaintBoundary and
    // pass your global key to RepaintBoundary
    return RepaintBoundary(
        key: globalKeyMyWidget,
        child: Image.asset(
          ImageAsset.BOOK_CAR,
          height: 125,
          width: 125,
        ));
  }
}

class WindowInfoWidget extends StatelessWidget {
  final String name;
  const WindowInfoWidget({
    Key? key,
    required this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScalingWidget(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(25),
              ),
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).disabledColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.store,
                            color: Theme.of(context).disabledColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Triangle.isosceles(
            edge: Edge.BOTTOM,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(25)),
              width: 20.0,
              height: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}
