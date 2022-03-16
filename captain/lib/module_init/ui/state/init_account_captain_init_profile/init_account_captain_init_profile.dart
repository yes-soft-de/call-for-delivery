import 'dart:io';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/faded_button_bar.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:the_country_number/the_country_number.dart';

import '../../widget/get_image_path.dart';
import '../../widget/init_field/init_field.dart';

class InitAccountCaptainInitProfile extends States {
  Uri? captainImage;
  Uri? driverLicence;
  Uri? mechanicLicence;
  Uri? identity;
  final InitAccountScreenState screen;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _carController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final _stcPayController = TextEditingController();
  final _countryCodeController = TextEditingController();

  InitAccountCaptainInitProfile(this.screen) : super(screen) {
    var number = getIt<AuthService>().username;
    if (number.isNotEmpty) {
      final sNumber =
          TheCountryNumber().parseNumber(internationalNumber: '+' + number);
      _countryCodeController.text = sNumber.dialCode.substring(1);
      _phoneController.text = sNumber.number;
      screen.refresh();
    }
  }

  final GlobalKey<FormState> _initKey = GlobalKey<FormState>();

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _initKey,
        child: Stack(
          children: [
            CustomListView.custom(
              children: [
                // captain image
                MediaQuery.of(context).viewInsets.bottom != 0
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            ImagePicker.platform
                                .getImage(source: ImageSource.gallery)
                                .then((value) {
                              if (value != null) {
                                captainImage = Uri(path: value.path);
                                screen.refresh();
                              }
                            });
                          },
                          child: Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                children: [
                                  const Positioned.fill(
                                      child: Icon(Icons.person,
                                          size: 45, color: Colors.white)),
                                  _getCaptainImageFG(),
                                ],
                              )),
                        ),
                      ),
                Center(
                  child: Text(S.current.chooseCaptainProfile,
                      style: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontWeight: FontWeight.bold)),
                ),
                // name
                InitField(
                  controller: _nameController,
                  icon: Icons.person,
                  hint: S.current.eg + ' : ' + S.current.nameHint,
                  title: S.current.captainName,
                ),
                // phone
                Padding(
                  padding: const EdgeInsets.only(left: 80, right: 80, top: 32),
                  child: Text(
                    S.of(context).phoneNumber +
                        ' ' +
                        '(${S.current.phoneNumberThatShowsForCaptain})',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 26.0, right: 16.0, left: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.phone,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomLoginFormField(
                        controller: _phoneController,
                        hintText: '5xxxxxxxxx',
                        phone: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 28.0),
                      child: SizedBox(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomLoginFormField(
                            contentPadding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            controller: _countryCodeController,
                            phone: true,
                            phoneHint: false,
                            maxLength: 3,
                            halfField: true,
                            hintText: S.current.countryCode,
                            sufIcon: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: Container(
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor),
                                child: Center(
                                  child: Text(
                                    '+',
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // age
                InitField(
                  controller: _ageController,
                  icon: Icons.calendar_month_rounded,
                  hint: S.current.eg + ' : ' + '36',
                  title: S.current.age,
                  number: true,
                ),
                // car
                InitField(
                  controller: _carController,
                  icon: Icons.local_taxi_rounded,
                  hint: S.current.eg + ' : ' + 'Kia Rio',
                  title: S.current.car,
                  last: true,
                ),
                // Identity
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        S.of(context).identity,
                        style: TextStyle(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                GetImagePath(
                  callBack: (uri) {
                    identity = uri;
                    screen.refresh();
                  },
                  imagePath: identity,
                ),
                // Driver Licence
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        S.of(context).driverLicence,
                        style: TextStyle(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                GetImagePath(
                  callBack: (uri) {
                    driverLicence = uri;
                    screen.refresh();
                  },
                  imagePath: driverLicence,
                ), // Mechanic Licence
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        S.of(context).mechanichLicence,
                        style: TextStyle(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                GetImagePath(
                  callBack: (uri) {
                    mechanicLicence = uri;
                    screen.refresh();
                  },
                  imagePath: mechanicLicence,
                ),
                Container(
                  height: 24,
                ),
                // Bank name
                InitField(
                  controller: _bankNameController,
                  icon: Icons.account_balance_rounded,
                  hint: S.current.eg + ' : ' + S.current.bankNameHint,
                  title: S.current.bankName,
                ),
                // Bank Account Number
                InitField(
                  controller: _bankAccountNumberController,
                  icon: Icons.password_rounded,
                  hint: S.current.eg + ' : ' + '3123235145313',
                  title: S.current.bankAccountNumber,
                ),
                // Stc Pay
                InitField(
                    controller: _stcPayController,
                    icon: Icons.credit_card_rounded,
                    hint: S.current.eg + ' : ' + '059796748',
                    title: S.current.stcPayCode,
                    last: true),
                const SizedBox(
                  height: 75,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                child: FadedButtonBar(
                  text: S.of(context).uploadAndSubmit,
                  onPressed: () {
                    if (_initKey.currentState!.validate()) {
                      if (identity != null &&
                          driverLicence != null &&
                          captainImage != null &&
                          mechanicLicence != null) {
                        screen.submitProfile(
                            CreateCaptainProfileRequest.withUriImages(
                                name: _nameController.text.trim(),
                                age: int.parse(_ageController.text),
                                car: _carController.text,
                                captainImage: captainImage,
                                driving: driverLicence,
                                mechanic: mechanicLicence,
                                idImage: identity,
                                phone: _countryCodeController.text +
                                    _phoneController.text,
                                bankAccountNumber:
                                    _bankAccountNumberController.text,
                                bankName: _bankNameController.text,
                                stcPay: _stcPayController.text));
                      } else {
                        if (captainImage == null) {
                          CustomFlushBarHelper.createError(
                                  title: S.current.warnning,
                                  message: S.current.pleaseProvideProfileImage)
                              .show(context);
                        }
                        if (mechanicLicence == null) {
                          CustomFlushBarHelper.createError(
                                  title: S.current.warnning,
                                  message: S.current.pleaseProvideMechImage)
                              .show(context);
                        }
                        if (identity == null) {
                          CustomFlushBarHelper.createError(
                                  title: S.current.warnning,
                                  message: S.current.pleaseProvideIdentityImage)
                              .show(context);
                        }
                        if (driverLicence == null) {
                          CustomFlushBarHelper.createError(
                                  title: S.current.warnning,
                                  message: S.current.pleaseProvideDrivingImage)
                              .show(context);
                        }
                      }
                    } else {
                      CustomFlushBarHelper.createError(
                              title: S.current.warnning,
                              message: S.current.pleaseCompleteTheForm)
                          .show(context);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCaptainImageFG() {
    if (captainImage != null) {
      return Container(
          decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: FileImage(File.fromUri(captainImage!)),
          fit: BoxFit.cover,
        ),
      ));
    } else {
      return Container();
    }
  }
}
