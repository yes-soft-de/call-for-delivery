import 'dart:typed_data';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/module_profile/ui/screen/init_account_screen.dart';
import 'package:c4d/module_profile/ui/widget/init_field/init_field.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/effect/checked.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InitAccountStateProfileLoaded extends States {
  String? _selectedCity;
  String? _selectedSize;
  String countryCode = '+966';
  final InitAccountScreenState screenState;
  InitAccountStateProfileLoaded(
    this.screenState,
  ) : super(screenState);
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _bankNumberController = TextEditingController();


  String? imagePath;
  Uint8List? imageBytes;
  @override
  Widget getUI(BuildContext context) {
    return StackedForm(
      onTap: () {},
      label: S.current.save,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            InkWell(
              customBorder: CircleBorder(),
              onTap: () {
                ImagePicker.platform
                    .pickImage(source: ImageSource.gallery, imageQuality: 75)
                    .then((value) async {
                  if (value != null) {
                    imageBytes = await value.readAsBytes();
                    imagePath = value.path;
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
                    checked: false,
                    checkedWidget: Image.memory(imageBytes ?? Uint8List(0)),
                    child: Center(
                        child: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).textTheme.button?.color,
                    ))),
              ),
            ),
            // store name 
            InitField(
              icon: Icons.storefront_outlined,
              controller: _nameController,
              title: S.current.storeName,
              hint: S.current.store,
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
                                  style: Theme.of(context).textTheme.button,
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
           // city 
             InitField(
              icon: Icons.storefront_outlined,
              controller: _nameController,
              title: S.current.city,
              hint: S.current.cityHint,
            ),
            // bankName 
              InitField(
              icon: Icons.account_balance_rounded,
              controller: _nameController,
              title: S.current.bankName,
              hint: S.current.bankNameHint,
            ),
            // bankNumber
              InitField(
              icon: Icons.password_rounded,
              controller: _nameController,
              title: S.current.bankAccountNumber,
              hint: 'xxxxxxxxxxxxxx',
            ),
          ],
        ),
      ),
      visible: MediaQuery.of(context).viewInsets.bottom == 0,
    );
  }
}
