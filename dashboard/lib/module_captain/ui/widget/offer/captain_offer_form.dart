import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captain_offer_model.dart';
import 'package:c4d/module_captain/request/captain_offer_request.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';

class CaptainOfferForm extends StatefulWidget {
  final Function(CaptainOfferRequest) onSave;
  final CaptainsOffersModel? request;
  @override
  _CategoryFormState createState() => _CategoryFormState();

  CaptainOfferForm({required this.onSave, this.request});
}

class _CategoryFormState extends State<CaptainOfferForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _costController = TextEditingController();
  final TextEditingController _carCountController = TextEditingController();
  final TextEditingController _expirdCountController = TextEditingController();

  int? id;
  String? status = 'active';

  @override
  void initState() {
    super.initState();

    if (widget.request != null) {
      print('notNull');

      _costController.text = widget.request?.price.toString() ?? '0';
      _carCountController.text = widget.request?.carCount.toString() ?? '0';
      _expirdCountController.text = widget.request?.expired.toString() ?? '0';
      id = widget.request?.id ?? -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context, title: S.of(context).addPackage),
      body: StackedForm(
          child: Form(
            key: _key,
            child: FixedContainer(
              child: ListView(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.carCount,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _carCountController,
                      hintText: S.current.carCount,
                      numbers: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.dayCount,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _expirdCountController,
                      hintText: S.current.dayCount,
                      numbers: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.cost,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _costController,
                      hintText: S.current.cost,
                      numbers: true,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ]),
            ),
          ),
          label: S.current.save,
          onTap: () {
            if (_key.currentState!.validate()) {
              Navigator.pop(context);
              widget.onSave(CaptainOfferRequest(
                  id: id,
                  price: double.parse(_costController.text),
                  carCount: int.parse(_carCountController.text),
                  status: status,
                  expired: int.parse(_expirdCountController.text)));
            } else {
              CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: S.current.pleaseCompleteTheForm,
              );
            }
          }),
    );
  }
}
