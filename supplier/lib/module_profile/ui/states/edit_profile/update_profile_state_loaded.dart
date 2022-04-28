import 'dart:typed_data';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/module_profile/model/category_model/category_model.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/profile_response/loaction.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/widget/choose_location_widget.dart';
import 'package:c4d/module_profile/ui/widget/init_field/init_field.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/effect/checked.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect/multiselect.dart';
import 'package:the_country_number/the_country_number.dart';

class UpdateProfileStateLoaded extends States {
  final ProfileScreenState screenState;
  final ProfileModel profileModel;
  final List<SupplierCategoryModel> categories;
  UpdateProfileStateLoaded(this.screenState, this.profileModel ,this.categories)
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
    _nameController.text = profileModel.name;
    networkImage = profileModel.image;
    imagePath = profileModel.imageUrl;
    _bankNameController.text = profileModel.bankName;
    _bankAccountNumberController.text = profileModel.bankAccount;
    _stcController.text = profileModel.stc;
    profLocation = profileModel.location;
    selectedCategory = profileModel.categories;
    screenState.selectedCategoryName =[];
    screenState.selectedCategoryName = gecatName();
  }
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();

  final _bankNameController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final _stcController = TextEditingController();


  List<CategoryModel>? selectedCategory;
  String? imagePath;
  String? networkImage;
  Uint8List? imageBytes;
  LatLng? profLocation;

//  int? categoryId;

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

                      SizedBox(height: 20,),
                      //category
                      Container(
                        height: 60,
                        margin: EdgeInsetsDirectional.only(start: 20,end: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).backgroundColor

                        ),
                        child:DropDownMultiSelect(
                          onChanged: (List<String> x) {
                            screenState.selectedCategoryName = x;
                            print(screenState.selectedCategoryName);
                          },
                          options:catName(),
                          selectedValues: screenState.selectedCategoryName,
                          whenEmpty: S.of(context).selectYourCategory,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
//                            alignLabelWithHint: true,
                            filled: true,
                            hintText: screenState.selectedCategoryName.isNotEmpty ? '': S.of(context).selectYourCategory,
                            fillColor: Colors.transparent,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsetsDirectional.all(16),
                          ),
                          childBuilder: (name){
                            return Padding(
                              padding: const EdgeInsetsDirectional.all(10),
                              child: Text(getSelectedName(name)),
                            );
                          },
                        ),
                      ),

                      // store name
                      InitField(
                        icon: Icons.storefront_outlined,
                        controller: _nameController,
                        title: S.current.name,
                        hint:  S.current.name,
                        onChanged: () {
                          screenState.refresh();
                        },
                        validator: (String? v) {
                          if (v == null) return S.current.pleaseCompleteField;
                        },
                      ),
                      // phone number
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 80, right: 80, top: 8),
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
                      // location
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
                                      child: Text(  profLocation != null ?S.of(context).locationSelected :S.of(context).locationPref),
                                      onPressed: (){
                                        showDialog(context: context,
                                            builder: (_){
                                              return ChooseLocation(saveLocation: (lo){
                                                print('lastLoca');
                                                profLocation = lo;
                                                screenState.refresh();
                                              },lastLocation: profLocation,);
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

  void saveWithoutImageUpload() {
    ProfileRequest profileRequest = ProfileRequest(
      name: _nameController.text,
      phone: _countryController.text + _phoneController.text,
      image: imagePath,
        stcPay: _stcController.text,
        bankName: _bankNameController.text,
        bankAccountNumber: _bankAccountNumberController.text,
        supplierCategories: getIdsSelected(),
        location: GeoJson(lat: profLocation?.latitude,lon: profLocation?.longitude),
      allSupplierCategories: false
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
        name: _nameController.text,
        phone: _countryController.text + _phoneController.text,
        image: image,
        stcPay: _stcController.text,
          bankName: _bankNameController.text,
          bankAccountNumber: _bankAccountNumberController.text,
          supplierCategories: getIdsSelected(),
          location: GeoJson(lat: profLocation?.latitude,lon: profLocation?.longitude),allSupplierCategories: false
      );
      screenState.saveProfile(profileRequest);
    });
  }

  List<String> catName(){
   var namesCategories = <String>[];
    categories.forEach((element) {
      namesCategories.add(element.name);
    });
    return namesCategories;
  }

  List<String> gecatName(){
    profileModel.categories.forEach((element) {
      screenState.selectedCategoryName.add(element.name);
    });
    return screenState.selectedCategoryName;
  }
  List<int> gecatID(){

    profileModel.categories.forEach((element) {
      screenState.selectedCategoryID.add(element.id);
    });
    return screenState.selectedCategoryID;
  }
  String getSelectedName(List<String> names){
   String allName = '';
   names.forEach((element) {
      allName += element+', ';
    });
    return allName;
  }


  List<int>  getIdsSelected(){
    screenState.selectedCategoryName.forEach((selectedName) {
      categories.forEach((cat) {
        if(cat.name == selectedName){
          print('in Side');
          screenState.selectedCategoryID.add(cat.id);
        }

      });
    });
    return screenState.selectedCategoryID;
  }
}
