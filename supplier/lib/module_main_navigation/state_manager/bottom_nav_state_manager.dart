import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/model/company_info_model.dart';
import 'package:c4d/module_about/service/about_service/about_service.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class BottomNavStateManager {

  final AuthService _authService;
  final ProfileService _profileService;
  final AboutService _aboutService;

  final PublishSubject<ProfileModel> _profileSubject = PublishSubject();
  final PublishSubject<CompanyInfoModel> _companySubject = PublishSubject();


  Stream<ProfileModel> get profileStream => _profileSubject.stream;
  Stream<CompanyInfoModel> get companyStream => _companySubject.stream;

  BottomNavStateManager(
      this._authService,
      this._profileService, this._aboutService,
      );


  Future<void> initDrawerData() async {
    await getProfile();
    await getCompanyInfo();
  }

  Future<void> getProfile() async {
    try {
      // profile
      var profile = await _profileService.getProfile();
      if (profile.hasError) {
        Fluttertoast.showToast(
          msg: profile.error ?? S.current.errorHappened,
          backgroundColor: Colors.red,
        );
      } else {
        profile as ProfileModel;
        _profileSubject.add(profile.data);
      }
    } catch (e) {
      return;
    }
  }

  Future<void> getCompanyInfo() async {
    try {
      // company info
      var company = await _aboutService.getCompanyInfo();
      if (company.hasError) {
        Fluttertoast.showToast(
          msg: company.error ?? S.current.errorHappened,
          backgroundColor: Colors.red,
        );
      } else {
        company as CompanyInfoModel;
        _companySubject.add(company.data);
      }
    } catch (e) {
      return;
    }
  }
}