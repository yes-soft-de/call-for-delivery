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
import 'package:c4d/utils/helpers/contacts_helper.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/phone_number_detection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class NewOrderStateBranchesLoaded extends States {
  List<BranchesModel> branches;
  final NewOrderScreenState screenState;
  NewOrderStateBranchesLoaded(this.branches, this.screenState)
      : super(screenState) {
    if (branches.isNotEmpty) {
      screenState.branch = branches[0].id;
      activeBranch =
          branches.firstWhere((element) => element.id == screenState.branch);
      screenState.refresh();
    }
  }
  final List<String> _paymentMethods = ['online', 'cash'];
  String _selectedPaymentMethod = 'online';
  DateTime orderDate = DateTime.now();
  DateTime dateTime = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BranchesModel? activeBranch;
  LatLng? destination;
  Uint8List? memoryBytes;
  String? imagePath;
  int orderType = 1;
  bool orderIsMain = false;

  @override
  Widget getUI(context) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();
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
                                  activeBranch = branches.firstWhere(
                                      (element) => element.id == value);
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
                    validator: false,
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
                            sufIcon: Material(
                              color: Colors.transparent,
                              shape: CircleBorder(),
                              child: IconButton(
                                focusNode: FocusNode(skipTraversal: true),
                                splashRadius: 20,
                                onPressed: () async {
                                  ClipboardData? data = await Clipboard.getData(
                                      Clipboard.kTextPlain);
                                  screenState.phoneNumberController.text =
                                      PhoneNumberDetection.getPhoneNumber(
                                          data?.text ?? '');
                                  screenState.refresh();
                                },
                                icon: Icon(
                                  Icons.paste_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            hintText: '5xxxxxxxx'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 4.0, left: 4.0, bottom: 28),
                        child: InkWell(
                          radius: 20,
                          customBorder: CircleBorder(),
                          onTap: () {
                            ContactsHelper.getContactsDialog(context, (phone) {
                              screenState.phoneNumberController.text =
                                  PhoneNumberDetection.getPhoneNumber(phone);
                              screenState.refresh();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context).primaryColor),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '+',
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(
                                        color: Colors.white, fontSize: 20),
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
                    validator: false,
                    contentPadding: EdgeInsets.only(left: 16, right: 16),
                    hintText: S.of(context).locationOfCustomer,
                    onTap: () {},
                    controller: screenState.toController,
                    sufIcon: IconButton(
                      focusNode: FocusNode(skipTraversal: true),
                      focusColor: Colors.transparent,
                      splashRadius: 18,
                      color: Theme.of(context).colorScheme.primary,
                      icon: Icon(Icons.paste_rounded),
                      onPressed: getClipBoardData,
                    ),
                  ),
                ),
                Visibility(
                    visible: screenState.customerLocation != null &&
                        activeBranch != null,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.amber),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            S.current.distance +
                                ' ' +
                                (Geolocator.distanceBetween(
                                            activeBranch?.location.latitude ??
                                                0,
                                            activeBranch?.location.longitude ??
                                                0,
                                            screenState.customerLocation
                                                    ?.latitude ??
                                                0,
                                            screenState.customerLocation
                                                    ?.longitude ??
                                                0) /
                                        1000)
                                    .toStringAsFixed(2)
                                    .toString() +
                                ' ${S.current.km}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )),
                // order details
                ListTile(
                  title: LabelText(S.of(context).orderDetails),
                  subtitle: CustomFormField(
                    validator: false,
                    maxLines: 3,
                    hintText: S.of(context).orderDetailHint,
                    controller: screenState.orderDetailsController,
                  ),
                ),
                // order price
                ListTile(
                  title: LabelText(S.of(context).orderPrice),
                  subtitle: CustomFormField(
                    validator: false,
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
                          builder: (context, widget) {
                            if (isDark == false) return widget ?? SizedBox();
                            return Theme(
                                data: ThemeData.dark()
                                    .copyWith(primaryColor: Colors.indigo),
                                child: widget ?? SizedBox());
                          },
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
                // suborder check
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).backgroundColor),
                    child: Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          secondary: Icon(FontAwesomeIcons.boxes),
                          value: orderIsMain,
                          title: Text(S.current.thisOrderCanBeLinked),
                          onChanged: (check) {
                            if (check == true) {
                              orderIsMain = true;
                            } else {
                              orderIsMain = false;
                            }
                            screenState.refresh();
                          }),
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

  Future<void> getClipBoardData() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    screenState.toController.text = data?.text ?? '';
    screenState.refresh();
    return;
  }

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
          orderIsMain: orderIsMain,
          orderType: orderType,
          fromBranch: screenState.branch,
          recipientName: screenState.receiptNameController.text.trim(),
          recipientPhone: screenState.countryNumberController.text.trim() +
              screenState.phoneNumberController.text.trim(),
          destination: GeoJson(
              link: screenState.toController.text.trim(),
              lat: screenState.customerLocation?.latitude,
              lon: screenState.customerLocation?.longitude),
          note: screenState.orderDetailsController.text.trim(),
          detail: screenState.orderDetailsController.text.trim(),
          orderCost: num.tryParse(screenState.priceController.text.trim()),
          image: value,
          date: orderDate.toUtc().toIso8601String(),
          payment: screenState.payments));
    });
  }

  // function create order without upload image
  void createOrderWithoutImage() {
    screenState.addNewOrder(CreateOrderRequest(
        orderType: orderType,
        orderIsMain: orderIsMain,
        fromBranch: screenState.branch,
        recipientName: screenState.receiptNameController.text.trim(),
        recipientPhone: screenState.countryNumberController.text.trim() +
            screenState.phoneNumberController.text.trim(),
        destination: GeoJson(
            link: screenState.toController.text.trim(),
            lat: screenState.customerLocation?.latitude,
            lon: screenState.customerLocation?.longitude),
        note: screenState.orderDetailsController.text.trim(),
        detail: screenState.orderDetailsController.text.trim(),
        orderCost: num.tryParse(screenState.priceController.text.trim()),
        image: null,
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
