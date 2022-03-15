import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/ui/widget/company_list_tile.dart';
import 'package:c4d/module_orders/model/company_info_model.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/phone_number_formtter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyInfoScreen extends StatefulWidget {
  final CompanyInfoModel model;
  CompanyInfoScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<CompanyInfoScreen> createState() => _CompanyInfoScreenState();
}

class _CompanyInfoScreenState extends State<CompanyInfoScreen> {
  late CompanyInfoModel company;
  @override
  void initState() {
    company = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context, title: S.current.companyInfo),
      body: CustomListView.custom(children: [
        CompanyListTile(
          number: true,
          icon: Icons.phone_android_rounded,
          subtitle:
              PhoneNumberFormatter.format(company.phone) ?? S.current.unknown,
          title: S.current.phoneNumber,
          onTap: () {
            var url = 'tel:+${company.phone}';
            canLaunch(url).then((value) {
              if (value) {
                launch(url);
              }
            });
          },
        ),
        CompanyListTile(
          number: true,
          icon: Icons.phone_rounded,
          subtitle:
              PhoneNumberFormatter.format(company.phone2) ?? S.current.unknown,
          title: S.current.phoneNumber + ' ' + '2',
          onTap: () {
            var url = 'tel:+${company.phone2}';
            canLaunch(url).then((value) {
              if (value) {
                launch(url);
              }
            });
          },
        ),
        CompanyListTile(
          number: true,
          icon: Icons.whatsapp_rounded,
          subtitle: PhoneNumberFormatter.format(company.whatsapp) ??
              S.current.unknown,
          title: S.current.whatsapp,
          onTap: () {
            var url = 'https://wa.me/${company.whatsapp}';
            canLaunch(url).then((value) {
              if (value) {
                launch(url);
              }
            });
          },
        ),
        CompanyListTile(
          icon: Icons.email,
          subtitle: company.email ?? S.current.unknown,
          title: S.current.email,
          onTap: () {
            var url = 'mailto:${company.email}?subject=C4d store owners&body=';
            canLaunch(url).then((value) {
              if (value) {
                launch(url);
              }
            });
          },
        ),
        CompanyListTile(
          icon: Icons.fax_rounded,
          subtitle: company.fax ?? S.current.unknown,
          title: S.current.fax,
        ),
      ]),
    );
  }
}
