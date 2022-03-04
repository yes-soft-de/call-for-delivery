import 'dart:typed_data';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/widgets/label_text.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/effect/checked.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewOrderStateBranchesLoaded extends States {
  List<BranchesModel> branches;
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
  String? imagePath;

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // branches
                Column(
                  children: [
                    ListTile(
                      title: LabelText(S.of(context).branch),
                      subtitle: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).backgroundColor),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                                value: screenState.branch,
                                items: _getBranches(),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                hint: Text(S.current.chooseBranch),
                                onChanged: (int? value) {
                                  screenState.branch = value;
                                  screenState.refresh();
                                }),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                // phone
                ListTile(
                  title: LabelText(S.of(context).recipientPhoneNumber),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: CustomLoginFormField(
                            controller: screenState.phoneNumberController,
                            phone: true,
                            hintText: '5xxxxxxxx'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 28.0),
                        child: SizedBox(
                          width: 125,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomLoginFormField(
                              halfField: true,
                              contentPadding:
                                  EdgeInsets.only(left: 8.0, right: 8.0),
                              controller: screenState.countryNumberController,
                              numbers: true,
                              phoneHint: false,
                              maxLength: 3,
                              hintText: S.current.countryCode,
                              sufIcon: Padding(
                                padding: const EdgeInsets.only(
                                    right: 4.0, left: 4.0),
                                child: Container(
                                  width: 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor),
                                  child: Center(
                                    child: Text(
                                      '+',
                                      style: Theme.of(context)
                                          .textTheme
                                          .button
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // to
                ListTile(
                  title: LabelText(S.of(context).destinationAddress),
                  subtitle: CustomFormField(
                    hintText: S.of(context).locationOfCustomer,
                    onTap: () {},
                    controller: screenState.toController,
                  ),
                ),
                // order details
                ListTile(
                  title: LabelText(S.of(context).orderDetails),
                  subtitle: CustomFormField(
                    maxLines: 3,
                    hintText: S.of(context).orderDetailHint,
                    controller: screenState.orderDetailsController,
                  ),
                ),
                // order price
                ListTile(
                  title: LabelText(S.of(context).orderPrice),
                  subtitle: CustomFormField(
                    hintText: S.of(context).orderCostWithDeliveryCost,
                    onTap: () {},
                    numbers: true,
                    last: true,
                    controller: screenState.priceController,
                  ),
                ),
                // upload image
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0, left: 24),
                      child: Text(
                        S.current.uploadImageIfyouHave,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 16.0, left: 16, top: 8, bottom: 16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {
                          var isDark =
                              getIt<ThemePreferencesHelper>().isDarkMode();

                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: double.maxFinite,
                                                child: TextButton(
                                                    style: TextButton.styleFrom(
                                                        shape: StadiumBorder()),
                                                    onPressed: () {
                                                      pickImageFromCamera();
                                                    },
                                                    child: Text(
                                                        S.current.camera,
                                                        style: isDark
                                                            ? TextStyle(
                                                                color: Colors
                                                                    .white70)
                                                            : null)),
                                              ),
                                              Divider(
                                                indent: 16,
                                                endIndent: 16,
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                                thickness: 2.5,
                                              ),
                                              SizedBox(
                                                width: double.maxFinite,
                                                child: TextButton(
                                                    style: TextButton.styleFrom(
                                                        shape: StadiumBorder()),
                                                    onPressed: () {
                                                      pickImageFromGallery();
                                                    },
                                                    child: Text(
                                                        S.current.gallery,
                                                        style: isDark
                                                            ? TextStyle(
                                                                color: Colors
                                                                    .white70)
                                                            : null)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: double.maxFinite,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                shape: StadiumBorder()),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                S.current.close,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button,
                                              ),
                                            )),
                                      ),
                                    )
                                  ],
                                );
                              });
                        },
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Checked(
                              checked: memoryBytes != null,
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
                                          color:
                                              Theme.of(context).disabledColor),
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
                  ],
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
                            orderDate = DateTime(dateTime.year, dateTime.month,
                                dateTime.day, time.hour, time.minute);
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
                  height: 75,
                ),
              ],
            ),
          ),
        ),
        label: S.current.createNewOrder,
        onTap: () {
          if (_formKey.currentState?.validate() == true &&
              screenState.branch != null &&
              screenState.payments != null) {
            showDialog(
                context: context,
                builder: (context) {
                  return CustomAlertDialog(
                      onPressed: () {
                        Navigator.of(context).pop();
                        createOrder();
                      },
                      content: S.current.confirmMakeOrder);
                });
          } else if (screenState.payments == null) {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseProvidePaymentMethode)
                .show(context);
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteField)
                .show(context);
          }
        });
  }

  // Future<String> getClipBoardData() async {
  //  // ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
  //   return data.text;
  // }

  // function to upload image then create order
  void createOrderWithImage() {
    screenState.currentState = LoadingState(screenState);
    screenState.refresh();
    getIt<ImageUploadService>().uploadImage(imagePath).then((value) {
      if (value == null) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: S.current.errorUploadingImages)
            .show(screenState.context);
      }
      screenState.addNewOrder(CreateOrderRequest(
          fromBranch: screenState.branch,
          recipientName: screenState.receiptNameController.text.trim(),
          recipientPhone: screenState.countryNumberController.text.trim() +
              screenState.phoneNumberController.text.trim(),
          destination: GeoJson(link: screenState.toController.text.trim()),
          note: screenState.orderDetailsController.text.trim(),
          detail: screenState.orderDetailsController.text.trim(),
          orderCost: num.parse(screenState.priceController.text.trim()),
          image: value,
          date: orderDate.toUtc().toIso8601String(),
          payment: screenState.payments));
    });
  }

  // function create order without upload image
  void createOrderWithoutImage() {
    screenState.addNewOrder(CreateOrderRequest(
        fromBranch: screenState.branch,
        recipientName: screenState.receiptNameController.text.trim(),
        recipientPhone: screenState.countryNumberController.text.trim() +
            screenState.phoneNumberController.text.trim(),
        destination: GeoJson(link: screenState.toController.text.trim()),
        note: screenState.orderDetailsController.text.trim(),
        detail: screenState.orderDetailsController.text.trim(),
        orderCost: num.parse(screenState.priceController.text.trim()),
        image: '',
        date: orderDate.toUtc().toIso8601String(),
        payment: screenState.payments));
  }

  void createOrder() {
    if (imagePath == null) {
      createOrderWithoutImage();
    } else {
      createOrderWithImage();
    }
  }

  void pickImageFromCamera() {
    Navigator.of(screenState.context).pop();
    ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 80)
        .then((value) async {
      memoryBytes = await value?.readAsBytes();
      imagePath = value?.path;
      screenState.refresh();
    });
  }

  void pickImageFromGallery() {
    Navigator.of(screenState.context).pop();
    ImagePicker.platform
        .pickImage(source: ImageSource.gallery)
        .then((value) async {
      memoryBytes = await value?.readAsBytes();
      imagePath = value?.path;
      screenState.refresh();
    });
  }

  List<DropdownMenuItem<int>> _getBranches() {
    var branchDropDown = <DropdownMenuItem<int>>[];
    branches.forEach((element) {
      branchDropDown.add(DropdownMenuItem(
        child: Text(
          element.branchName,
          overflow: TextOverflow.ellipsis,
        ),
        value: element.id,
      ));
    });
    return branchDropDown;
  }
}
