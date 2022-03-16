import 'package:c4d/module_captain/model/porfile_model.dart';
import 'package:c4d/module_captain/request/update_captain_request.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/ui/state/store_categories/stores_loaded_state.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

class UpdateCaptainProfile extends StatefulWidget {
  final Function(UpdateCaptainRequest) updateProfile;
  final ProfileModel? request;
  UpdateCaptainProfile(
      {required this.updateProfile, this.request});

  @override
  _UpdateCaptainProfileState createState() => _UpdateCaptainProfileState();
}

class _UpdateCaptainProfileState extends State<UpdateCaptainProfile> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _carController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
   TextEditingController _bounceController=TextEditingController();
   TextEditingController _phoneController=TextEditingController();
   TextEditingController _bankNameController=TextEditingController();
   TextEditingController _bankAccountNumberController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return StackedForm(
        child: Form(
          key: _key,
          child: CustomListView.custom(
              padding: EdgeInsets.only(right: 16, left: 16),
              children: [
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
                  numbers:true,
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
                  numbers:true,
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

                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.bounce,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: _bounceController,
                  hintText: S.current.bounce,
                  validator: false,
                  numbers: true,
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.salary,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: _salaryController,
                  hintText: S.current.salary,
                  numbers: true,
                ),
                SizedBox(
                  height: 100,
                ),
              ]),
        ),
        label: S.current.save,
        onTap: () {
          if (_salaryController.text.isNotEmpty) {
            widget.updateProfile(UpdateCaptainRequest(
                 id: widget.request!.id ,
            phone: _phoneController.text,
              bankAccountNumber: _bankAccountNumberController.text,
              bankName: _bankNameController.text,
              age: _ageController.text,
              bounce:double.parse(_bounceController.text),
              captainName: _nameController.text,
              car: _carController.text,
              identity: widget.request!.identity ?? '',
              images: widget.request!.image ?? '',
              isOnline: widget.request!.isOnline ??false,
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
    _salaryController.text =widget.request!.salary.toString() ;
    _nameController.text =widget.request!.name  ?? '';
    _ageController.text =widget.request!.age.toString() ;
    _carController.text =widget.request!.car  ?? '';
    _phoneController.text =widget.request!.phone  ?? '';
    _bankNameController.text =widget.request!.bankName  ?? '';
    _bankAccountNumberController.text =widget.request!.bankNumber  ?? '';
    super.initState();
  }
}
