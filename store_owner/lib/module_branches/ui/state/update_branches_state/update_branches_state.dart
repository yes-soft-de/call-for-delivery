import 'dart:math';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_branches/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_branches/response/branches/branches_response.dart';
import 'package:c4d/module_branches/ui/screens/update_branches_screen/update_branches_screen.dart';
import 'package:c4d/module_branches/ui/widget/branch_card.dart';
import 'package:c4d/module_branches/ui/widget/edit_branch_dialog.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/google_map_widget.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as la;

class UpdateBranchStateLoaded extends States {
  final UpdateBranchScreenState screenState;
  UpdateBranchStateLoaded(
    this.screenState,
  ) : super(screenState) {
    _getMarkers(screenState.context).then((value) {
      markers = value;
      screenState.refresh();
    });
  }
  Set<Marker> markers = {};

  BranchesModel? branchLocation;
  bool initFlag = true;
  bool flag = true;
  BranchesModel? model;
  bool window = false;
  @override
  Widget getUI(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    BranchesModel? branchesModel = args is BranchesModel ? args : null;
    if (initFlag && branchesModel != null) {
      branchLocation = branchesModel;
      model = branchesModel;
      initFlag = false;
      _getMarkers(context).then((value) {
        markers = value;
        screenState.refresh();
      });
    }
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
                        if (window) {
                          window = false;
                          screenState
                              .customInfoWindowController.hideInfoWindow!();
                        } else {
                          saveMarker(position);
                        }
                      },
                      onCameraMove: (position) {
                        screenState.customInfoWindowController.onCameraMove!();
                      },
                      onMapCreated: (con) async {
                        try {
                          screenState.customInfoWindowController
                              .googleMapController = con;
                          await con.setMapStyle(
                              getIt<ThemePreferencesHelper>().getStyleMode());
                          screenState.controller.complete(con);
                        } catch (e) {}
                      },
                    ),
                  ),
                  CustomInfoWindow(
                    controller: screenState.customInfoWindowController,
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
                    const EdgeInsets.only(bottom: 182.0, right: 8, left: 8),
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
                    var myLocation = await DeepLinksService.defaultLocation();
                    LatLng myPos = LatLng(
                        myLocation?.latitude ?? 0, myLocation?.longitude ?? 0);
                    screenState.customInfoWindowController.googleMapController
                        ?.animateCamera(CameraUpdate.newCameraPosition(
                            CameraPosition(target: myPos, zoom: 15)));
                    saveMarker(myPos);
                    screenState.refresh();
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 175,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                    color: Theme.of(context).scaffoldBackgroundColor),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 8,
                    ),
                    Container(height: 75, child: _getMarkerCards(context)),
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
                          child: Text(S.of(context).saveBranch),
                          onPressed: branchLocation == null
                              ? null
                              : () {
                                  if (flag && branchesModel == null) {
                                    screenState.createBranch(
                                        CreateBranchRequest(
                                            branchName:
                                                branchLocation?.branchName,
                                            phone: branchLocation?.branchPhone,
                                            location: GeoJson(
                                                lat: branchLocation
                                                    ?.location.latitude,
                                                lon: branchLocation
                                                    ?.location.longitude)));
                                  } else {
                                    screenState.updateBranch(
                                        UpdateBranchesRequest(
                                            branchName:
                                                branchLocation?.branchName,
                                            location: branchLocation?.location,
                                            city: branchLocation?.city,
                                            id: branchesModel?.id,
                                            phone:
                                                branchLocation?.branchPhone));
                                  }
                                },
                        ),
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
    return BranchCard(
        onDelete: () {
          branchLocation = null;
          model = null;
          if (flag == false) {
            flag = true;
          }
          _getMarkers(context).then((value) {
            markers = value;
            screenState.refresh();
          });
        },
        onEdit: () {
          showDialog(
              context: context,
              builder: (_) {
                return EditBranchDialog(
                  branchName: branchLocation?.branchName ?? '',
                  phoneNumber: branchLocation?.branchPhone ?? '',
                );
              }).then((result) {
            if (result != null) {
              branchLocation?.branchName = result?.name;
              if (result.phone != '') {
                branchLocation?.branchPhone = result?.phone;
              }
              screenState.refresh();
            }
          });
        },
        preview: () {
          screenState.refresh();
          screenState.customInfoWindowController.googleMapController
              ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(branchLocation?.location.latitude ?? 0,
                      branchLocation?.location.longitude ?? 0),
                  zoom: 15)));
        },
        branchName: branchLocation?.branchName ?? S.current.branch);
  }

  Future<Set<Marker>> _getMarkers(BuildContext context) async {
    if (branchLocation == null) return {};
    return {
      Marker(
          markerId: MarkerId(
              branchLocation?.branchName ?? Random().nextInt(1000).toString()),
          position: LatLng(branchLocation?.location.latitude ?? 0,
              branchLocation?.location.longitude ?? 0),
          icon: await BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed),
          onTap: () {
            window = true;
            screenState.customInfoWindowController.addInfoWindow!(
              WindowInfoWidget(
                name: branchLocation?.branchName ?? S.current.branch,
              ),
              LatLng(branchLocation?.location.latitude ?? 0,
                  branchLocation?.location.longitude ?? 0),
            );
          })
    };
  }

  Future<void> saveMarker(LatLng location) async {
    if (branchLocation == null) {
      branchLocation = model ?? BranchesModel.empty();
      branchLocation?.location =
          la.LatLng(location.latitude, location.longitude);
      branchLocation?.branchName = '${S.current.branch} 1';
    } else {
      branchLocation?.location =
          la.LatLng(location.latitude, location.longitude);
    }
    markers = await _getMarkers(screenState.context);
    screenState.refresh();
  }
}
