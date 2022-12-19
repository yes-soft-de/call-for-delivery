import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/model/geo_model.dart';
import 'package:c4d/module_deep_links/request/geo_distance_request.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class GeoDistanceText extends StatefulWidget {
  final LatLng origin;
  final LatLng destination;
  final Function(String?) destance;
  final TextStyle? textStyle;
  final String? leading;
  const GeoDistanceText(
      {Key? key,
      required this.destination,
      required this.origin,
      required this.destance,
      this.textStyle,
      this.leading})
      : super(key: key);

  @override
  State<GeoDistanceText> createState() => _GeoDistanceTextState();
}

class _GeoDistanceTextState extends State<GeoDistanceText> {
  bool loading = true;
  String? distance = '';
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _setup();
    });
    super.initState();
  }

  Future<void> _setup() async {
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
    if (oldWidget.origin != widget.origin ||
        oldWidget.destination != widget.destination) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _setup();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    String space = widget.leading != null ? ' ' : '';
    return Visibility(
      visible: loading == false,
      replacement: const SizedBox(
          width: 10,
          height: 10,
          child: Center(child: CircularProgressIndicator())),
      child: Text(
        (widget.leading ?? '') + space + (distance ?? '') + ' ${S.current.km}',
        style: widget.textStyle ?? const TextStyle(color: Colors.white),
      ),
    );
  }
}
