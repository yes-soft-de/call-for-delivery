import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/external_delivery_companies_routes.dart';
import 'package:c4d/module_external_delivery_companies/model/company.dart';
import 'package:flutter/material.dart';

class CompanyCard extends StatefulWidget {
  final Company _company;
  const CompanyCard({super.key, required Company company}) : _company = company;

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
                  // TODO: call active or disable endpoint
                },
              ),
            ],
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff0360A1)),
                      child: Text(S.current.deliveryStandards),
                      onPressed: () {
                        // TODO: navigate to delivery stander setting screen
                        Navigator.pushNamed(
                            context,
                            ExternalDeliveryCompaniesRoutes
                                .Delivery_COMPANY_ALL_SETTINGS_SCREEN,
                            arguments: widget._company);
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text(S.current.delete),
                      onPressed: () {
                        // TODO: call delete this company endpoint
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
