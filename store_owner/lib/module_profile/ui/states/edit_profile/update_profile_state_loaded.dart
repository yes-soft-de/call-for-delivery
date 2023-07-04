import 'dart:typed_data';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/widget/init_field/init_field.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/effect/checked.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:the_country_number/the_country_number.dart';

class UpdateProfileStateLoaded extends States {
  final ProfileScreenState screenState;
  final ProfileModel profileModel;
  UpdateProfileStateLoaded(this.screenState, this.profileModel)
      : super(screenState) {
    var number = profileModel.phone;
    if (number == S.current.unknown) number = '';
    if (number.isNotEmpty || number != '') {
      final sNumber =
          TheCountryNumber().parseNumber(internationalNumber: '+' + number);
      if (sNumber.dialCode.length > 0) {
        _countryController.text = sNumber.dialCode.substring(1);
      }
      _phoneController.text = sNumber.number;
    }
    openingTime = profileModel.openingTime;
    closingTime = profileModel.closingTime;
    _bankNameController.text = profileModel.bankName;
    _bankNumberController.text = profileModel.bankNumber;
    _cityController.text = profileModel.city;
    selectedSize = profileModel.employeeCount;
    networkImage = profileModel.image;
    imagePath = profileModel.imageUrl;
  }
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _bankNumberController = TextEditingController();
  String? selectedSize;
  String? imagePath;
  String? networkImage;
  Uint8List? imageBytes;
  DateTime? openingTime;
  DateTime? closingTime;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget getUI(BuildContext context) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();
    return WillPopScope(
      onWillPop: () async {
        screenState.getProfile();
        return false;
      },
      child: Scaffold(
          appBar: CustomC4dAppBar.appBar(context,
              title: S.current.updateProfile, onTap: () {
            screenState.getProfile();
          }),
          body: StackedForm(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // profile image
                      Center(
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: () {
                            ImagePicker.platform
                                .pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 75)
                                .then((value) async {
                              if (value != null) {
                                imageBytes = await value.readAsBytes();
                                imagePath = value.path;
                                networkImage = null;
                                screenState.refresh();
                              }
                            });
                          },
                          child: Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Checked(
                                checked: imagePath != null,
                                checkedWidget: ClipOval(
                                    child: imageBytes != null
                                        ? Image.memory(
                                            imageBytes ?? Uint8List(0),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            networkImage ?? '',
                                            fit: BoxFit.cover,
                                          )),
                                child: Center(
                                    child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ))),
                          ),
                        ),
                      ),
                      // store name
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            '${profileModel.name} \n${profileModel.id}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      // phone number
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 80, right: 80, top: 8),
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
                                color: Theme.of(context).colorScheme.background,
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
                                      EdgeInsets.only(left: 8.0, right: 8.0),
                                  controller: _countryController,
                                  phone: true,
                                  phoneHint: false,
                                  maxLength: 3,
                                  halfField: true,
                                  hintText: S.current.countryCode,
                                  sufIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, left: 8.0),
                                    child: Container(
                                      width: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Center(
                                        child: Text(
                                          '+',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
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
                      // work Time
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 0.0, right: 16.0, left: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.store_rounded,
                                  color: Theme.of(context).disabledColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Material(
                              borderRadius: BorderRadius.circular(25),
                              elevation: 0.0,
                              color: Theme.of(context).colorScheme.background,
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    builder: (context, widget) {
                                      if (isDark == false)
                                        return widget ?? SizedBox();
                                      return Theme(
                                          data: ThemeData.dark(),
                                          child: widget ?? SizedBox());
                                    },
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    if (value == null) {
                                    } else {
                                      var now = DateTime.now();
                                      openingTime = DateTime(
                                          now.year,
                                          now.month,
                                          now.day,
                                          value.hour,
                                          value.minute);
                                      screenState.refresh();
                                    }
                                  });
                                },
                                title: Text(S.of(context).openingTime),
                                trailing: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        DateFormat.jm().format(
                                            openingTime ?? DateTime.now()),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 0.0, right: 16.0, left: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.punch_clock_rounded,
                                  color: Theme.of(context).disabledColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Material(
                              borderRadius: BorderRadius.circular(25),
                              elevation: 0.0,
                              color: Theme.of(context).colorScheme.background,
                              child: ListTile(
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      builder: (context, widget) {
                                        if (isDark == false)
                                          return widget ?? SizedBox();
                                        return Theme(
                                            data: ThemeData.dark().copyWith(
                                                primaryColor: Colors.indigo),
                                            child: widget ?? SizedBox());
                                      },
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      if (value == null) {
                                      } else {
                                        var now = DateTime.now();
                                        closingTime = DateTime(
                                            now.year,
                                            now.month,
                                            now.day,
                                            value.hour,
                                            value.minute);
                                        screenState.refresh();
                                      }
                                    });
                                  },
                                  title: Text(S.of(context).closingTime),
                                  trailing: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          DateFormat.jm().format(
                                              closingTime ?? DateTime.now()),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge),
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                      // city
                      InitField(
                        icon: Icons.location_city_rounded,
                        controller: _cityController,
                        title: S.current.city,
                        hint: S.current.eg + ' : ' + S.current.cityHint,
                      ),
                      // bankName
                      InitField(
                        icon: Icons.account_balance_rounded,
                        controller: _bankNameController,
                        title: S.current.bankName,
                        hint: S.current.eg + ' : ' + S.current.bankNameHint,
                      ),
                      // bankNumber
                      InitField(
                        icon: Icons.password_rounded,
                        controller: _bankNumberController,
                        title: S.current.bankAccountNumber,
                        last: true,
                        hint: S.current.eg + ' : ' + 'xxxxxxxxxxxxxx',
                      ),
                      //size
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 16.0, left: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.people,
                                    color: Theme.of(context).disabledColor,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 8.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        elevation: 3,
                                        validator: (String? value) {
                                          if (value == null) {
                                            return S.current
                                                .chooseYourCompanyCapacity;
                                          }
                                          return null;
                                        },
                                        value: selectedSize,
                                        decoration: InputDecoration(
                                          hintText:
                                              S.of(context).chooseYourSize,
                                          hintMaxLines: 2,
                                          helperMaxLines: 2,
                                          border: InputBorder.none,
                                        ),
                                        items: _getSizes(context),
                                        onChanged: (String? value) {
                                          selectedSize = value;
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 75,
                      ),
                    ],
                  ),
                ),
              ),
              label: S.current.updateProfile,
              onTap: () {
                if (key.currentState?.validate() == true && imagePath != null) {
                  if (imageBytes == null && imagePath != null) {
                    saveWithoutImageUpload();
                  } else {
                    saveWithUploadImage();
                  }
                } else if (imagePath == null) {
                  CustomFlushBarHelper.createError(
                          title: S.current.warnning, message: S.current.noImage)
                      .show(context);
                } else {
                  CustomFlushBarHelper.createError(
                          title: S.current.warnning,
                          message: S.current.pleaseCompleteTheForm)
                      .show(context);
                }
              })),
    );
  }

  List<DropdownMenuItem<String>> _getSizes(BuildContext context) {
    var sizeDropdowns = <DropdownMenuItem<String>>[];
    sizeDropdowns.add(DropdownMenuItem(
      child: Text(S.of(context).smallLessThan20Employee),
      value: '1-20',
    ));
    sizeDropdowns.add(DropdownMenuItem(
      child: Text(S.of(context).mediumMoreThan20EmployeesLessThan100),
      value: '21-100',
    ));
    sizeDropdowns.add(DropdownMenuItem(
      child: Text(S.of(context).largeMoreThan100Employees),
      value: '+100',
    ));

    return sizeDropdowns;
  }

  void saveWithoutImageUpload() {
    ProfileRequest profileRequest = ProfileRequest(
      name: profileModel.name,
      phone: _countryController.text + _phoneController.text,
      city: _cityController.text,
      image: imagePath,
      bankName: _bankNameController.text,
      bankAccountNumber: _bankNumberController.text,
      employeeSize: selectedSize,
      closingTime: closingTime?.toUtc().toIso8601String(),
      openingTime: openingTime?.toUtc().toIso8601String(),
    );
    screenState.saveProfile(profileRequest);
  }

  void saveWithUploadImage() {
    var context = screenState.context;
    screenState.states = LoadingState(screenState);
    screenState.refresh();
    getIt<ImageUploadService>().uploadImage(imagePath).then((image) {
      if (image == null) {
        screenState.getProfile();
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: S.current.errorUploadingImages)
            .show(context);
        return;
      }
      ProfileRequest profileRequest = ProfileRequest(
        name: profileModel.name,
        phone: _countryController.text + _phoneController.text,
        city: _cityController.text,
        image: image,
        bankName: _bankNameController.text,
        bankAccountNumber: _bankNumberController.text,
        employeeSize: selectedSize,
        closingTime: closingTime?.toUtc().toIso8601String(),
        openingTime: openingTime?.toUtc().toIso8601String(),
      );
      screenState.saveProfile(profileRequest);
    });
  }
}
