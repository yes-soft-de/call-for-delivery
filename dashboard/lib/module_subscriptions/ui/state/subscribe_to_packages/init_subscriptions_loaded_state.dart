import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_categories/model/packages_model.dart';
import 'package:c4d/module_subscriptions/request/store_subscribe_to_package.dart';
import 'package:c4d/module_subscriptions/ui/screen/init_subscription_screen.dart';
import 'package:c4d/module_subscriptions/ui/widget/package_card/package_card.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InitSubscriptionsLoadedState extends States {
  List<PackagesModel> packages;
  List<PackagesCategoryModel> categories;
  final CreateSubscriptionScreenState screenState;
  InitSubscriptionsLoadedState(this.screenState, this.categories, this.packages)
      : super(screenState) {
    screenState.categories = categories;
  }
  int? _selectedPackageId;
  String? _selectedCity;
  String? _selectedCategories;
  String? appBarTitle;
  @override
  Widget getUI(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      appBarTitle = args;
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: appBarTitle ?? S.current.storeAccountInit,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
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
                    child: DropdownButton(
                        value: _selectedCategories,
                        items: _getCatagories(),
                        hint: Text(S.current.chooseCategory),
                        onChanged: (String? value) {
                          _selectedCity = null;
                          _selectedPackageId = null;
                          // call for packages
                          _selectedCategories = value;
                          screenState.getPackages(
                              int.tryParse(_selectedCategories ?? '') ?? -1);
                          screenState.refresh();
                        }),
                  ),
                ),
              ),
            ),
            // there is no packages available in this category
            Visibility(
                visible: packages.isEmpty && _selectedCategories != null,
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
              visible: packages.isNotEmpty,
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
                      child: DropdownButton(
                          value: _selectedCity,
                          items: _getCities(),
                          hint: Text(S.current.chooseYourCity),
                          onChanged: (String? value) {
                            _selectedPackageId = null;
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
                  height: 425,
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
                          StoreSubscribeToPackageRequest(
                              packageId: _selectedPackageId,
                              storeOwnerProfileId: screenState.storeID),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          S.of(context).subscribe,
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
    if (packages == null) {
      return [];
    }
    if (packages.isEmpty) {
      return [];
    }
    if (_selectedCity == null) {
      return [];
    }
    List<PackagesModel> cityPackage = [];
    for (int i = 0; i < packages.length; i++) {
      if (packages[i].city == city) {
        cityPackage.add(packages[i]);
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
          short: false,
          package: element,
          active: element.id == _selectedPackageId,
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> _getCities() {
    var cityNames = <String>[];
    packages.forEach((element) {
      if (cityNames.contains(element.city) == false) {
        cityNames.add('${element.city}');
      }
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
    var categoriesDropDown = <DropdownMenuItem<String>>[];
    categories.forEach((element) {
      categoriesDropDown.add(DropdownMenuItem(
        child: Text(
          element.categoryName,
          overflow: TextOverflow.ellipsis,
        ),
        value: element.id.toString(),
      ));
    });
    return categoriesDropDown;
  }
}
