import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/store_profile_model.dart';
import 'package:c4d/module_stores/ui/screen/edit_store_setting_screen.dart';
import 'package:c4d/module_stores/ui/widget/add_store_widget.dart';
import 'package:flutter/material.dart';

class EditStoreSettingStateLoaded extends States {
  EditStoreSettingScreenState screenState;
  StoreProfileModel profile;

  TextEditingController maxLimitController = TextEditingController();

  EditStoreSettingStateLoaded(this.screenState, this.profile)
      : super(screenState);

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
            Navigator.of(context).pop();
            screenState.updateStore(request, haveImage);
            screenState.refreshThePreviousScreen = true;
          },
        ),
      );
    } else if (screenState.currentIndex == 1) {
      return Padding(
        padding: const EdgeInsets.all(30),
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                                decoration:
                                    InputDecoration(border: InputBorder.none),
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
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(width: double.infinity, height: 20),
                    Text(
                      S.current.skipPaymentStageForWelcomePackage,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      child: ElevatedButton(
                        child: Text(S.current.skip),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Placeholder();
  }
}
