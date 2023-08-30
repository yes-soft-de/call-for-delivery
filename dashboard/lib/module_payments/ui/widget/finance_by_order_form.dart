import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/model/captain_finance_by_order_model.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_order_request.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';

class FinanceByOrderForm extends StatefulWidget {
  final Function(CreateCaptainFinanceByOrderRequest) onSave;
  final CaptainFinanceByOrderModel? request;
  @override
  _CategoryFormState createState() => _CategoryFormState();

  FinanceByOrderForm({required this.onSave, this.request});
}

class _CategoryFormState extends State<FinanceByOrderForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _minimumKiloMetersController =
      TextEditingController();
  final TextEditingController _maxKiloMetersController =
      TextEditingController();
  final TextEditingController _bounceController = TextEditingController();
  final TextEditingController _orderCountController = TextEditingController();

  int? id;
  String? status = 'active';

  @override
  void initState() {
    super.initState();

    if (widget.request != null) {
      _categoryNameController.text = widget.request?.categoryName ?? '';
      _amountController.text = widget.request?.amount.toStringAsFixed(2) ?? '';
      _minimumKiloMetersController.text =
          widget.request?.countKilometersFrom.toStringAsFixed(2) ?? '';
      _maxKiloMetersController.text =
          widget.request?.countKilometersTo.toStringAsFixed(2) ?? '0';
      _bounceController.text = widget.request?.bounce.toStringAsFixed(2) ?? '0';
      _orderCountController.text =
          widget.request?.bounceCountOrdersInMonth.toStringAsFixed(2) ?? '0';
      id = widget.request?.id ?? -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context, title: S.of(context).addPackage),
      body: StackedForm(
          visible: MediaQuery.of(context).viewInsets.bottom == 0,
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
                      controller: _categoryNameController,
                      hintText: S.current.packageName,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.amount,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      maxLength: 10,
                      controller: _amountController,
                      hintText: '${S.current.eg} 100',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.bounceCountOrdersInMonth,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      maxLength: 10,
                      controller: _orderCountController,
                      hintText: '${S.current.eg} 5',
                      numbers: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.countKilometersFrom,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      maxLength: 10,
                      controller: _minimumKiloMetersController,
                      hintText: '10',
                      numbers: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.countKilometersTo,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      maxLength: 10,
                      controller: _maxKiloMetersController,
                      hintText: '30',
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
                      maxLength: 10,
                      controller: _bounceController,
                      hintText: S.current.cost,
                      numbers: true,
                      last: true,
                    ),
                    SizedBox(
                      height: 75,
                    ),
                  ]),
            ),
          ),
          label: S.current.save,
          onTap: () {
            if (_key.currentState?.validate() == true) {
              Navigator.pop(context);
              widget.onSave(CreateCaptainFinanceByOrderRequest(
                  categoryName: _categoryNameController.text.trim(),
                  countKilometersFrom:
                      num.tryParse(_minimumKiloMetersController.text) ?? 0,
                  countKilometersTo:
                      num.tryParse(_maxKiloMetersController.text) ?? 0,
                  amount: num.tryParse(_amountController.text) ?? 0,
                  bounce: num.tryParse(_bounceController.text) ?? 0,
                  bounceCountOrdersInMonth:
                      num.tryParse(_orderCountController.text) ?? 0));
            } else {
              CustomFlushBarHelper.createError(
                  title: S.current.warnning,
                  message: S.current.pleaseCompleteTheForm);
            }
          }),
    );
  }
}
