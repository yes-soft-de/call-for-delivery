import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/request/company_request/create_new_delivery_company_request.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';

class AddCompanyDialog extends StatelessWidget {
  AddCompanyDialog({
    super.key,
    required this.onAdded,
  });

  final Function(CreateNewDeliveryCompanyRequest request) onAdded;

  final _companyNameController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xff024D92),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.current.enterDeliveryCompanyName,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
            SizedBox(height: 30),
            Form(
              key: _key,
              child: CustomFormField(
                controller: _companyNameController,
                validator: true,
                validatorFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.pleaseEnterCompanyName;
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                child:
                    Text(S.current.save, style: TextStyle(color: Colors.black)),
                onPressed: () {
                  if (_key.currentState?.validate() ?? false) {
                    onAdded(
                      CreateNewDeliveryCompanyRequest(
                          companyName: _companyNameController.text),
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
