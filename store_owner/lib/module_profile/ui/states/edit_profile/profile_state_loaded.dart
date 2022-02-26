import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/edit_profile/update_profile_state_loaded.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:flutter/material.dart';

class ProfileStateInit extends States {
  final ProfileScreenState screenState;
  final ProfileModel profileModel;
  ProfileStateInit(this.screenState, this.profileModel) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
        appBar: CustomMandoobAppBar.appBar(context, title: S.current.myProfile),
        body: StackedForm(
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
                            imageSource: profileModel.image ?? '',
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
                      profileModel.name,
                      style: TextStyle(
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
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            customListTile(
                                title: S.of(context).name,
                                subTitle: profileModel.name,
                                iconData: Icons.person_rounded),
                            customListTile(
                                title: S.of(context).phoneNumber,
                                subTitle: '+' + profileModel.phone,
                                iconData: Icons.phone),
                            customListTile(
                                title: S.of(context).employeeSize,
                                subTitle: profileModel.employeeCount == '1-20'
                                    ? S.current.smallLessThan20Employee
                                    : profileModel.employeeCount == '20-100'
                                        ? S.current
                                            .mediumMoreThan20EmployeesLessThan100
                                        : S.current.largeMoreThan100Employees,
                                iconData: Icons.people),
                            customListTile(
                                title: S.of(context).myStatus,
                                subTitle: profileModel.status,
                                iconData: Icons.manage_accounts_rounded),
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
              screenState.states =
                  UpdateProfileStateLoaded(screenState, profileModel);
              screenState.refresh();
            }));
  }

  Widget customListTile(
      {required String title, String? subTitle, required IconData iconData}) {
    Widget? icon;
    var context = screenState.context;
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
          ? S.current.accountActivated
          : S.current.accountInActivated;
    }
    return ListTile(
      leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(iconData,
                color: Theme.of(context).colorScheme.primaryContainer),
          )),
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
}
