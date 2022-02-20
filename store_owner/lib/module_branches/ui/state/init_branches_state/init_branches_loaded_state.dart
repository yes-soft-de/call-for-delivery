import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branch/branch_model.dart';
import 'package:c4d/module_branches/ui/screens/init_branches/init_branches_screen.dart';
import 'package:c4d/module_branches/ui/widget/branch_card.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/google_map_widget.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:feature_discovery/feature_discovery.dart';

class InitAccountStateSelectBranch extends States {
  List<BranchModel> branchLocation = [];
  final InitBranchesScreenState screenState;
  InitAccountStateSelectBranch(this.screenState) : super(screenState) {
    branchLocation = screenState.branchLocation;
    _getMarkers(branchLocation).then((value) {
      screenState.refresh();
    });
  }
  bool menu = false;
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
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DescribedFeatureOverlay(
                    featureId:
                        'myLocation', // Unique id that identifies this overlay.
                    tapTarget: Icon(Icons.location_on,
                        color: Theme.of(context)
                            .primaryColor), // The widget that will be displayed as the tap target.
                    title: Text('${S.of(context).myLocation}'),
                    description: Text('${S.of(context).myLocationDescribtion}'),
                    backgroundColor: Theme.of(context).primaryColor,
                    targetColor: Colors.white,
                    textColor: Colors.white,
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
                        var myLocation =
                            await DeepLinksService.defaultLocation();
                        LatLng myPos = LatLng(myLocation?.latitude ?? 0,
                            myLocation?.longitude ?? 0);
                        screenState
                            .customInfoWindowController.googleMapController
                            ?.animateCamera(CameraUpdate.newCameraPosition(
                                CameraPosition(target: myPos, zoom: 15)));
                        saveMarker(myPos);
                        screenState.refresh();
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 55,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DescribedFeatureOverlay(
                    featureId:
                        'selectedMenu', // Unique id that identifies this overlay.
                    tapTarget: Icon(Icons.sort_rounded,
                        color: Theme.of(context)
                            .primaryColor), // The widget that will be displayed as the tap target.
                    title: Text('${S.of(context).selectedBranchesMenu}'),
                    description: Text(
                        '${S.of(context).selectedBranchesMenuDescribtion}'),
                    backgroundColor: Theme.of(context).primaryColor,
                    targetColor: Colors.white,
                    textColor: Colors.white,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                        child: Icon(
                          Icons.sort_rounded,
                          color: branchLocation.isNotEmpty
                              ? Colors.white
                              : Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onPressed: branchLocation.isNotEmpty
                          ? () async {
                              menu = true;
                              screenState.refresh();
                            }
                          : null,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        menu
            ? TweenAnimationBuilder(
                duration: Duration(milliseconds: 350),
                curve: Curves.easeIn,
                tween: Tween<double>(begin: 0, end: 1),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SafeArea(
                          top: true,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        menu = false;
                                        screenState.refresh();
                                      },
                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      S.current.selectedBranchesMenu,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle)),
                                  ],
                                )),
                          ),
                        ),
                        Expanded(
                          child: Scrollbar(
                            child: ListView(
                              physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              children: _getMarkerCards(context),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16.0, left: 16, bottom: 8, top: 1),
                            child: Container(
                              height: 45,
                              width: double.maxFinite,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Center(
                                    child: Text(S.of(context).saveBranches)),
                                onPressed:
                                    branchLocation == null ? null : () {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                builder: (_, double? val, child) {
                  return Transform.scale(
                    scale: val,
                    child: child,
                  );
                },
              )
            : Container()
      ],
    );
  }

  List<Widget> _getMarkerCards(BuildContext context) {
    var branches = <Widget>[];
    for (int i = 0; i < branchLocation.length; i++) {
      branches.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: BranchCard(
              onDelete: () {
                branchLocation.remove(branchLocation[i]);
                _getMarkers(branchLocation);
                screenState.refresh();
              },
              onEdit: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      var nameController = TextEditingController();
                      return Dialog(
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
                            ElevatedButton(
                                child: Text(S.of(context).save),
                                onPressed: () {
                                  if (nameController.text.isNotEmpty) {
                                    Navigator.of(context)
                                        .pop(nameController.text);
                                  }
                                })
                          ],
                        ),
                      );
                    }).then((result) {
                  if (result != null) {
                    branchLocation[i].name = result;
                    screenState.refresh();
                  }
                });
              },
              preview: () {
                menu = false;
                screenState.refresh();
                screenState.customInfoWindowController.googleMapController
                    ?.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: LatLng(branchLocation[i].location.latitude,
                                branchLocation[i].location.longitude),
                            zoom: 15)));
              },
              branchName: branchLocation[i].name)));
    }

    return branches;
  }

  void saveMarker(LatLng location) {
    branchLocation.add(
        BranchModel(location: location, name: '${branchLocation.length + 1}'));
    screenState.refresh();
    _getMarkers(branchLocation).then((value) => screenState.refresh());
    // screenState.createBranch(CreateBrancheRequest(
    //     branchName: '${branchLocation.length + 1}', location: location));
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
