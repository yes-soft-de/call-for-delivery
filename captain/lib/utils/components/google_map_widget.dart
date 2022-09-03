import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final void Function(GoogleMapController)? onMapCreated;
  final Set<Marker> markers;
  final Function(LatLng)? onTap;
  final Function(CameraPosition)? onCameraMove;
  final LatLng? currentLocation;
  final Set<Polyline>? ploylines;
  const MapWidget(
      {Key? key,
      this.onMapCreated,
      this.onTap,
      this.onCameraMove,
      this.markers = const <Marker>{},
      this.currentLocation,
      this.ploylines})
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
          polylines: widget.ploylines ?? {},
          initialCameraPosition: CameraPosition(
              target: widget.currentLocation ??
                  const LatLng(24.4713203, 39.7576433),
              zoom: 15)),
    );
  }
}
