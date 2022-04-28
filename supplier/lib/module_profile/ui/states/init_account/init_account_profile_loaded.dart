import 'dart:typed_data';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/module_bid_orders/ui/widgets/label_text.dart';
import 'package:c4d/module_profile/model/category_model/category_model.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/profile_response/loaction.dart';
import 'package:c4d/module_profile/ui/screen/init_account_screen.dart';
import 'package:c4d/module_profile/ui/states/init_account/init_account_profile_state_loading.dart';
import 'package:c4d/module_profile/ui/widget/choose_location_widget.dart';
import 'package:c4d/module_profile/ui/widget/init_field/init_field.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/components/google_map_widget.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/effect/checked.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
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

  final _bankNameController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final _stcController = TextEditingController();

  bool allCategories = false;

  String? imagePath;
  Uint8List? imageBytes;
  LatLng? profileLoc;
  var namesCategories =<String>[];

  var selectedItemsIndex = <dynamic>[];
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget getUI(BuildContext context) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();
    return StackedForm(
      onTap: () {
        if (key.currentState?.validate() == true
            && imagePath != null && profileLoc != null
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
              supplierCategories: catIdSelected(selectedItemsIndex),
              image: image,
              allSupplierCategories: allCategories,
              bankAccountNumber: _bankAccountNumberController.text,
              bankName: _bankNameController.text,
              stcPay: _stcController.text,
              location: GeoJson(lat: profileLoc?.latitude,lon: profileLoc?.longitude)
            );
            screenState.initProfile(profileRequest,categories);
          });
        } else if (imagePath == null) {
          CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: S.current.noImage)
              .show(context);
        }else if (profileLoc == null) {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: S.current.chooseLocation)
              .show(context);
        }
        else {
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
              Container(
                child: GFMultiSelect(
                  dropdownButton: Container(),
                  items: catName(categories),
                  onSelect: (value) {
                    selectedItemsIndex = value;
                    print('selected $selectedItemsIndex ');
                  },
                  dropdownTitleTileText: S.of(context).selectYourCategory,
                  dropdownTitleTileColor: Theme.of(context).backgroundColor,
                  dropdownTitleTileMargin: EdgeInsets.only(
                      top: 22, left: 18, right: 18, bottom: 5),
                  dropdownTitleTilePadding: EdgeInsets.all(10),
                  dropdownUnderlineBorder: const BorderSide(
                      color: Colors.transparent, width: 2),
                  dropdownTitleTileBorder:
                  Border.all(color: Colors.grey.shade300, width: 1),
                  dropdownTitleTileBorderRadius: BorderRadius.circular(12),
                  expandedIcon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black54,
                  ),
                  collapsedIcon: const Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.black54,
                  ),
                  dropdownTitleTileTextStyle: const TextStyle(
                      fontSize: 14, color: Colors.black54),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  type: GFCheckboxType.circle,
                  activeBgColor:Theme.of(context).primaryColor,
                  inactiveBorderColor: Colors.grey,
                  activeIcon: Icon(Icons.check,color: Colors.white,),
                  dropdownBgColor: Theme.of(context).scaffoldBackgroundColor,

                ),
              ),
              //name
              InitField(
                icon: Icons.storefront_outlined,
                controller: _nameController,
                title: S.current.name,
                hint:   S.current.nameHint,
              ),
              // phone number
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80, top: 8),
                child: Text(
                  S.of(context).phoneNumber,
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


             Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 85, right: 85, top: 8),
              child: Text(
               S.of(context).chooseLocation,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 0.0, right: 16.0, left: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.location_on,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: TextButton(
                     child: Text(  profileLoc != null ?S.of(context).locationSelected :S.of(context).locationPref),
                      onPressed: (){
                       showDialog(context: context,
                           builder: (_){
                         return ChooseLocation(saveLocation: (lo){
                           print('lastLoca');
                           profileLoc = lo;
                           screenState.refresh();
                         },lastLocation: profileLoc,);
                       });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ],
        ),
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
                controller: _bankAccountNumberController,
                title: S.current.bankAccountNumber,
                last: true,
                hint: S.current.eg + ' : ' + 'xxxxxxxxxxxxxx',
              ),
               InitField(
                icon: Icons.storefront_outlined,
                controller: _stcController,
                title: S.current.stcPayCode,
                hint:   S.current.stcPayCode,
                 last: true,
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

  List<String> catName(List<SupplierCategoryModel> categories){
     namesCategories = <String>[];
     categories.forEach((element) {
       namesCategories.add(element.name);
    });
    return namesCategories;
  }

  List<int> catIdSelected(List<dynamic> selectedItemsIndex){
    var supplierCatIds = <int>[];
    selectedItemsIndex.forEach((element) {
      supplierCatIds.add(categories[element].id);
    });
    if(supplierCatIds.contains(0)){
      allCategories = true;
    }
    return supplierCatIds;
  }
}
