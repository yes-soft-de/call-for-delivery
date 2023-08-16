import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/external_delivery_companies_routes.dart';
import 'package:c4d/module_external_delivery_companies/model/company_model.dart';
import 'package:c4d/module_external_delivery_companies/request/company_request/update_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_request/update_delivery_company_status_request.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/show_confirm_dialog.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';

Color get _blue => Color(0xff0360A1);
Color get _white => Colors.white;
Color get _amber => Colors.amber;
Color get _black => Colors.black;

class CompanyCard extends StatefulWidget {
  final CompanyModel _company;
  final Function(UpdateDeliveryCompanyStatusRequest request)
      onCompanyStatusChange;
  final Function() onCompanyDelete;
  final Function(UpdateDeliveryCompanyRequest request) onCompanyUpdated;

  const CompanyCard({
    super.key,
    required CompanyModel company,
    required this.onCompanyStatusChange,
    required this.onCompanyDelete,
    required this.onCompanyUpdated,
  }) : _company = company;

  @override
  State<CompanyCard> createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: _blue),
                onPressed: () {
                  _editCompanyDialog(
                    context,
                    widget._company,
                    (request) {
                      widget.onCompanyUpdated(request);
                    },
                  );
                },
              ),
              Text(widget._company.name),
              Switch(
                thumbColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                activeColor: Colors.green,
                value: widget._company.isActive,
                onChanged: (value) {
                  widget._company.isActive = value;
                  setState(() {});
                  widget.onCompanyStatusChange(
                    UpdateDeliveryCompanyStatusRequest(
                      id: widget._company.id,
                      status: value,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0360A1)),
                    child: Text(S.current.deliveryStandards),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ExternalDeliveryCompaniesRoutes
                            .Delivery_COMPANY_ALL_SETTINGS_SCREEN,
                        arguments: widget._company,
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff0360A1)),
                          child: Text(S.current.orders),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              ExternalDeliveryCompaniesRoutes
                                  .EXTERNAL_ORDERS_SCREEN,
                              arguments: [widget._company],
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: Text(S.current.delete),
                          onPressed: () {
                            showConfirmDialog(
                              context,
                              confirmButtonColor: Colors.red,
                              confirmButtonTitle: Text(
                                S.current.delete,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                              message:
                                  S.current.thisWillDeleteAllDataAndStanders,
                              onConfirm: () {
                                widget.onCompanyDelete();
                              },
                              title: S.current.areYouSureForDelete +
                                  ' ' +
                                  widget._company.name +
                                  '؟',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _editCompanyDialog(
    BuildContext context,
    CompanyModel companyModel,
    Function(UpdateDeliveryCompanyRequest request) onEdit,
  ) {
    TextEditingController _companyNameController =
        TextEditingController(text: companyModel.name);
    return showDialog(
      context: context,
      builder: (context) {
        var textTheme = Theme.of(context).textTheme;
        return Dialog(
          backgroundColor: _blue,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.current.editCompanyInfo,
                  style: textTheme.titleMedium?.copyWith(
                    color: _white,
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.name,
                      style: textTheme.bodyMedium?.copyWith(
                        color: _white,
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomFormField(
                      controller: _companyNameController,
                      validator: true,
                      last: true,
                      onTapOutside: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _amber,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            var request = UpdateDeliveryCompanyRequest(
                              id: companyModel.id,
                              companyName: _companyNameController.text,
                            );
                            onEdit(request);
                          },
                          child: Text(
                            S.current.confirm,
                            style:
                                textTheme.bodyMedium?.copyWith(color: _black),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(S.current.cancel),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
