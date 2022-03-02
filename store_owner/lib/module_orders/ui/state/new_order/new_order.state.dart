import 'dart:typed_data';

import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/widgets/label_text.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/effect/checked.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewOrderStateBranchesLoaded extends States {
  List<Branch> branches;
  final NewOrderScreenState screenState;
  NewOrderStateBranchesLoaded(this.branches, this.screenState)
      : super(screenState);
  final List<String> _paymentMethods = ['online', 'cash'];
  String _selectedPaymentMethod = 'online';
  DateTime orderDate = DateTime.now();
  DateTime dateTime = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Branch? activeBranch;
  LatLng? destination;
  Uint8List? memoryBytes;
  @override
  Widget getUI(context) {
    return StackedForm(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                // name
                ListTile(
                  title: LabelText(S.of(context).recipientName),
                  subtitle: CustomFormField(
                    hintText: S.of(context).nameHint,
                    onTap: () {},
                    controller: screenState.receiptNameController,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                // phone
                ListTile(
                  title: LabelText(S.of(context).recipientPhoneNumber),
                  subtitle: CustomFormField(
                    hintText: S.of(context).pleaseInputPhoneNumber,
                    numbers: true,
                    onTap: () {},
                    controller: screenState.phoneNumberController,
                    maxLines: 1,
                  ),
                ),
                // to
                ListTile(
                  title: LabelText(S.of(context).to),
                  subtitle: CustomFormField(
                    hintText: S.of(context).destinationAddress,
                    onTap: () {},
                    controller: screenState.toController,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                // order details
                ListTile(
                  title: LabelText(S.of(context).orderDetails),
                  subtitle: CustomFormField(
                    maxLines: 7,
                    hintText: S.of(context).orderDetailHint,
                    controller: screenState.orderDetailsController,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ListTile(
                  title: LabelText(S.of(context).orderPrice),
                  subtitle: CustomFormField(
                    hintText: S.of(context).totalPrice,
                    onTap: () {},
                    controller: screenState.priceController,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                // upload image
                Padding(
                  padding:
                      const EdgeInsets.only(right: 16.0, left: 16, bottom: 8),
                  child: Text(
                    S.current.uploadImageIfyouHave,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      ImagePicker.platform
                          .pickImage(source: ImageSource.gallery)
                          .then((value) async {
                        memoryBytes = await value?.readAsBytes();
                        // imagePath = value?.path;
                        screenState.refresh();
                      });
                    },
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: Checked(
                          checked: memoryBytes != null ,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Theme.of(context).backgroundColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload_sharp,
                                  color: Theme.of(context).disabledColor,
                                ),
                                Text(
                                  S.current.pressHere,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).disabledColor),
                                ),
                              ],
                            ),
                          ),
                          checkedWidget: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.memory(
                                memoryBytes ?? Uint8List(0),
                                fit: BoxFit.cover,
                              ))),
                    ),
                  ),
                ), // send
                SizedBox(
                  height: 16,
                ),
                // delivery date
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(25)),
                    child: ListTile(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          if (value == null) {
                          } else {
                            time = value;
                            screenState.refresh();
                          }
                        });
                      },
                      leading: const Icon(
                        Icons.timer,
                      ),
                      title: Text(S.of(context).orderTime),
                      trailing: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Theme.of(context).primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              time.format(context).toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                ),
                // payment method
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).paymentMethod,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: RadioListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            title: Text(S.of(context).card),
                            value: 'card',
                            groupValue: screenState.payments,
                            onChanged: (String? value) {
                              screenState.payments = value;
                              screenState.refresh();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: RadioListTile(
                            title: Text(S.of(context).cash),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            value: 'cash',
                            groupValue: screenState.payments,
                            onChanged: (String? value) {
                              screenState.payments = value;
                              screenState.refresh();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
        label: S.current.createNewOrder,
        onTap: () {});
  }

  // Future<String> getClipBoardData() async {
  //  // ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
  //   return data.text;
  // }

}
