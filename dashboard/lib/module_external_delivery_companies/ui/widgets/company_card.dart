import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/external_delivery_companies_routes.dart';
import 'package:c4d/module_external_delivery_companies/model/company_model.dart';
import 'package:c4d/module_external_delivery_companies/request/company_request/update_delivery_company_status_request.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/show_confirm_dialog.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';

class CompanyCard extends StatefulWidget {
  final CompanyModel _company;
  final Function(UpdateDeliveryCompanyStatusRequest request)
      onCompanyStatusChange;
  final Function() onCompanyDelete;

  const CompanyCard({
    super.key,
    required CompanyModel company,
    required this.onCompanyStatusChange,
    required this.onCompanyDelete,
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
              SizedBox(),
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
                              // NavigatorAssistant.nonDeliveringIndex = 1;
                              // getIt<GlobalStateManager>()
                              //     .goToNonDeliveredOrder();
                              Navigator.pushNamed(
                                  context, OrdersRoutes.PENDING_ORDERS_SCREEN,
                                  arguments: [widget._company.name]);
                            }),
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
}
