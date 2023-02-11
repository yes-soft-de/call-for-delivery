import 'package:badges/badges.dart' as badges;
import 'package:c4d/module_profile/ui/widget/image_tile.dart';
import 'package:flutter/material.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/components/stacked_form.dart';

class ProfileWidget extends StatefulWidget {
  final Function() updateProfile;
  final ProfileRequest request;

  ProfileWidget({
    required this.updateProfile,
    required this.request,
  });

  @override
  State<StatefulWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  Widget customListTile(
      {required String title, String? subTitle, required IconData iconData}) {
    Widget? icon;
    if (title == S.current.myStatus) {
      icon = PhysicalModel(
          color: Theme.of(context).scaffoldBackgroundColor,
          elevation: 5,
          shape: BoxShape.circle,
          child: Icon(
            Icons.circle,
            color: subTitle == 'active' ? Colors.green : Colors.red,
            size: 30,
          ));
      subTitle = subTitle == 'active'
          ? S.current.captainStateActive
          : S.current.captainStateInactive;
    }
    return ListTile(
      leading: badges.Badge(
        showBadge: subTitle != null ? false : true,
        position: badges.BadgePosition.topEnd(top: -1, end: -1),
        badgeStyle: const badges.BadgeStyle(
          badgeColor:Colors.amber 
        ),
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(iconData, color: Colors.white),
            )),
      ),
      title: Text(
        title,
      ),
      trailing: icon,
      subtitle: Text(
        subTitle ?? S.current.unknown,
        textDirection: S.current.phoneNumber == title &&
                Localizations.localeOf(context).languageCode == 'ar'
            ? TextDirection.ltr
            : null,
        textAlign: S.current.phoneNumber == title &&
                Localizations.localeOf(context).languageCode == 'ar'
            ? TextAlign.right
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StackedForm(
        child: CustomListView.custom(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.maxFinite,
                height: 175,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      width: 175,
                      height: 175,
                      child: CustomNetworkImage(
                        imageSource: widget.request.image ?? '',
                        width: double.maxFinite,
                        height: double.maxFinite,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.request.name ?? S.current.username,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        customListTile(
                            title: S.of(context).name,
                            subTitle: widget.request.name,
                            iconData: Icons.person_rounded),
                        customListTile(
                            title: S.of(context).age,
                            subTitle: widget.request.age,
                            iconData: Icons.date_range_rounded),
                        customListTile(
                            title: S.of(context).phoneNumber,
                            subTitle: widget.request.phone,
                            iconData: Icons.phone),
                        customListTile(
                            title: S.of(context).neighborhood,
                            subTitle: widget.request.address,
                            iconData: Icons.location_on),
                        customListTile(
                            title: S.of(context).city,
                            subTitle: widget.request.city,
                            iconData: Icons.location_city),
                        customListTile(
                            title: S.of(context).car,
                            subTitle: widget.request.car,
                            iconData: Icons.local_taxi_rounded),
                        customListTile(
                            title: S.of(context).bankName,
                            subTitle: widget.request.bankName,
                            iconData: Icons.monetization_on_rounded),
                        customListTile(
                            title: S.of(context).bankAccountNumber,
                            subTitle: widget.request.bankAccountNumber,
                            iconData: Icons.password_rounded),
                        customListTile(
                            title: S.of(context).stcPayCode,
                            subTitle: widget.request.stcPay,
                            iconData: Icons.credit_card_rounded),
                        customListTile(
                            title: S.of(context).myStatus,
                            subTitle: widget.request.isOnline == true
                                ? 'active'
                                : 'inactive',
                            iconData: Icons.wifi_rounded),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Flex(
                            direction: Axis.vertical,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ImageTile(
                                  title: S.current.identity,
                                  image: widget.request.identity ?? ''),
                              ImageTile(
                                  title: S.current.mechanichLicence,
                                  image: widget.request.mechanicLicense ?? ''),
                              ImageTile(
                                  title: S.current.driverLicence,
                                  image: widget.request.drivingLicence ?? ''),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              height: 75,
            )
          ],
        ),
        label: S.current.updateProfile,
        onTap: () {
          widget.updateProfile();
        });
  }
}
