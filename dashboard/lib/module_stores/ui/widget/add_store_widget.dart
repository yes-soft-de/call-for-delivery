import 'dart:io';
import 'dart:typed_data';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/module_stores/model/store_profile_model.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/ui/state/stores_lists/stores_loaded_state.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/effect/checked.dart';

import 'package:c4d/utils/helpers/custom_flushbar.dart';

import '../../../abstracts/states/loading_state.dart';

class UpdateStoreWidget extends StatefulWidget {
  final Function(UpdateStoreRequest, bool) updateStore;
  StoreProfileModel? storesModel;

  UpdateStoreWidget({required this.updateStore, this.storesModel});

  @override
  _UpdateStoreWidgetState createState() => _UpdateStoreWidgetState();
}

class _UpdateStoreWidgetState extends State<UpdateStoreWidget> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _cityController;

  late TextEditingController _bankName;
  late TextEditingController _bankAccountNumber;
  late TextEditingController _stcPay;

  late TextEditingController profitMargin;

  String? imagePath;
  String? networkImage;
  Uint8List? imageBytes;
  String? selectedSize;

  DateTime? openingTime;
  DateTime? closingTime;
  String? status;
  var date = DateTime.now();
  int val = 1;
  @override
  Widget build(BuildContext context) {
    return StackedForm(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: Form(
          key: _key,
          child: Container(
            width: double.maxFinite,
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 600,
                ),
                child: CustomListView.custom(
                    padding: EdgeInsets.only(right: 16, left: 16),
                    children: [
                      //store name
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, bottom: 8, right: 12, top: 16.0),
                        child: Text(
                          S.current.storeName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      CustomFormField(
                        controller: _nameController,
                        hintText: S.current.storeName,
                      ),

                      //store phone
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
                        numbers: true,
                        phone: true,
                        controller: _phoneController,
                        hintText: S.current.phoneNumber,
                      ),

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

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, bottom: 8, right: 12, top: 16.0),
                        child: Text(
                          S.current.storeProfitMargin,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      CustomFormField(
                        controller: profitMargin,
                        hintText: S.current.storeProfitMargin,
                      ),

                      // bank name
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
                        controller: _bankName,
                        hintText: S.current.bankName,
                      ),

                      Visibility(
                        visible: val == 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              controller: _bankAccountNumber,
                              hintText: S.current.bankAccountNumber,
                              validator: val == 1 ? true : false,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: val == 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 8, right: 12, top: 16.0),
                              child: Text(
                                S.current.stcPayCode,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            CustomFormField(
                              controller: _stcPay,
                              hintText: S.current.stcPayCode,
                              validator: val == 2 ? true : false,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: ListTile(
                              title: Text(S.of(context).bankAccountNumber,
                                  style: TextStyle(fontSize: 12)),
                              leading: Radio(
                                value: 1,
                                groupValue: val,
                                onChanged: (value) {
                                  val = value as int;
                                  setState(() {});
                                },
                                activeColor: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: ListTile(
                              title: Text(
                                S.of(context).stcPayCode,
                                style: TextStyle(fontSize: 12),
                              ),
                              leading: Radio(
                                  value: 2,
                                  groupValue: val,
                                  onChanged: (value) {
                                    val = value as int;
                                    setState(() {});
                                  },
                                  activeColor: Theme.of(context).accentColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),

                      // store image
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                            child: Text(
                          S.current.storeImage,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      SizedBox(
                        height: 200,
                        child: InkWell(
                          onTap: () {
                            ImagePicker()
                                .pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 100)
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
                              ))),
                        ),
                      ),
                      // Store Shift
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, left: 16, right: 16),
                        child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              S.current.workTime + ' : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(25),
                          elevation: 0.5,
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value == null) {
                                } else {
                                  var now = DateTime.now();
                                  openingTime = DateTime(now.year, now.month,
                                      now.day, value.hour, value.minute);
                                  setState(() {});
                                }
                              });
                            },
                            title: Text(S.of(context).openingTime),
                            trailing: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).backgroundColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    DateFormat.jm()
                                        .format(openingTime ?? DateTime.now()),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(25),
                          elevation: 0.5,
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value == null) {
                                } else {
                                  var now = DateTime.now();
                                  closingTime = DateTime(now.year, now.month,
                                      now.day, value.hour, value.minute);
                                  setState(() {});
                                }
                              });
                            },
                            title: Text(S.of(context).closingTime),
                            trailing: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).backgroundColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    DateFormat.jm()
                                        .format(closingTime ?? DateTime.now()),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, bottom: 8, right: 12, top: 16.0),
                        child: Text(
                          S.current.chooseYourSize,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Theme.of(context).backgroundColor,
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
                                            return S.current.chooseYourSize;
                                          }
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ]),
              ),
            ),
          ),
        ),
        label: S.current.update,
        onTap: () {
          if (_key.currentState?.validate() == true && imagePath != null) {
            if (imageBytes == null && imagePath != null) {
              saveImageUpload(false);
            } else {
              saveImageUpload(true);
            }
          } else if (imagePath == null) {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning, message: S.current.noImage);
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm);
          }
        });
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _cityController = TextEditingController();
    _phoneController = TextEditingController();
    _bankAccountNumber = TextEditingController();
    _bankName = TextEditingController();
    _stcPay = TextEditingController();
    profitMargin = TextEditingController();

    if (widget.storesModel != null) {
      _nameController.text = widget.storesModel?.storeOwnerName ?? '';
      networkImage = widget.storesModel?.image;
      imagePath = widget.storesModel?.imageUrl;
      openingTime = widget.storesModel?.openingTime;
      closingTime = widget.storesModel?.closingTime;
      status = widget.storesModel?.status ?? 'active';
      _bankAccountNumber.text = widget.storesModel?.bankNumber ?? '';
      profitMargin.text = widget.storesModel?.profitMargin.toString() ?? '';
      _bankName.text = widget.storesModel?.bankName ?? '';
//      _stcPay.text = widget.storesModel?.
      val = _bankAccountNumber.text != '' ? 1 : 2;
      _cityController.text = widget.storesModel?.city ?? '';
      _phoneController.text = widget.storesModel?.phone ?? '';
      selectedSize = widget.storesModel?.employeeCount ?? '1-20';
    }
    super.initState();
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

  void saveImageUpload(bool haveImage) {
    UpdateStoreRequest profileRequest = UpdateStoreRequest(
        storeOwnerName: _nameController.text,
        phone: _phoneController.text,
        city: _cityController.text,
        image: imagePath,
        bankName: _bankName.text,
        bankAccountNumber: _bankAccountNumber.text,
        employeeCount: selectedSize,
        closingTime: closingTime?.toUtc().toIso8601String(),
        openingTime: openingTime?.toUtc().toIso8601String(),
        status: status,
        id: widget.storesModel?.id ?? -1,
        profitMargin: profitMargin.text);
    widget.updateStore(profileRequest, haveImage);
  }
}
