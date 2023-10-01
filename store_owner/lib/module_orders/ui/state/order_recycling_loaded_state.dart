import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/ui/screens/order_recylcing_screen.dart';
import 'package:c4d/module_orders/ui/widgets/custom_step.dart';
import 'package:c4d/module_orders/ui/widgets/geo_widget.dart';
import 'package:c4d/module_orders/ui/widgets/label_text.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/module_upload/model/pdf_model.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/effect/checked.dart';
import 'package:c4d/utils/helpers/contacts_helper.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/phone_number_detection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:the_country_number/the_country_number.dart';

class OrderRecyclingLoaded extends States {
  OrderDetailsModel orderInfo;
  final OrderRecyclingScreenState screenState;
  List<BranchesModel> branches;
  OrderRecyclingLoaded(this.screenState, this.orderInfo, this.branches)
      : super(screenState) {
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
    pdfModel = PdfModel(
        pdfBaseUrl: orderInfo.pdf?.pdfBaseUrl,
        pdfPreview: orderInfo.pdf?.pdfPreview,
        pdfOnServerPath: orderInfo.pdf?.pdfOnServerPath);
    distance = orderInfo.storeBranchToClientDistance;
    print(screenState.branch);
    try {
      activeBranch =
          branches.firstWhere((element) => element.id == orderInfo.branchID);
    } catch (e) {}
    screenState.refresh();
  }
  final List<String> _paymentMethods = ['online', 'cash'];
  String _selectedPaymentMethod = 'online';
  DateTime? orderDate;
  DateTime dateTime = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BranchesModel? activeBranch;
  LatLng? destination;
  Uint8List? memoryBytes;
  String? imagePath;
  int orderType = 1;
  bool orderIsMain = false;
  String? image;
  PdfModel? pdfModel;
  String? distance;
  num? deliveryCost;
  @override
  Widget getUI(BuildContext context) {
    var decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.background);
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
                                    .labelLarge
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
                            child: GeoDistanceText(
                              finalDistance: (v) {
                                distance = v.distance;
                                deliveryCost = v.costDeliveryOrder?.total;
                                screenState.customerLocation =
                                    destination = LatLng(
                                  v.geoDestination?.lat ?? 0,
                                  v.geoDestination?.lon ?? 0,
                                );
                              },
                              request: screenState.geoDistanceRequest,
                            )),
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
                                                    .colorScheme
                                                    .background,
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
                                                    .labelLarge,
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
                              checked: memoryBytes != null || image != null,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
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
                                    replacement: Image.network(
                                      image ?? '',
                                      fit: BoxFit.cover,
                                    ),
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
                // upload pdf
                Visibility(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0, left: 24),
                        child: Text(
                          S.current.attachFile,
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
                            FilePicker.platform.pickFiles(
                                allowedExtensions: ['pdf'],
                                type: FileType.custom).then((result) async {
                              if (result != null) {
                                File file = File(result.files.single.path!);
                                pdfModel = PdfModel(pdfFilePath: file.path);
                                screenState.refresh();
                              } else {
                                // User canceled the picker
                              }
                            });
                          },
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: Checked(
                                checked: pdfModel?.pdfFilePath != null ||
                                    pdfModel?.pdfOnServerPath != null,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.attach_file_rounded,
                                        color: Theme.of(context).disabledColor,
                                      ),
                                      Text(
                                        S.current.pressHere,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .disabledColor),
                                      ),
                                    ],
                                  ),
                                ),
                                checkedWidget: Visibility(
                                  visible: pdfModel?.pdfFilePath != null ||
                                      pdfModel?.pdfOnServerPath != null,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.filePdf,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.check,
                                          color: Colors.green,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ), // send
                    ],
                  ),
                ),

                // delivery date
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
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
                              orderDate == null
                                  ? S.current.now
                                  : time.format(context).toString(),
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
                        color: Theme.of(context).colorScheme.background),
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
                Visibility(
                    visible: screenState.payments == 'cash' &&
                        screenState.priceController.text.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Flushbar(
                        title: S.current.warnning,
                        message: S.current.orderPriceOnCreditWarning,
                        titleColor: Colors.white,
                        messageColor: Colors.white,
                        backgroundColor: Colors.amber,
                        borderRadius: BorderRadius.circular(25),
                        mainButton: TextButton(
                          onPressed: () {
                            screenState.priceController.clear();
                            screenState.refresh();
                          },
                          child: Text(S.current.remove,
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    )),

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
                            color: Theme.of(context).colorScheme.background,
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
                            color: Theme.of(context).colorScheme.background,
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

                /// cost type
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).costType,
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
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: RadioListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            title: Text(S.of(context).orderCostAndDelivery),
                            value: 187,
                            groupValue: screenState.costType,
                            onChanged: (int? value) {
                              screenState.costType = value;
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
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: RadioListTile(
                            title: Text(S.of(context).deliveryOnly),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            value: 186,
                            groupValue: screenState.costType,
                            onChanged: (int? value) {
                              screenState.costType = value;
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
            order: screenState.orderId,
            pdf: pdfModel?.getPdfRequest(),
            cancel: -1,
            distance: distance,
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
            date: orderDate == null
                ? DateTime.now().toUtc().toIso8601String()
                : orderDate?.toUtc().toIso8601String(),
            payment: screenState.payments,
            deliveryCost: deliveryCost,
            costType: screenState.costType,
          ));
    });
  }

  // function create order without upload image
  void createOrderWithoutImage() {
    screenState.manager.recycle(
        screenState,
        CreateOrderRequest(
          order: screenState.orderId,
          cancel: -1,
          orderType: orderType,
          pdf: pdfModel?.getPdfRequest(),
          distance: distance,
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
          image: imagePath ?? null,
          date: orderDate == null
              ? DateTime.now().toUtc().toIso8601String()
              : orderDate?.toUtc().toIso8601String(),
          payment: screenState.payments,
          deliveryCost: deliveryCost,
          costType: screenState.costType,
        ));
  }

  void createOrder() {
    if (imagePath == null) {
      if (pdfModel?.pdfFilePath != null) {
        screenState.currentState = LoadingState(screenState);
        screenState.refresh();
        pdfModel?.uploadPdf().then((value) {
          createOrderWithoutImage();
        });
      } else {
        createOrderWithoutImage();
      }
    } else if (image != null && imagePath != null && memoryBytes == null) {
      if (pdfModel?.pdfFilePath != null) {
        screenState.currentState = LoadingState(screenState);
        screenState.refresh();
        pdfModel?.uploadPdf().then((value) {
          createOrderWithoutImage();
        });
      } else {
        createOrderWithoutImage();
      }
    } else {
      if (pdfModel?.pdfFilePath != null) {
        screenState.currentState = LoadingState(screenState);
        screenState.refresh();
        pdfModel?.uploadPdf().then((value) {
          createOrderWithImage();
        });
      } else {
        createOrderWithImage();
      }
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
