import 'package:c4d/consts/app_type.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_delivary_car/model/car_model.dart';
import 'package:c4d/module_delivary_car/request/car_request.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/helpers/app_type_helper.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CarsForm extends StatefulWidget {
  final Function(CarRequest) onSave;
  final CarsModel? request;
  @override
  _CategoryFormState createState() => _CategoryFormState();

  CarsForm({required this.onSave, this.request});
}

class _CategoryFormState extends State<CarsForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _decController = TextEditingController();
  final TextEditingController _costController = TextEditingController();

  int? id;

  @override
  void initState() {
    super.initState();

    if (widget.request != null) {
      print('notNull');
      _nameController.text = widget.request?.carModel ?? '';
      _decController.text = widget.request?.details ?? '';
      id = widget.request?.id ?? -1;
      _costController.text = widget.request!.deliveryCost.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context, title: S.of(context).addCars),
      body: StackedForm(
          child: Form(
            key: _key,
            child: FixedContainer(
              child: CustomListView.custom(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.carModel,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _nameController,
                      hintText: S.current.carModel,
                      sufIcon: Icon(
                        FontAwesomeIcons.car,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.description,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      maxLines: 5,
                      controller: _decController,
                      hintText: S.current.description,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.deliveryCarsCost,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      maxLines: 2,
                      controller: _costController,
                      hintText: S.current.deliveryCarsCost,
                      numbers: true,
                      sufIcon: Icon(
                        FontAwesomeIcons.moneyBill,
                        color: Theme.of(context).primaryColor,
                      ),
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
              widget.onSave(CarRequest(
                  carModel: _nameController.text,
                  details: _decController.text,
                  id: id,
                  deliveryCost: num.parse(_costController.text)));
            } else {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.pleaseCompleteTheForm)
                  .show(context);
            }
          }),
    );
  }
}
