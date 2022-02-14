import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/hive/about_hive_helper.dart';
import 'package:c4d/module_about/model/package_model.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:c4d/module_about/ui/widget/welcome_card.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutStatePageOwner extends AboutState {
  int currentPage = 0;
  final _pageController = PageController(initialPage: 0);
  List<PackageModel> packages;

  AboutStatePageOwner(AboutScreenState screenState, this.packages)
      : super(screenState);
  String? _selectedCity;
  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (pos) {
            currentPage = pos;
            _pageController.animateToPage(pos,
                duration: Duration(milliseconds: 250), curve: Curves.easeIn);
            screenState.refresh();
          },
          children: [
            WelcomeCard(
                image: ImageAsset.OPEN_APP,
                label: S.current.launch,
                description: S.current.lanchDescribtion),
            WelcomeCard(
                image: ImageAsset.BOOK_CAR,
                label: S.current.bookACar,
                description: S.current.bookACarDescribtion),
            WelcomeCard(
                image: ImageAsset.WE_DELIVER,
                label: S.current.weDeliver,
                description: S.current.weDeliverDescribtion),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    S.of(context).ourPackages,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Container(
                    width: 150,
                    child: DropdownButtonFormField(
                        value: _selectedCity,
                        decoration: InputDecoration(
                          hintText: S.of(context).chooseYourCity,
                        ),
                        items: _getCities(),
                        onChanged: (value) {
                          _selectedCity = value.toString();
                          screenState.refresh();
                        }),
                  ),
                ),
                Container(
                  height: 275,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _selectedCity == null
                        ? _getPackagesCards()
                        : _getPackages(_selectedCity),
                  ),
                ),
                Flex(
                  direction: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        S
                            .of(context)
                            .toFindOutMorePleaseLeaveYourPhonenandWeWill,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //screenState.requestBooking();
                      },
                      child: Text(
                        S.of(context).requestMeeting,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 16,
                ),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 18,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentPage != 3
                    ? TextButton(
                        onPressed: () {
                          AboutHiveHelper().setWelcome();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AuthorizationRoutes.REGISTER_SCREEN,
                              (route) => false);
                        },
                        child: Text(S.current.skip))
                    : Text(
                        '${S.of(context).skip}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.transparent.withOpacity(0),
                        ),
                      ),
                getIndicator(context),
                TextButton(
                    onPressed: () {
                      if (currentPage == 3) {
                        AboutHiveHelper().setWelcome();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AuthorizationRoutes.REGISTER_SCREEN,
                            (route) => false);
                      } else {
                        _pageController.animateToPage(currentPage + 1,
                            duration: Duration(milliseconds: 750),
                            curve: Curves.easeIn);
                      }
                    },
                    child: Text(S.current.next))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget getIndicator(context) {
    var circles = <Widget>[];
    for (int i = 0; i < 4; i++) {
      double size = i == currentPage ? 10 : 6;
      circles.add(Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              color: i == currentPage
                  ? Theme.of(context).primaryColor
                  : Color.fromRGBO(236, 239, 241, 1),
              shape: BoxShape.circle),
        ),
      ));
    }
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: circles,
    );
  }

  List<Widget> _getPackagesCards() {
    var packagesCards = <Widget>[];
    packages.forEach((package) {
      // packagesCards.add(PackageCard(
      //   package: package,
      //   active: false,
      // ));
    });
    return packagesCards;
  }

  List<DropdownMenuItem<String>> _getCities() {
    var cityNames = <String>{};
    packages.forEach((element) {
      //   cityNames.add('${element.city}');
    });
    //  cityNames.add(S.current.allcity);
    var cityDropDown = <DropdownMenuItem<String>>[];
    cityNames.forEach((element) {
      cityDropDown.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });

    return cityDropDown;
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
    List<PackageModel> cityPackage = [];
    for (int i = 0; i < packages.length; i++) {
      // if (packages[i].city == city || city == S.current.allcity) {
      //   cityPackage.add(packages[i]);
      // }
    }
    return [];
    // return cityPackage.map((element) {
    //   return PackageCard(
    //     package: element,
    //     active: false,
    //   );
    // }).toList();
  }
}
