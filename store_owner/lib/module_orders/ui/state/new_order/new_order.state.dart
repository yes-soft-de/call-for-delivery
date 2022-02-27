import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/widgets/label_text.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
                ListTile(
                  title: LabelText(S.of(context).to),
                  subtitle: CustomFormField(
                    hintText: S.of(context).destinationAddress,
                    onTap: () {},
                    controller: TextEditingController(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
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
                SizedBox(
                  height: 16,
                ),
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
