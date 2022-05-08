import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_company/model/company_finance_model.dart';
import 'package:c4d/module_company/model/company_model.dart';
import 'package:c4d/module_company/model/company_price.dart';
import 'package:c4d/module_company/request/create_company_profile.dart';
import 'package:c4d/module_company/request/delivery_company_financial.dart';
import 'package:c4d/module_company/request/financial_compensation_request.dart';
import 'package:c4d/module_company/ui/screen/company_finance_screen.dart';
import 'package:c4d/module_company/ui/screen/company_profile_screen.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

class CompanyFinanceLoadedState extends States {
  final CompanyFinanceScreenState screenState;
  final String? error;
  final bool empty;
  final CompanyProfileModel? model;

  CompanyFinanceLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.canAddCategories = false;
      screenState.refresh();
    }
    if (model != null) {
      phoneController.text = model?.phone ?? '';
      phone2Controller.text = model?.phone2 ?? '';
      whatsappController.text = model?.whatsapp ?? '';
      faxController.text = model?.fax ?? '';
      emailController.text = model?.email ?? '';
      stcController.text = model?.stc ?? '';
      bankController.text = model?.bank ?? '';

      kilometerLimt.text = model?.kilometers.toString() ?? '';
      minkilometerLimt.text = model?.minKilometerBonus.toString() ?? '';
      maxkilometerLimt.text = model?.maxKilometerBonus.toString() ?? '';

      storeProfitMargin.text = model?.storeProfitMargin.toString() ?? '';
      supplierProfitMargin.text = model?.supplierProfitMargin.toString() ?? '';
      screenState.refresh();
    }
  }

  String? id;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  var phone2Controller = TextEditingController();
  var whatsappController = TextEditingController();
  var faxController = TextEditingController();
  var emailController = TextEditingController();
  var stcController = TextEditingController();
  var bankController = TextEditingController();

  var kilometerLimt = TextEditingController();
  var minkilometerLimt = TextEditingController();
  var maxkilometerLimt = TextEditingController();

  var supplierProfitMargin = TextEditingController();
  var storeProfitMargin = TextEditingController();

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getFinance();
        },
        error: error,
      );
    }
    print(model?.whatsapp);
    return StackedForm(
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
                    S.current.kilometerLimt,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: kilometerLimt,
                  hintText: S.current.kilometerLimt,
                  numbers: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.kilometerLimtMin,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: minkilometerLimt,
                  hintText: S.current.kilometerLimtMin,
                  numbers: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.kilometerLimtMax,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: maxkilometerLimt,
                  hintText: S.current.kilometerLimtMax,
                  numbers: true,
                ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.supplierProfitMargin,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: supplierProfitMargin,
                      hintText: S.current.supplierProfitMargin,
                      numbers: true,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8, right: 12, top: 16.0),
                      child: Text(
                        S.current.storeProfitMargin,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: storeProfitMargin,
                      hintText: S.current.storeProfitMargin,
                      numbers: true,
                    ),

                SizedBox(
                  height: 100,
                ),
              ])),
        ),
        label: S.current.update,
        onTap: () {
          if (_key.currentState!.validate()) {
            if (empty || error != null) {
              screenState.createProfile(CreateCompanyProfile(
                phone: phoneController.text.trim(),
                phone2: phone2Controller.text.trim(),
                whatsapp: whatsappController.text.trim(),
                fax: faxController.text.trim(),
                bankName: bankController.text.trim(),
                stc: stcController.text.trim(),
                email: emailController.text.trim(),
              ));
            } else {
              screenState.UpdateCompanyProfile(CreateCompanyProfile(
                id: model?.id,
                phone: phoneController.text.trim(),
                phone2: phone2Controller.text.trim(),
                whatsapp: whatsappController.text.trim(),
                fax: faxController.text.trim(),
                bankName: bankController.text.trim(),
                stc: stcController.text.trim(),
                email: emailController.text.trim(),
                minKilometerBonus: minkilometerLimt.text,
                maxKilometerBonus: maxkilometerLimt.text,
                kilometers: kilometerLimt.text,
                supplierProfitMargin: supplierProfitMargin.text,
                storeProfitMargin: storeProfitMargin.text
              ));
            }
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm)
                .show(context);
          }
        });
  }
}
