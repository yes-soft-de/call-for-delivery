import 'dart:typed_data';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_captain/model/porfile_model.dart';
import 'package:c4d/module_captain/request/update_captain_request.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
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
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
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

  String? imagePathDriving;
  String? networkImageDriving;
  Uint8List? imageBytesDriving;
  @override
  Widget build(BuildContext context) {
    return StackedForm(
        child: Form(
          key: _key,
          child: CustomListView
              .custom(padding: EdgeInsets.only(right: 16, left: 16), children: [
            //  image profile
            SizedBox(
              height: 200,
              child: InkWell(
                onTap: () {
                  ImagePicker()
                      .pickImage(source: ImageSource.gallery, imageQuality: 70)
                      .then((value) async {
                    if (value != null) {
                      imageBytes = await value.readAsBytes();
                      imagePath = await uploadImage(value.path);
                      networkImage = null;
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
            // city
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, bottom: 8, right: 12, top: 16.0),
              child: Text(
                S.current.city,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            CustomFormField(
              controller: _cityController,
              hintText: S.current.city,
            ),
            // address
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, bottom: 8, right: 12, top: 16.0),
              child: Text(
                S.current.address,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            CustomFormField(
              controller: _addressController,
              hintText: S.current.address,
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
            //  driver licence
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
                  ImagePicker()
                      .pickImage(source: ImageSource.gallery, imageQuality: 70)
                      .then((value) async {
                    if (value != null) {
                      imageBytesDriving = await value.readAsBytes();
                      imagePathDriving = await uploadImage(value.path);
                      networkImageDriving = null;
                      setState(() {});
                    }
                  });
                },
                child: Checked(
                    checked: imagePathDriving != null,
                    checkedWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: imageBytesDriving != null
                            ? Image.memory(
                                imageBytesDriving ?? Uint8List(0),
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                networkImageDriving ?? '',
                                fit: BoxFit.cover,
                              )),
                    child: Center(
                        child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ))),
              ),
            ),
            // mechanic
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
                  ImagePicker()
                      .pickImage(source: ImageSource.gallery, imageQuality: 70)
                      .then((value) async {
                    if (value != null) {
                      imageBytesMechanich = await value.readAsBytes();
                      imagePathMechanich = await uploadImage(value.path);
                      ;
                      networkImageMechanich = null;
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
// identity
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
                  ImagePicker()
                      .pickImage(source: ImageSource.gallery, imageQuality: 70)
                      .then((value) async {
                    if (value != null) {
                      imageBytesIdentity = await value.readAsBytes();
                      imagePathIdentity = await uploadImage(value.path);
                      networkImageIdentity = null;
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
              bounce: double.tryParse(_bounceController.text) ?? 0,
              captainName: _nameController.text,
              car: _carController.text,
              identity: imagePathIdentity,
              images: imagePath,
              drivingLicence: imagePathDriving,
              mechanicLicense: imagePathMechanich,
              isOnline: widget.request!.isOnline ?? false,
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
    _nameController.text = widget.request?.name ?? '';
    _ageController.text = widget.request?.age?.toString() ?? '';
    _carController.text = widget.request?.car ?? '';
    _addressController.text = widget.request?.address ?? '';
    _cityController.text = widget.request?.city ?? '';
    _phoneController.text = widget.request?.phone ?? '';
    _bankNameController.text = widget.request?.bankName ?? '';
    _bankAccountNumberController.text = widget.request?.bankNumber ?? '';

    // network image
    networkImageIdentity = widget.request?.identity;
    networkImage = widget.request?.image;
    networkImageMechanich = widget.request?.mechanicLicense;
    networkImageDriving = widget.request?.drivingLicence;
    // image path
    if (widget.request?.image != null) {
      imagePath = getPath(widget.request?.image);
    }
    if (widget.request?.identity != null) {
      imagePathIdentity = getPath(widget.request?.identity);
    }
    if (widget.request?.mechanicLicense != null) {
      imagePathMechanich = getPath(widget.request?.mechanicLicense);
    }
    if (widget.request?.drivingLicence != null) {
      imagePathDriving = getPath(widget.request?.drivingLicence);
    }
    super.initState();
  }

  String? getPath(String? image) {
    if (image == null) {
      return null;
    }
    try {
      var path = image.split('/upload/').last;
      return path;
    } catch (e) {
      return null;
    }
  }

  Future<String?> uploadImage(String path) async {
    var imagePath = await getIt<ImageUploadService>().uploadImage(path);
    setState(() {});
    return imagePath;
  }
}
