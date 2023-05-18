import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/model/captain_finance_by_hours_model.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_hours.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';

class FinanceByHoursForm extends StatefulWidget {
  final Function(CreateCaptainFinanceByHoursRequest) onSave;
  final CaptainFinanceByHoursModel? request;
  @override
  _CategoryFormState createState() => _CategoryFormState();

  FinanceByHoursForm({required this.onSave, this.request});
}

class _CategoryFormState extends State<FinanceByHoursForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _hoursCount = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _compensationController = TextEditingController();

  int? id;
  String? status = 'active';

  @override
  void initState() {
    super.initState();

    if (widget.request != null) {
      _hoursCount.text = widget.request?.countHours.toStringAsFixed(2) ?? '';
      _salaryController.text = widget.request?.salary.toStringAsFixed(2) ?? '';
      _compensationController.text =
          widget.request?.compensationForEveryOrder.toStringAsFixed(2) ?? '';
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
                        S.current.countHours,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      maxLength: 10,
                      controller: _hoursCount,
                      hintText: '${S.current.eg} 3',
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
                        S.current.compensationForEveryOrder,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      maxLength: 10,
                      controller: _compensationController,
                      hintText: '${S.current.eg} 100',
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
              widget.onSave(CreateCaptainFinanceByHoursRequest(
                countHours: num.tryParse(_hoursCount.text.trim()) ?? 0,
                compensationForEveryOrder:
                    num.tryParse(_compensationController.text.trim()) ?? 0,
                salary: num.tryParse(_salaryController.text) ?? 0,
              ));
            } else {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.pleaseCompleteTheForm);
            }
          }),
    );
  }
}
