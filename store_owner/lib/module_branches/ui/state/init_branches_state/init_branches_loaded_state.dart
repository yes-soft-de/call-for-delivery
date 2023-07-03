import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branch/branch_model.dart';
import 'package:c4d/module_branches/ui/screens/init_branches/init_branches_screen.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/google_map_widget.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InitAccountStateSelectBranch extends States {
  List<BranchModel> branchLocation = [];
  final TextEditingController _storeController = TextEditingController();

  final InitBranchesScreenState screenState;
  InitAccountStateSelectBranch(this.screenState) : super(screenState) {
    branchLocation = screenState.branchLocation;
    _getMarkers(branchLocation).then((value) {
      screenState.refresh();
    });
    getMyLocation();
  }

  bool window = false;
  Set<Marker> markers = {};
  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
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
                          screenState
                              .customInfoWindowController.onCameraMove!();
                        },
                        onMapCreated: (con) async {
                          screenState.customInfoWindowController
                              .googleMapController = con;
                          await con.setMapStyle(
                              getIt<ThemePreferencesHelper>().getStyleMode());
                          screenState.controller.complete(con);
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
              Positioned(
                bottom: 0,
                child: BottomWidgets(
                  storeController: _storeController,
                  onStartWorkButtonPressed: () {
                    if (branchLocation.length > 0) {
                      screenState.createStoreProfile(
                        ProfileRequest(
                          name: _storeController.text,
                          location: branchLocation[0].location,
                        ),
                      );
                    } else {
                      CustomFlushBarHelper.createError(
                        title: S.current.warnning,
                        message: S.current.pleaseSelectABranch,
                      ).show(screenState.context);
                    }
                  },
                  onUseMyLocationButtonPressed: getMyLocation,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getMyLocation() async {
    var myLocation = await DeepLinksService.defaultLocation();
    if (myLocation != null) {
      LatLng myPos = LatLng(myLocation.latitude, myLocation.longitude);
      screenState.customInfoWindowController.googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(target: myPos, zoom: 15)));
      saveMarker(myPos);
      screenState.refresh();
    }
  }

  void saveMarker(LatLng location) {
    // if (markers.isEmpty) {
    //   showDialog(
    //     context: screenState.context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text(S.current.note),
    //         content: Container(child: Text(S.current.saveBranchAlert)),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         actionsAlignment: MainAxisAlignment.center,
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: Text(S.current.close),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
    branchLocation.clear();
    branchLocation.add(BranchModel(
        location: location, name: '${branchLocation.length + 1}', phone: null));
    screenState.refresh();
    _getMarkers(branchLocation).then((value) => screenState.refresh());
  }

  Future<Set<Marker>> _getMarkers(List<BranchModel> branches) async {
    markers = {};
    for (var branch in branches) {
      markers.add(Marker(
          markerId: MarkerId(branch.name),
          position: LatLng(branch.location.latitude, branch.location.longitude),
          icon: await BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed),
          onTap: () {
            window = true;
            screenState.customInfoWindowController.addInfoWindow!(
              WindowInfoWidget(
                name: branch.name,
              ),
              LatLng(branch.location.latitude, branch.location.longitude),
            );
          }));
    }
    return markers;
  }
}

class BottomWidgets extends StatelessWidget {
  final void Function()? onUseMyLocationButtonPressed;
  final void Function()? onStartWorkButtonPressed;
  final GlobalKey<FormState> _Key = GlobalKey<FormState>();
  final TextEditingController storeController;

  BottomWidgets({
    super.key,
    this.onUseMyLocationButtonPressed,
    required this.storeController,
    this.onStartWorkButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _Key,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width),
        child: Card(
          margin: EdgeInsets.zero,
          color: Color.fromARGB(118, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // location button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.share_location,
                            size: 35,
                          ),
                        ),
                        Text(
                          S.current.useYourCurrentLocation,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white),
                        ),
                        SizedBox()
                      ],
                    ),
                    onPressed: onUseMyLocationButtonPressed,
                  ),
                ),
                SizedBox(height: 10),
                // store name filed
                Text(
                  S.current.enterYourStoreName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromARGB(144, 255, 172, 47),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return S.current.pleaseCompleteField;
                        return null;
                      },
                      controller: storeController,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // start work button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFAC2F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.touch_app,
                            size: 35,
                          ),
                        ),
                        Text(
                          S.current.startWork,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white),
                        ),
                        SizedBox()
                      ],
                    ),
                    onPressed: () {
                      if (_Key.currentState?.validate() ?? false) {
                        if (onStartWorkButtonPressed != null) {
                          onStartWorkButtonPressed!();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
