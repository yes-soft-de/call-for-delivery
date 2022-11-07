import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/model/deep_links_model.dart';
import 'package:c4d/module_deep_links/model/geo_model.dart';
import 'package:c4d/module_deep_links/request/geo_distance_request.dart';
import 'package:c4d/module_deep_links/response/geo_distance_x/cost_delivery_order_response/cost_delivery_order.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class GeoDistanceText extends StatefulWidget {
  LatLng origin;
  LatLng destination;
  Function(String?, String?) destance;
  int storeID;
  GeoDistanceText({
    Key? key,
    required this.destination,
    required this.origin,
    required this.destance,
    required this.storeID,
  }) : super(key: key);

  @override
  State<GeoDistanceText> createState() => _GeoDistanceTextState();
}

class _GeoDistanceTextState extends State<GeoDistanceText> {
  bool loading = true;
  String? distance = '';
  String? deliveryCost;
  CostDeliveryOrder? deliveryCostDetails;
  late LatLng origin;
  late LatLng destination;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _setup().whenComplete(() {
        setState(() {});
      });
    });
    super.initState();
  }

  Future<void> _setup() async {
    origin = widget.origin;
    destination = widget.destination;
    var snap = widget.storeID == -1
        ? await DeepLinksService.getGeoDistance(GeoDistanceRequest(
            origin: widget.origin,
            distance: widget.destination,
          ))
        : await DeepLinksService.getGeoDistanceWithDeliveryCost(
            GeoDistanceRequest(
                origin: widget.origin,
                distance: widget.destination,
                id: widget.storeID));
    if (snap.hasError || snap.isEmpty) {
      loading = false;
      distance = S.current.unknown;
      setState(() {});
    } else {
      loading = false;
      distance = (snap as GeoDistanceModel).distance;
      deliveryCost = FixedNumber.getFixedNumber(
          (snap as GeoDistanceModel).costDeliveryOrder?.total ?? 0);
      deliveryCostDetails = (snap as GeoDistanceModel).costDeliveryOrder;
      widget.destance(distance, deliveryCost);
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(GeoDistanceText oldWidget) {
    if (origin != widget.origin || destination != widget.destination) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
      child: Visibility(
        visible: deliveryCost != null && widget.storeID != -1,
        replacement: Text(
          S.current.distance + ' ' + (distance ?? '') + ' ${S.current.km}',
          style: TextStyle(color: Colors.white),
        ),
        child: Column(
          children: [
            Text(
              S.current.distance + ' ' + (distance ?? '') + ' ${S.current.km}',
              style: TextStyle(color: Colors.white),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              color: Theme.of(context).backgroundColor,
              thickness: 2.5,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text(S.current.deliveryCostDetails),
                        scrollable: true,
                        content: Column(
                          children: [
                            getRow(
                                S.current.extraDistance,
                                (deliveryCostDetails?.extraDistance
                                            ?.toString() ??
                                        '') +
                                    ' ' +
                                    S.current.km),
                            getRow(
                                S.current.extraOrderDeliveryCost,
                                (deliveryCostDetails?.extraOrderDeliveryCost
                                            ?.toString() ??
                                        '') +
                                    ' ' +
                                    S.current.sar),
                            getRow(
                                S.current.orderDeliveryCost,
                                (deliveryCostDetails?.orderDeliveryCost
                                            ?.toString() ??
                                        '') +
                                    ' ' +
                                    S.current.sar),
                            Divider(
                              color: Theme.of(context).backgroundColor,
                              thickness: 2.5,
                              indent: 8,
                              endIndent: 8,
                            ),
                            getRow(
                                S.current.total,
                                (deliveryCostDetails?.total?.toString() ?? '') +
                                    ' ' +
                                    S.current.sar),
                          ],
                        ),
                      );
                    });
              },
              child: Text(
                S.current.deliveryCost +
                    ' ' +
                    (deliveryCost ?? '') +
                    ' ${S.current.sar}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRow(String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 125,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).backgroundColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 75,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).backgroundColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                subtitle,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
