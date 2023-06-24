import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/show_confirm_dialog.dart';
import 'package:c4d/module_stores/model/store_profile_model.dart';
import 'package:c4d/module_stores/model/store_setting_model.dart';
import 'package:c4d/module_stores/request/edit_store_setting_request.dart';
import 'package:c4d/module_stores/request/welcome_package_payment_request.dart';
import 'package:c4d/module_stores/ui/screen/edit_store_setting_screen.dart';
import 'package:c4d/module_stores/ui/widget/add_store_widget.dart';
import 'package:flutter/material.dart';

class EditStoreSettingStateLoaded extends States {
  EditStoreSettingScreenState screenState;
  StoreProfileModel profile;
  StoreSettingModel setting;

  TextEditingController maxLimitController = TextEditingController();

  EditStoreSettingStateLoaded(this.screenState, this.profile, this.setting)
      : super(screenState) {
    maxLimitController.text = setting.subscriptionCostLimit.toString();
  }

  @override
  Widget getUI(BuildContext context) {
    if (screenState.currentIndex == 0) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8 -
            MediaQuery.of(context).viewInsets.bottom,
        width: MediaQuery.sizeOf(context).width,
        child: UpdateStoreWidget(
          storesModel: profile,
          updateStore: (request, haveImage) {
            screenState.updateStore(request, haveImage);
            screenState.refreshThePreviousScreen = true;
          },
        ),
      );
    } else if (screenState.currentIndex == 1) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8 -
            MediaQuery.of(context).viewInsets.bottom,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(width: double.infinity, height: 20),
                        Text(
                          S.current.enterTheMaxLimitThatAreAllowedToStoreDues,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    // textAlign: TextAlign.end,
                                    controller: maxLimitController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(S.current.saudiRiyal),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Divider(endIndent: 20, indent: 20),
                        SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child: ElevatedButton(
                            child: Text(S.current.save),
                            onPressed: () {
                              showConfirmDialog(
                                context,
                                hasCancelButton: true,
                                title: S.current.attention,
                                message:
                                    '${S.current.areYouSureThatYouWantToUpdateTheSettingOf} ${profile.storeOwnerName}',
                                confirmButtonTitle: Text(S.current.confirm,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.black)),
                                confirmButtonColor: Colors.amber,
                                onConfirm: () {
                                  screenState.createOrUpdateStoreSetting(
                                    EditStoreSettingRequest(
                                        id: setting.id,
                                        storeOwnerProfile: profile.id,
                                        subscriptionCostLimit: int.tryParse(
                                                maxLimitController.text) ??
                                            0),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Visibility(
                  visible: !setting.openingPackagePaymentHasPassed,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(width: double.infinity, height: 20),
                          Text(
                            S.current.skipPaymentStageForWelcomePackage,
                            style:
                                Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child: ElevatedButton(
                              child: Text(S.current.skip),
                              onPressed: () {
                                showConfirmDialog(
                                  context,
                                  hasCancelButton: true,
                                  title: S.current.attention,
                                  message:
                                      '${S.current.areYouSureAboutSkipPaymentStageFor} ${profile.storeOwnerName}',
                                  confirmButtonTitle: Text(S.current.confirm,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.black)),
                                  confirmButtonColor: Colors.amber,
                                  onConfirm: () {
                                    screenState.updateWelcomePackagePayment(
                                        WelcomePackagePaymentRequest(
                                      id: profile.id,
                                      openingSubscriptionWithoutPayment: true,
                                    ));
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Placeholder();
  }
}
