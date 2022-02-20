import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_branches/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_branches/ui/screens/update_branches_screen/update_branches_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as lat;

class UpdateBranchStateLoading extends States {
  UpdateBranchStateLoading(UpdateBranchScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class UpdateBranchStateError extends States {
  String errorMsg;

  UpdateBranchStateError(
    this.errorMsg,
    UpdateBranchScreenState screenState,
  ) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('${errorMsg}'),
    );
  }
}

class UpdateBranchStateLoaded extends States {
  final UpdateBranchScreenState screenState;
  UpdateBranchStateLoaded(
    this.screenState,
  ) : super(screenState);
  BranchesModel? branchLocation;
  final _mapController = MapController();
  bool flag = true;
  BranchesModel? model;
  @override
  Widget getUI(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    BranchesModel? branchesModel = args is BranchesModel ? args : null;
    if (flag && branchesModel != null) {
      branchLocation = branchesModel;
      model = branchesModel;
      flag = false;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center:
                    branchLocation?.location ?? LatLng(21.5429423, 39.1690945),
                zoom: 15.0,
                onTap: (newPos) {
                  saveMarker(newPos);
                  screenState.refresh();
                },
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://mt.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers:
                      branchLocation == null ? [] : _getMarkers(context) ?? [],
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 182.0, right: 8, left: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.my_location,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      Location location = new Location();

                      bool _serviceEnabled = await location.serviceEnabled();
                      if (!_serviceEnabled) {
                        _serviceEnabled = await location.requestService();
                      }

                      var _permissionGranted =
                          await location.requestPermission();
                      if (_permissionGranted == PermissionStatus.denied) {
                        return;
                      }

                      var myLocation = await Location.instance.getLocation();
                      LatLng myPos = LatLng(
                          myLocation.latitude ?? 0, myLocation.longitude ?? 0);
                      _mapController.move(myPos, 15);
                      saveMarker(myPos);
                      screenState.refresh();
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 175,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    color: Theme.of(context).scaffoldBackgroundColor),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 8,
                    ),
                    Container(height: 60, child: _getMarkerCards(context)),
                    Container(
                      height: 55,
                      width: double.maxFinite,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text(S.of(context).saveBranch),
                        onPressed: branchLocation == null
                            ? null
                            : () {
                                if (flag) {
                                  screenState.createBranch(CreateBrancheRequest(
                                      branchName: branchLocation?.branchName,
                                      location: lat.LatLng(
                                          branchLocation?.location.latitude??0,
                                          branchLocation?.location.longitude??0)));
                                } else {
                                  screenState.updateBranch(
                                      UpdateBranchesRequest(
                                          branchName:
                                              branchLocation?.branchName,
                                          location: branchLocation?.location,
                                          city: branchLocation?.city,
                                          id: branchLocation?.id));
                                }
                              },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }

  Widget _getMarkerCards(BuildContext context) {
    if (branchLocation == null) return SizedBox();
    return Card(
      elevation: 3,
      color: Colors.green,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8),
                child: Text(
                  '${branchLocation?.branchName}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              )),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            var nameController = TextEditingController();
                            return AlertDialog(
                              title: Text(
                                S.of(context).editBranchName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              content: Container(
                                height: 150,
                                child: Flex(
                                  direction: Axis.vertical,
                                  children: [
                                    TextFormField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        hintText: S.of(context).newName,
                                        labelText: S.of(context).newName,
                                      ),
                                      validator: (name) {
                                        if (name?.isEmpty == true) {
                                          return S.of(context).nameIsRequired;
                                        }
                                        return null;
                                      },
                                    ),
                                    RaisedButton(
                                        child: Text(S.of(context).save),
                                        onPressed: () {
                                          if (nameController.text.isNotEmpty) {
                                            Navigator.of(context)
                                                .pop(nameController.text);
                                          }
                                        })
                                  ],
                                ),
                              ),
                            );
                          }).then((result) {
                        if (result != null) {
                          branchLocation?.branchName = result;
                          screenState.refresh();
                        }
                      });
                      screenState.refresh();
                    }),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      branchLocation = null;
                      screenState.refresh();
                    }),
                IconButton(
                    icon: Icon(
                      Icons.my_location,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _mapController.move(
                          branchLocation?.location ?? LatLng(0, 0), 15);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Marker>? _getMarkers(BuildContext context) {
    if (branchLocation == null) return null;
    return [
      Marker(
        point: branchLocation?.location ?? LatLng(0, 0),
        builder: (ctx) => Container(
          child: Icon(
            Icons.my_location,
            color: Colors.green,
          ),
        ),
      )
    ];
  }

  void saveMarker(LatLng location) {
    branchLocation = model ?? BranchesModel.empty();
    branchLocation?.location = location;
    branchLocation?.branchName = '1';
  }
}
