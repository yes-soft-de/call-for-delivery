import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/model/packages.model.dart';
import 'package:c4d/module_subscription/model/packages_categories_model.dart';
import 'package:c4d/module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart';
import 'package:c4d/module_subscription/ui/widget/package_card/package_card.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InitSubscriptionsLoadedState extends States {
  List<PackageCategoriesModel> packages;
  final InitSubscriptionScreenState screenState;
  InitSubscriptionsLoadedState(this.screenState, this.packages)
      : super(screenState);
  int? _selectedPackageId;
  String? _selectedCity;
  String? _selectedCategories;
  List<PackageModel> _packages = [];

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.storeAccountInit, canGoBack: false),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            // info
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.primary),
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Theme.of(context).textTheme.button?.color,
                  ),
                  title: Text(
                    S.current.chooseYourPackageHint + ' . ',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DottedLine(
                dashColor: Theme.of(context).backgroundColor,
                lineThickness: 4,
              ),
            ),
            // categories
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                        value: _selectedCategories,
                        items: _getCatagories(),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        hint: Text(S.current.choosePackageCategories),
                        onChanged: (String? value) {
                          _packages = packages
                              .singleWhere(
                                  (element) => element.id.toString() == value)
                              .packages;
                          _selectedCategories = value;
                          screenState.refresh();
                        }),
                  ),
                ),
              ),
            ),
            // there is no packages available in this category
            Visibility(
                visible: _packages.isEmpty && _selectedCategories != null,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        S.current.emptyPackagesCategory,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SvgPicture.asset(
                        SvgAsset.EMPTY_SVG,
                        width: 125,
                        height: 125,
                      )
                    ],
                  ),
                )),
            // City
            Visibility(
              visible: _packages.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).backgroundColor),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                          value: _selectedCity,
                          items: _getCities(),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          hint: Text(S.current.chooseYourCity),
                          onChanged: (String? value) {
                            _selectedCity = value;
                            screenState.refresh();
                          }),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            //package
            Visibility(
              visible: _selectedCity != null,
              child: ScalingWidget(
                fade: true,
                milliseconds: 1000,
                child: SizedBox(
                  height: 375,
                  child: ListView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.horizontal,
                    children: _getPackages(_selectedCity),
                  ),
                ),
              ),
            ),
            // Submit Package
            Visibility(
              visible: _selectedPackageId != null,
              child: ScalingWidget(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                      onPressed: () {
                        screenState.subscribeToPackage(
                          _selectedPackageId!,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          S.of(context).next,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 75,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getPackages(String? city) {
    if (_packages == null) {
      return [];
    }
    if (_packages.isEmpty) {
      return [];
    }
    if (_selectedCity == null) {
      return [];
    }
    List<PackageModel> cityPackage = [];
    for (int i = 0; i < _packages.length; i++) {
      if (_packages[i].city == city) {
        cityPackage.add(_packages[i]);
      }
    }
    return cityPackage.map((element) {
      return GestureDetector(
        onTap: () {
          if (element.id == _selectedPackageId) {
            _selectedPackageId = null;
          } else {
            _selectedPackageId = element.id;
          }
          screenState.refresh();
        },
        child: PackageCard(
          package: element,
          active: element.id == _selectedPackageId,
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> _getCities() {
    var cityNames = <String>[];
    _packages.forEach((element) {
      cityNames.add('${element.city}');
    });

    var cityDropDown = <DropdownMenuItem<String>>[];
    cityNames.forEach((element) {
      cityDropDown.add(DropdownMenuItem(
        child: Text(
          element,
          overflow: TextOverflow.ellipsis,
        ),
        value: element,
      ));
    });

    return cityDropDown;
  }

  List<DropdownMenuItem<String>> _getCatagories() {
    var cityDropDown = <DropdownMenuItem<String>>[];
    packages.forEach((element) {
      cityDropDown.add(DropdownMenuItem(
        child: Text(
          element.name,
          overflow: TextOverflow.ellipsis,
        ),
        value: element.id.toString(),
      ));
    });
    return cityDropDown;
  }
}
