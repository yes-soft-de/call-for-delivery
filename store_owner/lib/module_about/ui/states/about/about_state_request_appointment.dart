import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:flutter/material.dart';

class AboutStateRequestBooking extends AboutState {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AboutStateRequestBooking(AboutScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            S.of(context).toFindOutMorePleaseLeaveYourPhonenandWeWill,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Flex(
              direction: Axis.vertical,
              children: [
                TextFormField(
                  controller: _phoneController,
                  validator: (phone) {
                    if (phone?.isEmpty == true) {
                      return S.of(context).pleaseInputPhoneNumber;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: S.of(context).phoneNumber,
                      labelText: S.of(context).phoneNumber,
                      suffix: Icon(Icons.call)),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  controller: _nameController,
                  validator: (name) {
                    if (name?.isEmpty == true) {
                      return S.of(context).nameIsRequired;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: S.of(context).businessName,
                    labelText: S.of(context).businessName,
                    suffix: Icon(Icons.person),
                  ),
                ),
              ],
            ),
          ),
        ),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            if (_formKey.currentState?.validate() == true) {
             // screenState.createAppointment(_nameController.text, _phoneController.text);
            } else {
          
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(S.of(context).requestMeeting),
          ),
        )
      ],
    );
  }

}