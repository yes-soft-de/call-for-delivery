import 'dart:typed_data';

import 'package:c4d/module_captain/model/porfile_model.dart';
import 'package:c4d/module_captain/request/update_captain_request.dart';
import 'package:c4d/utils/effect/checked.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:image_picker/image_picker.dart';

class UpdateCaptainProfile extends StatefulWidget {
  final Function(UpdateCaptainRequest) updateProfile;
  final ProfileModel? request;
  UpdateCaptainProfile({required this.updateProfile, this.request});

  @override
  _UpdateCaptainProfileState createState() => _UpdateCaptainProfileState();
}

class _UpdateCaptainProfileState extends State<UpdateCaptainProfile> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _carController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _bounceController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _bankAccountNumberController = TextEditingController();

  String? imagePath;
  String? networkImage;
  Uint8List? imageBytes;

  String? imagePathMechanich;
  String? networkImageMechanich;
  Uint8List? imageBytesMechanich;

  String? imagePathIdentity;
  String? networkImageIdentity;
  Uint8List? imageBytesIdentity;

  @override
  Widget build(BuildContext context) {
    return StackedForm(
        child: Form(
          key: _key,
          child: CustomListView
              .custom(padding: EdgeInsets.only(right: 16, left: 16), children: [
            //name
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, bottom: 8, right: 12, top: 16.0),
              child: Text(
                S.current.name,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            CustomFormField(
              controller: _nameController,
              hintText: S.current.name,
            ),

            //age
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, bottom: 8, right: 12, top: 16.0),
              child: Text(
                S.current.age,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            CustomFormField(
              controller: _ageController,
              hintText: S.current.age,
              numbers: true,
            ),

            //car
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, bottom: 8, right: 12, top: 16.0),
              child: Text(
                S.current.car,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            CustomFormField(
              controller: _carController,
              hintText: S.current.car,
            ),

            //phone
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, bottom: 8, right: 12, top: 16.0),
              child: Text(
                S.current.phoneNumber,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            CustomFormField(
              controller: _phoneController,
              hintText: S.current.phoneNumber,
              numbers: true,
              phone: true,
            ),

            //Bankname
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, bottom: 8, right: 12, top: 16.0),
              child: Text(
                S.current.bankName,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            CustomFormField(
              controller: _bankNameController,
              hintText: S.current.bankName,
            ),

            //BankNumber
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, bottom: 8, right: 12, top: 16.0),
              child: Text(
                S.current.bankAccountNumber,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            CustomFormField(
              controller: _bankAccountNumberController,
              hintText: S.current.bankAccountNumber,
              numbers: true,
            ),

            //  image
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                  child: Text(
                S.current.driverLicence,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              height: 200,
              child: InkWell(
                onTap: () {
                  ImagePicker.platform
                      .getImage(source: ImageSource.gallery, imageQuality: 70)
                      .then((value) async {
                    if (value != null) {
                      imageBytes = await value.readAsBytes();
                      imagePath = value.path;
                      setState(() {});
                    }
                  });
                },
                child: Checked(
                    checked: imagePath != null,
                    checkedWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
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

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                  child: Text(
                S.current.mechanichLicence,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              height: 200,
              child: InkWell(
                onTap: () {
                  ImagePicker.platform
                      .getImage(source: ImageSource.gallery, imageQuality: 70)
                      .then((value) async {
                    if (value != null) {
                      imageBytesMechanich = await value.readAsBytes();
                      imagePathMechanich = value.path;
                      setState(() {});
                    }
                  });
                },
                child: Checked(
                    checked: imagePathMechanich != null,
                    checkedWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: imageBytesMechanich != null
                            ? Image.memory(
                                imageBytesMechanich ?? Uint8List(0),
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                networkImageMechanich ?? '',
                                fit: BoxFit.cover,
                              )),
                    child: Center(
                        child: Icon(
                      Icons.camera_alt,
                    ))),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                  child: Text(
                S.current.identity,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              height: 200,
              child: InkWell(
                onTap: () {
                  ImagePicker.platform
                      .getImage(source: ImageSource.gallery, imageQuality: 70)
                      .then((value) async {
                    if (value != null) {
                      imageBytesIdentity = await value.readAsBytes();
                      imagePathIdentity = value.path;
                      setState(() {});
                    }
                  });
                },
                child: Checked(
                    checked: imagePathIdentity != null,
                    checkedWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: imageBytesIdentity != null
                            ? Image.memory(
                                imageBytesIdentity ?? Uint8List(0),
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                networkImageIdentity ?? '',
                                fit: BoxFit.cover,
                              )),
                    child: Center(
                        child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ))),
              ),
            ),

//                Padding(
//                  padding: const EdgeInsets.only(
//                      left: 12.0, bottom: 8, right: 12, top: 16.0),
//                  child: Text(
//                    S.current.bounce,
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                    textAlign: TextAlign.start,
//                  ),
//                ),
//                CustomFormField(
//                  controller: _bounceController,
//                  hintText: S.current.bounce,
//                  validator: false,
//                  numbers: true,
//                ),
//
//                Padding(
//                  padding: const EdgeInsets.only(
//                      left: 12.0, bottom: 8, right: 12, top: 16.0),
//                  child: Text(
//                    S.current.salary,
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                    textAlign: TextAlign.start,
//                  ),
//                ),
//                CustomFormField(
//                  controller: _salaryController,
//                  hintText: S.current.salary,
//                  numbers: true,
//                ),
            SizedBox(
              height: 100,
            ),
          ]),
        ),
        label: S.current.save,
        onTap: () {
          if (_key.currentState!.validate()) {
            widget.updateProfile(UpdateCaptainRequest(
              id: widget.request!.id,
              phone: _phoneController.text,
              bankAccountNumber: _bankAccountNumberController.text,
              bankName: _bankNameController.text,
              age: _ageController.text,
              bounce: double.parse(_bounceController.text),
              captainName: _nameController.text,
              car: _carController.text,
              identity: widget.request!.identity ?? '',
              images: widget.request!.image ?? '',
              isOnline: widget.request!.isOnline ?? false,
              mechanicLicense: widget.request!.mechanicLicense ?? '',
            ));
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm)
                .show(context);
          }
        });
  }

  @override
  void initState() {
    _salaryController.text = widget.request!.salary.toString();
    _nameController.text = widget.request!.name ?? '';
    _ageController.text = widget.request!.age.toString();
    _carController.text = widget.request!.car ?? '';
    _phoneController.text = widget.request!.phone ?? '';
    _bankNameController.text = widget.request!.bankName ?? '';
    _bankAccountNumberController.text = widget.request!.bankNumber ?? '';

    networkImageMechanich = widget.request!.mechanicLicense ?? '';
    imagePathMechanich = widget.request!.mechanicLicense ?? '';

    imagePathIdentity = widget.request!.identity ?? '';
    networkImageIdentity = widget.request!.identity ?? '';

    networkImage = widget.request!.drivingLicence ?? '';
    imagePath = widget.request!.drivingLicence ?? '';
    super.initState();
  }
}
