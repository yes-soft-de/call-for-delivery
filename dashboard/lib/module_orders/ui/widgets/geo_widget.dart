import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/model/deep_links_model.dart';
import 'package:c4d/module_deep_links/model/geo_model.dart';
import 'package:c4d/module_deep_links/request/geo_distance_request.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class GeoDistanceText extends StatefulWidget {
  LatLng origin;
  LatLng destination;
  Function(String?) destance;
  GeoDistanceText(
      {Key? key,
      required this.destination,
      required this.origin,
      required this.destance})
      : super(key: key);

  @override
  State<GeoDistanceText> createState() => _GeoDistanceTextState();
}

class _GeoDistanceTextState extends State<GeoDistanceText> {
  bool loading = true;
  String? distance = '';
  late LatLng origin;
  late LatLng destination;
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _setup().whenComplete(() {
        setState(() {});
      });
    });
    super.initState();
  }

  Future<void> _setup() async {
    origin = widget.origin;
    destination = widget.destination;
    var snap = await DeepLinksService.getGeoDistance(GeoDistanceRequest(
        origin: widget.origin, distance: widget.destination));
    if (snap.hasError || snap.isEmpty) {
      loading = false;
      distance = S.current.unknown;
      setState(() {});
    } else {
      loading = false;
      distance = (snap as GeoDistanceModel).distance;
      widget.destance(distance);
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(GeoDistanceText oldWidget) {
    if (origin != widget.origin || destination != widget.destination) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        _setup();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loading == false,
      replacement: Text(
        S.current.calculating + '....',
        style: TextStyle(color: Colors.white),
      ),
      child: Text(
        S.current.distance + ' ' + (distance ?? '') + ' ${S.current.km}',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
