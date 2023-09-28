import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/model/geo_model.dart';
import 'package:c4d/module_deep_links/response/geo_distance_x/cost_delivery_order_response/cost_delivery_order.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../module_deep_links/request/geo_distance_request.dart';
import '../../../module_deep_links/service/deep_links_service.dart';
import '../../../utils/helpers/custom_flushbar.dart';
import '../../../utils/helpers/fixed_numbers.dart';

class GeoDistanceText extends StatefulWidget {
  LatLng origin;
  LatLng destination;

  GeoDistanceRequest request;
  Function(GeoDistanceModel) finalDistance;
  int callGeoAgin;

  GeoDistanceText({
    Key? key,
    required this.destination,
    required this.origin,
    required this.finalDistance,
    required this.request,
    required this.callGeoAgin,
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
  late GeoDistanceRequest request;
  late int callGeoAgin;

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
    request = widget.request;
    origin = widget.origin;
    destination = widget.destination;
    callGeoAgin = widget.callGeoAgin ?? 0;
    var snap =
        await DeepLinksService.getGeoDistanceWithDeliveryCost(widget.request);

    if (snap is GeoDistanceModel) {
      widget.finalDistance(snap);
      distance = snap.distance;
      deliveryCost =
          FixedNumber.getFixedNumber(snap.costDeliveryOrder?.total ?? 0);
      deliveryCostDetails = snap.costDeliveryOrder;
    }

    if (snap.hasError || snap.isEmpty) {
      distance = S.current.unknown;
      deliveryCost = null;
      deliveryCostDetails = null;
      CustomFlushBarHelper.createError(
        title: S.current.note,
        message: snap.error ?? S.current.unknown,
      ).show(context);
    }

    loading = false;
    setState(() {});

    // var snap = await DeepLinksService.getGeoDistanceWithDeliveryCost(
    //     GeoDistanceRequest(
    //   origin: widget.origin,
    //   distance: widget.destination,
    // ));
    // if (snap.hasError || snap.isEmpty) {
    //   loading = false;
    //   distance = S.current.unknown;
    //   setState(() {});
    // } else {
    //   loading = false;
    //   distance = (snap as GeoDistanceModel).distance;
    //   deliveryCost =
    //       FixedNumber.getFixedNumber((snap).costDeliveryOrder?.total ?? 0);
    //   deliveryCostDetails = (snap).costDeliveryOrder;
    //   widget.destance(distance, (snap).costDeliveryOrder?.total);
    //   setState(() {});
    // }
  }

  @override
  void didUpdateWidget(GeoDistanceText oldWidget) {
    if (origin != widget.origin ||
        destination != widget.destination ||
        request.link != widget.request.link ||
        callGeoAgin != widget.callGeoAgin) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          loading = true;
        });
        _setup();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loading == false,
      replacement: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircularProgressIndicator(),
            Text(
              S.current.fetchingData,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(),
          ],
        ),
      ),
      child: Visibility(
        visible: deliveryCost != null,
        replacement: Text(
          S.current.distance +
              ' ' +
              (distance ?? '') +
              ' ${(distance == S.current.unknown) ? '' : S.current.km}',
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
              color: Theme.of(context).colorScheme.background,
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
                              color: Theme.of(context).colorScheme.background,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Text(
                    S.current.deliveryCost +
                        ' ' +
                        (deliveryCost ?? '') +
                        ' ${S.current.sar}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
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
                color: Theme.of(context).colorScheme.background),
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
                color: Theme.of(context).colorScheme.background),
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
