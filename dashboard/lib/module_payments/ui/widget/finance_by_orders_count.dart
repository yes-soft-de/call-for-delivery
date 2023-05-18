import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/model/captain_finance_by_order_count.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_count_order_request.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_order_request.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';

class FinanceByOrderCountForm extends StatefulWidget {
  final Function(CreateCaptainFinanceByCountOrderRequest) onSave;
  final CaptainFinanceByOrdersCountModel? request;
  @override
  _CategoryFormState createState() => _CategoryFormState();

  FinanceByOrderCountForm({required this.onSave, this.request});
}

class _CategoryFormState extends State<FinanceByOrderCountForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _monthCompensationController =
      TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _minMonthCompensationController =
      TextEditingController();
  final TextEditingController _maxMonthCompensationController =
      TextEditingController();
  final TextEditingController _orderCountController = TextEditingController();

  int? id;
  String? status = 'active';

  @override
  void initState() {
    super.initState();

    if (widget.request != null) {
      _monthCompensationController.text =
          widget.request?.monthCompensation.toStringAsFixed(2) ?? '';
      _salaryController.text = widget.request?.salary.toStringAsFixed(2) ?? '';
      _minMonthCompensationController.text =
          widget.request?.bounceMinCountOrdersInMonth.toStringAsFixed(2) ?? '';
      _maxMonthCompensationController.text =
          widget.request?.bounceMaxCountOrdersInMonth.toStringAsFixed(2) ?? '0';
      _orderCountController.text =
          widget.request?.countOrdersInMonth.toString() ?? '0';
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
              child: CustomListView.custom(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.countOrdersInMonth,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      maxLength: 10,
                      controller: _orderCountController,
                      hintText: '${S.current.eg} 10',
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
                      maxLength: 10,
                      controller: _salaryController,
                      hintText: '${S.current.eg} 500',
                      numbers: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.bounceMinCountOrdersInMonth,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      maxLength: 10,
                      controller: _minMonthCompensationController,
                      hintText: '${S.current.eg} 10',
                      numbers: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.bounceMaxCountOrdersInMonth,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      maxLength: 10,
                      controller: _maxMonthCompensationController,
                      hintText: '${S.current.eg} 30',
                      numbers: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.monthCompensation,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      maxLength: 10,
                      controller: _monthCompensationController,
                      hintText: '${S.current.eg} 500',
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
              widget.onSave(CreateCaptainFinanceByCountOrderRequest(
                  bounceMinCountOrdersInMonth: num.tryParse(
                          _minMonthCompensationController.text.trim()) ??
                      0,
                  bounceMaxCountOrdersInMonth: num.tryParse(
                          _maxMonthCompensationController.text.trim()) ??
                      0,
                  salary: num.tryParse(_salaryController.text) ?? 0,
                  monthCompensation:
                      num.tryParse(_monthCompensationController.text.trim()) ??
                          0,
                  countOrdersInMonth:
                      num.tryParse(_orderCountController.text.trim()) ?? 0));
            } else {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.pleaseCompleteTheForm);
            }
          }),
    );
  }
}
