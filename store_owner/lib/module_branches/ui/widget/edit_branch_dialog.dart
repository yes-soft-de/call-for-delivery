import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_country_number/the_country_number.dart';

import '../../model/branch/branch_model.dart';

class EditBranchDialog extends StatefulWidget {
  final String branchName;
  final String phoneNumber;
  EditBranchDialog(
      {Key? key, required this.branchName, required this.phoneNumber})
      : super(key: key);
  @override
  State<EditBranchDialog> createState() => _EditBranchDialogState();
}

class _EditBranchDialogState extends State<EditBranchDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    countryController = TextEditingController();
    nameController.text = widget.branchName;
    countryController.text = '966';
    if (widget.phoneNumber.isNotEmpty) {
      try {
        final sNumber = TheCountryNumber()
            .parseNumber(internationalNumber: '+' + widget.phoneNumber);
        countryController.text = sNumber.dialCode.substring(1);
        phoneController.text = sNumber.number;
      } catch (e) {}
    }
    super.initState();
  }

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController countryController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Text(S.current.updateBranch),
      content: Container(
        constraints: BoxConstraints(maxHeight: 250, minWidth: 300),
        child: Form(
          key: formKey,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Text(
                    S.of(context).newName,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              CustomFormField(
                onChanged: () {
                  setState(() {});
                },
                controller: nameController,
                hintText: S.current.branch01,
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Text(
                    S.of(context).phoneNumber,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomLoginFormField(
                        controller: phoneController,
                        phone: true,
                        last: true,
                        hintText: '5xxxxxxxx'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: SizedBox(
                      width: 125,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomLoginFormField(
                          halfField: true,
                          contentPadding:
                              EdgeInsets.only(left: 8.0, right: 8.0),
                          controller: countryController,
                          numbers: true,
                          phoneHint: false,
                          last: true,
                          maxLength: 3,
                          hintText: S.current.countryCode,
                          sufIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 4.0, left: 4.0),
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
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            )),
            child: Text(
              S.of(context).save,
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: nameController.text.isNotEmpty == true
                ? () {
                    if (formKey.currentState?.validate() == true) {
                      Navigator.of(context).pop(BranchModel(
                          location: LatLng(0, 0),
                          name: nameController.text,
                          phone:
                              countryController.text + phoneController.text));
                    }
                  }
                : null)
      ],
    );
  }
}
