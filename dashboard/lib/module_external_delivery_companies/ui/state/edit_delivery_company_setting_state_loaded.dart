import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/edit_delivery_company_setting_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/payment_card.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/store_card.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/work_hours_card.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:flutter/material.dart';

import '../widgets/distance_card.dart';

class EditDeliveryCompanySettingScreenStateLoaded extends States {
  final EditDeliveryCompanySettingScreenState _screenState;
  final CompanySetting companySetting;
  final isNewSetting;

  EditDeliveryCompanySettingScreenStateLoaded(
      this._screenState, this.companySetting, this.isNewSetting)
      : super(_screenState);

  final _settingNameController = TextEditingController();
  final _key = GlobalKey<FormState>();

  bool flag = true;

  @override
  Widget getUI(BuildContext context) {
    if (flag) {
      flag = false;
      _settingNameController.text = companySetting.settingName;
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: CustomListView.custom(
                children: [
                  Text(S.current.settingName),
                  Form(
                    key: _key,
                    child: CustomFormField(
                      textStyle: TextStyle(color: Color(0xff024D92)),
                      radius: 10,
                      backgroundColor: Color(0xffD9E4EF),
                      controller: _settingNameController,
                      validator: true,
                    ),
                  ),
                  WorkHoursCard(
                    workHours: companySetting.workingHours,
                    onChange: (workHours) {
                      companySetting.workingHours = workHours;
                    },
                  ),
                  DistanceCard(
                    distance: companySetting.distance,
                    onChange: (distance) {
                      companySetting.distance = distance;
                    },
                  ),
                  StoresCard(
                    storeType: companySetting.storeType,
                    Stores: companySetting.stores,
                    onStoreTypeChange: (storeType) {
                      companySetting.storeType = storeType;
                    },
                    onStoresChange: (stores) {
                      companySetting.stores = stores;
                    },
                  ),
                  PaymentCard(
                    onChange: (paymentType) {
                      companySetting.paymentType = paymentType;
                    },
                    paymentType: companySetting.paymentType,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.7,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff024D92),
              ),
              child: Text(S.current.save),
              onPressed: () {
                if (_key.currentState?.validate() ?? false) {
                  // TODO: call save endpoint
                  // there is tow situation here
                  // 1. new setting
                  // 2. edit old setting
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
