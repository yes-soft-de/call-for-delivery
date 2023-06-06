// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/external_delivery_companies_routes.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/show_confirm_dialgo.dart';
import 'package:flutter/material.dart';

class CompanySettingCard extends StatefulWidget {
  final CompanySetting companySetting;

  const CompanySettingCard({super.key, required this.companySetting});

  @override
  State<CompanySettingCard> createState() => _CompanySettingCardState();
}

class _CompanySettingCardState extends State<CompanySettingCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xffE2F0F9),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.companySetting.settingName),
                    Switch(
                      activeTrackColor: Color(0xff165177),
                      thumbColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      value: widget.companySetting.isActive,
                      onChanged: (value) {
                        widget.companySetting.isActive = value;
                        setState(() {});
                      },
                      // TODO: call active disable settings endpoint
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomIconButton(
            backgroundColor: Colors.green,
            icon: Icons.edit_outlined,
            onPressed: () {
              Navigator.pushNamed(
                  context,
                  ExternalDeliveryCompaniesRoutes
                      .EDIT_Delivery_COMPANY_SETTINGS_SCREEN,
                  arguments: [widget.companySetting]);
            },
          ),
          CustomIconButton(
            backgroundColor: Colors.red,
            icon: Icons.delete,
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
                message: S.current.thisWillDeleteAllDataAndStanders,
                onConfirm: () {
                  // TODO: call delete company endpoint
                },
                title: S.current.areYouSureForDeleteSetting,
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final void Function() onPressed;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      icon: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
