import 'dart:developer';
import 'dart:typed_data';
import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/request/confirm_captain_location_request.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/ui/screens/order_recylcing_screen.dart';
import 'package:c4d/module_orders/ui/widgets/custom_step.dart';
import 'package:c4d/module_orders/ui/widgets/label_text.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/effect/checked.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_country_number/the_country_number.dart';

class OrderRecyclingLoaded extends States {
  OrderDetailsModel orderInfo;
  final OrderRecyclingScreenState screenState;
  OrderRecyclingLoaded(
    this.screenState,
    this.orderInfo,
  ) : super(screenState) {
    screenState.orderDetailsController.text = orderInfo.note ?? '';
    screenState.noteController.text = orderInfo.note ?? '';
    screenState.receiptNameController.text = orderInfo.customerName;

    var number = orderInfo.customerPhone;
    if (number == S.current.unknown) number = '';
    if (number.isNotEmpty || number != '') {
      final sNumber =
          TheCountryNumber().parseNumber(internationalNumber: '+' + number);
      if (sNumber.dialCode.length > 0) {
        screenState.countryNumberController.text =
            sNumber.dialCode.substring(1);
      }
      screenState.phoneNumberController.text = sNumber.number;
    }
    screenState.toController.text = orderInfo.destinationLink ?? '';
    screenState.priceController.text = orderInfo.orderCost.toString();
    screenState.payments = orderInfo.payment;
    screenState.branch = orderInfo.branchID;
    screenState.customerLocation = orderInfo.destinationCoordinate != null
        ? LatLng(orderInfo.destinationCoordinate?.latitude ?? 0,
            orderInfo.destinationCoordinate?.longitude ?? 0)
        : null;
    orderIsMain = orderInfo.orderIsMain;
    imagePath = orderInfo.imagePath;
    image = orderInfo.image;
    screenState.refresh();
  }
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
  int orderType = 1;
  bool orderIsMain = false;
  String? image;
  @override
  Widget getUI(BuildContext context) {
    var decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).backgroundColor);
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
                        subtitle: Text(orderInfo.branchName)),
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
                                  child: Visibility(
                                    visible: image == null,
                                    replacement: Image.network(image ?? ''),
                                    child: Image.memory(
                                      memoryBytes ?? Uint8List(0),
                                      fit: BoxFit.cover,
                                    ),
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
        label: S.current.republish,
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

  List<Widget> getStepper(int currentIndex) {
    List<Widget> steps = [
      CustomStep(status: OrderStatusEnum.WAITING, currentIndex: currentIndex),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, left: 4.0),
          child: Opacity(
            opacity: 0.65,
            child: Container(
              height: 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: currentIndex <
                        StatusHelper.getOrderStatusIndex(
                            OrderStatusEnum.GOT_CAPTAIN)
                    ? Theme.of(screenState.context).disabledColor
                    : Theme.of(screenState.context).primaryColor,
              ),
            ),
          ),
        ),
      ),
      CustomStep(
          status: OrderStatusEnum.GOT_CAPTAIN, currentIndex: currentIndex),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, left: 4.0),
          child: Opacity(
            opacity: 0.65,
            child: Container(
              height: 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: currentIndex <
                        StatusHelper.getOrderStatusIndex(
                            OrderStatusEnum.IN_STORE)
                    ? Theme.of(screenState.context).disabledColor
                    : Theme.of(screenState.context).primaryColor,
              ),
            ),
          ),
        ),
      ),
      CustomStep(status: OrderStatusEnum.IN_STORE, currentIndex: currentIndex),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, left: 4.0),
          child: Opacity(
            opacity: 0.65,
            child: Container(
              height: 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: currentIndex <
                        StatusHelper.getOrderStatusIndex(
                            OrderStatusEnum.DELIVERING)
                    ? Theme.of(screenState.context).disabledColor
                    : Theme.of(screenState.context).primaryColor,
              ),
            ),
          ),
        ),
      ),
      CustomStep(
          status: OrderStatusEnum.DELIVERING, currentIndex: currentIndex),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, left: 4.0),
          child: Opacity(
            opacity: 0.65,
            child: Container(
              height: 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: currentIndex <
                        StatusHelper.getOrderStatusIndex(
                            OrderStatusEnum.FINISHED)
                    ? Theme.of(screenState.context).disabledColor
                    : Theme.of(screenState.context).primaryColor,
              ),
            ),
          ),
        ),
      ),
      CustomStep(status: OrderStatusEnum.FINISHED, currentIndex: currentIndex),
    ];
    return steps;
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
      screenState.manager.recycle(
          screenState,
          CreateOrderRequest(
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
              orderCost: num.parse(screenState.priceController.text.trim()),
              image: value,
              date: orderDate.toUtc().toIso8601String(),
              payment: screenState.payments));
    });
  }

  // function create order without upload image
  void createOrderWithoutImage() {
    screenState.manager.recycle(
        screenState,
        CreateOrderRequest(
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
}
