import 'dart:typed_data';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/module_bid_orders/ui/widgets/label_text.dart';
import 'package:c4d/module_profile/model/category_model/category_model.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/ui/screen/init_account_screen.dart';
import 'package:c4d/module_profile/ui/states/init_account/init_account_profile_state_loading.dart';
import 'package:c4d/module_profile/ui/widget/init_field/init_field.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/effect/checked.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:the_country_number/the_country_number.dart';

class InitAccountStateProfileLoaded extends States {
  String countryCode = '966';
  final InitAccountScreenState screenState;
 final List<SupplierCategoryModel> categories;
  InitAccountStateProfileLoaded(
    this.screenState,
      this.categories
  ) : super(screenState) {
    var number = getIt<AuthService>().username;
    if (number.isNotEmpty) {
      final sNumber =
          TheCountryNumber().parseNumber(internationalNumber: '+' + number);
      _countryController.text = sNumber.dialCode.substring(1);
      _phoneController.text = sNumber.number;
    }
  }
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();

  String? imagePath;
  Uint8List? imageBytes;

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget getUI(BuildContext context) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();
    return StackedForm(
      onTap: () {
        if (key.currentState?.validate() == true
            && imagePath != null
        ) {
          screenState.currentState = InitAccountStateLoading(
              screenState, S.current.uploadingAndSubmitting);
          screenState.refresh();
          getIt<ImageUploadService>().uploadImage(imagePath).then((image) {
            if (image == null) {
              screenState.currentState =
                  InitAccountStateProfileLoaded(screenState,categories);
              CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.errorUploadingImages)
                  .show(context);
              return;
            }
            ProfileRequest profileRequest = ProfileRequest(
              name: _nameController.text,
              phone: _countryController.text + _phoneController.text,
              supplierCategoryID: screenState.categoryID,
              image: image,
            );
            screenState.initProfile(profileRequest,categories);
          });
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
      },
      label: S.current.save,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                            source: ImageSource.gallery, imageQuality: 75)
                        .then((value) async {
                      if (value != null) {
                        imageBytes = await value.readAsBytes();
                        imagePath = value.path;
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
                            child: Image.memory(
                          imageBytes ?? Uint8List(0),
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

              //category

              Column(
                children: [
                  ListTile(
                    title: LabelText(S.of(context).category),
                    subtitle: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).backgroundColor),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                              value: screenState.categoryID,
                              items: _getCategories(),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              hint: Text(S.current.category),
                              onChanged: (int? value) {
                                screenState.categoryID = value;
                                screenState.refresh();
                              }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // supplier name
              InitField(
                icon: Icons.storefront_outlined,
                controller: _nameController,
                title: S.current.name,
                hint:   S.current.nameHint,
                onChanged: () {
                  screenState.refresh();
                },
                validator: (String? v) {
                  if (v == null) return S.current.nameIsRequired;
                },
              ),
              // phone number
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80, top: 8),
                child: Text(
                  S.of(context).phoneNumber +
                      ' ' +
                      '(${S.current.phoneNumber})',
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
                              EdgeInsets.only(left: 8.0, right: 8.0),
                          controller: _countryController,
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

              SizedBox(
                height: 75,
              ),
            ],
          ),
        ),
      ),
      visible: MediaQuery.of(context).viewInsets.bottom == 0,
    );
  }

  List<DropdownMenuItem<int>> _getCategories() {
    var categoryDropDown = <DropdownMenuItem<int>>[];
    categories.forEach((element) {
      categoryDropDown.add(DropdownMenuItem(
        child: Text(
          element.name,
          overflow: TextOverflow.ellipsis,
        ),
        value: element.id,
      ));
    });
    return categoryDropDown;
  }
}
