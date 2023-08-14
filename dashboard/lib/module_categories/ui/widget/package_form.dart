import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/model/packages_model.dart';
import 'package:c4d/module_categories/request/package_request.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';

class PackageForm extends StatefulWidget {
  final Function(PackageRequest) onSave;
  final PackagesModel? request;
  @override
  _CategoryFormState createState() => _CategoryFormState();

  PackageForm({required this.onSave, this.request});
}

class _CategoryFormState extends State<PackageForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _costController = TextEditingController();
  final TextEditingController _carCountController = TextEditingController();
  final TextEditingController _orderCountController = TextEditingController();
  final TextEditingController _geographicalRangeController =
      TextEditingController();
  final TextEditingController _expiredCountController = TextEditingController();
  final TextEditingController _extraCostController = TextEditingController();
  int? id;
  String? status = 'active';
  var type = 0;
  @override
  void initState() {
    super.initState();

    if (widget.request != null) {
      print('notNull');
      _nameController.text = widget.request?.name ?? '';
      _noteController.text = widget.request?.note ?? '';
      _cityController.text = widget.request?.city ?? '';
      _expiredCountController.text = widget.request?.expired.toString() ?? '';
//
      type = widget.request?.type.toInt() ?? 0;

      _geographicalRangeController.text =
          widget.request?.geographicalRange?.toString() ?? '';
      _extraCostController.text = widget.request?.extraCost?.toString() ?? '';
//

      _costController.text = widget.request?.cost.toString() ?? '0';
      _carCountController.text = widget.request?.carCount.toString() ?? '0';
      _orderCountController.text = widget.request?.orderCount.toString() ?? '0';
      _geographicalRangeController.text =
          widget.request?.geographicalRange?.toString() ?? '';
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
                        S.current.packageName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _nameController,
                      hintText: S.current.packageName,
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
                        S.current.orderCount,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _orderCountController,
                      hintText: S.current.orderCount,
                      numbers: true,
                    ),
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
                      controller: _expiredCountController,
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
                    // type
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                      child: CheckboxListTile(
                          value: type == 0 ? false : true,
                          title: Text(S.current.onOrderPackage),
                          onChanged: (bool? v) {
                            type = (v ?? false) ? 1 : 0;
                            setState(() {});
                          }),
                    ),
                    // geographicalRange
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.geographicalRange,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _geographicalRangeController,
                      hintText: S.current.geographicalRange,
                      numbers: true,
                    ),
                    // extraCost
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.extraCost,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _extraCostController,
                      hintText: S.current.extraCostHint,
                      numbers: true,
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.note,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      maxLines: 8,
                      controller: _noteController,
                      hintText: S.current.description,
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
              widget.onSave(PackageRequest(
                  name: _nameController.text,
                  note: _noteController.text,
                  id: id,
                  extraCost: num.tryParse(_extraCostController.text),
                  geographicalRange:
                      num.tryParse(_geographicalRangeController.text),
                  orderCount: int.parse(_orderCountController.text),
                  type: type,
                  cost: int.parse(_costController.text),
                  carCount: int.parse(_carCountController.text),
                  city: _cityController.text,
                  expired: int.parse(_expiredCountController.text),
                  status: status));
            } else {
              CustomFlushBarHelper.createError(
                  title: S.current.warnning,
                  message: S.current.pleaseCompleteTheForm);
            }
          }),
    );
  }
}
