import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:c4d/module_profile/ui/states/profile_state_got_profile/profile_state_got_profile.dart';
import 'package:c4d/module_profile/ui/widget/profile_form/profile_form.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';

class ProfileStateDirtyProfile extends ProfileState {
  ProfileRequest request;
  bool backToProfile;
  ProfileStateDirtyProfile(EditProfileScreenState screenState, this.request,
      {this.backToProfile = false})
      : super(screenState) {
    if (this.backToProfile) {
      request.canGoBack = backToProfile;
    }
  }

  @override
  Widget getUI(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (backToProfile) {
          await showDialog(
              context: context,
              builder: (_) {
                return CustomAlertDialog(
                  onPressed: () {
                    Navigator.of(context).pop();
                    screenState.states =
                        ProfileStateGotProfile(screenState, request);
                    screenState.refresh();
                  },
                  content: S.current.areYouSureToDisposeThis,
                );
              });
        }
        return !backToProfile;
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.updateProfile,
            onTap: backToProfile
                ? () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return CustomAlertDialog(
                            onPressed: () {
                              Navigator.of(context).pop();
                              screenState.states =
                                  ProfileStateGotProfile(screenState, request);
                              screenState.refresh();
                            },
                            content: S.current.areYouSureToDisposeThis,
                          );
                        });
                  }
                : null),
        body: ProfileFormWidget(
          profileRequest: request,
          onProfileSaved: (profile) {
            ProfileRequest profileRequest = ProfileRequest(
                name: profile.name,
                image: profile.image,
                phone: profile.phone,
                drivingLicence: profile.drivingLicence,
                bankName: profile.bankName,
                bankAccountNumber: profile.bankNumber,
                stcPay: profile.stcPay,
                car: profile.car,
                age: profile.age.toString(),
                mechanicLicense: profile.mechanicLicense,
                identity: profile.identity,
                isOnline: profile.isOnline,
                canGoBack: request.canGoBack,
                address: profile.address);
            screenState.saveProfile(profileRequest);
          },
          onImageUpload: (profile, type, image) {
            ProfileRequest profileRequest = ProfileRequest(
                name: profile.name,
                image: profile.image,
                phone: profile.phone,
                drivingLicence: profile.drivingLicence,
                bankName: profile.bankName,
                bankAccountNumber: profile.bankNumber,
                stcPay: profile.stcPay,
                car: profile.car,
                age: profile.age.toString(),
                mechanicLicense: profile.mechanicLicense,
                identity: profile.identity,
                isOnline: profile.isOnline,
                canGoBack: request.canGoBack,
                address: profile.address);
            screenState.uploadImage(profileRequest, type, image);
          },
        ),
      ),
    );
  }
}
