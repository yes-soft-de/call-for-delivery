import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/helper/laubcher_link_helper.dart';
import 'package:c4d/module_orders/request/update_distance_request.dart';
import 'package:c4d/module_orders/response/orders_response/destination.dart';
import 'package:c4d/module_orders/ui/widgets/geo_widget.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class UpdateDistanceDialog extends StatefulWidget {
  final LatLng branchLocation;
  final Function(UpdateDistanceRequest) callback;
  final int id;
  UpdateDistanceDialog({
    Key? key,
    required this.branchLocation,
    required this.callback,
    required this.id,
  }) : super(key: key);

  @override
  State<UpdateDistanceDialog> createState() => _UpdateDistanceDialogState();
}

class _UpdateDistanceDialogState extends State<UpdateDistanceDialog> {
  var _kilometer = TextEditingController();
  num? distance = null;
  LatLng? coordinations;
  @override
  void initState() {
    _kilometer.addListener(() {
      var coord = _kilometer.text.split(',');
      if (coord.length == 2) {
        coordinations = LatLng(double.tryParse(coord[0].trim()) ?? 0,
            double.tryParse(coord[1].trim()) ?? 0);
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Column(
            children: [
              ListTile(
                title: Text(S.current.provideClientCoordinations),
                subtitle: CustomFormField(
                  onChanged: () {
                    setState(() {});
                  },
                  controller: _kilometer,
                  hintText: S.current.provideClientCoordinationsHint,
                ),
              ),
              Visibility(
                  visible: coordinations != null,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.amber),
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GeoDistanceText(
                            destination: coordinations ?? LatLng(0, 0),
                            origin: widget.branchLocation,
                            destance: (d, cost) {
                              distance =
                                  num.tryParse(d?.replaceAll(',', '') ?? '');
                              setState(() {});
                            },
                            storeID: -1,
                          )),
                    ),
                  )),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: distance == null || coordinations == null
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        widget.callback(UpdateDistanceRequest(
                          id: widget.id,
                          storeBranchToClientDistance: distance,
                          destination: Destination(
                              lat: coordinations?.latitude,
                              lon: coordinations?.longitude,
                              link: LauncherLinkHelper.getMapsLink(
                                coordinations?.latitude ?? 0.0,
                                coordinations?.longitude ?? 0.0,
                              )),
                        ));
                        _kilometer.clear();
                      },
                child: Text(
                  S.current.confirm,
                  style: Theme.of(context).textTheme.labelLarge,
                )),
            SizedBox(
              width: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _kilometer.clear();
                },
                child: Text(
                  S.current.cancel,
                  style: Theme.of(context).textTheme.labelLarge,
                ))
          ],
        )
      ],
    );
  }
}
