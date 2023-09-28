import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/app_config.dart';
import 'package:c4d/consts/c4d_stores_id.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_deep_links/service/location_parsing.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/widgets/geo_widget.dart';
import 'package:c4d/module_orders/ui/widgets/label_text.dart';
import 'package:c4d/module_profile/prefs_helper/profile_prefs_helper.dart';
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
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:latlong2/latlong.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewOrderStateBranchesLoaded extends States {
  List<BranchesModel> branches;
  final NewOrderScreenState screenState;

  NewOrderStateBranchesLoaded(this.branches, this.screenState)
      : super(screenState) {
    if (branches.isNotEmpty) {
      screenState.branch = branches[0].id;
      activeBranch =
          branches.firstWhere((element) => element.id == screenState.branch);
      screenState.request.origin = activeBranch?.location;
      screenState.refresh();
    }
  }

  final List<String> _paymentMethods = ['online', 'cash'];
  String _selectedPaymentMethod = 'online';

  // delivery date
  DateTime? orderDate;

  // init history
  DateTime dateTime = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BranchesModel? activeBranch;
  LatLng? destination;
  Uint8List? memoryBytes;
  String? imagePath;
  int orderType = 1;
  bool orderIsMain = false;
  PdfModel? pdfModel;
  String? distance;
  num? deliveryCost;

  @override
  Widget getUI(context) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();
    return IgnorePointer(
      ignoring: screenState.startParseLocation,
      child: StackedForm(
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
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        screenState.quickFillUp();
                      },
                      label: Text(S.current.quickFillUp),
                      icon: Icon(Icons.quickreply_rounded),
                    ),
                  ),
                  // branches
                  Column(
                    children: [
                      ListTile(
                        title: LabelText(S.of(context).branch),
                        subtitle: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Theme.of(context).colorScheme.background),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16),
                            child: DropdownSearch<BranchesModel>(
                                enabled: branches.isNotEmpty,
                                dropdownBuilder: (context, model) {
                                  return Text(
                                    model?.branchName ?? S.current.chooseBranch,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  );
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(0, 12, 0, 0))),
                                dropdownButtonProps: DropdownButtonProps(),
                                popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    menuProps: MenuProps(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                            hintText: S.current.chooseBranch,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25))))),
                                items: branches,
                                filterFn: (model, filter) {
                                  return model.branchName.contains(filter);
                                },
                                itemAsString: (model) => model.branchName,
                                onChanged: (v) {
                                  v as BranchesModel;
                                  screenState.branch = v.id;
                                  activeBranch = branches.firstWhere(
                                      (element) => element.id == v.id);
                                  screenState.request.origin =
                                      activeBranch?.location;
                                  screenState.refresh();
                                },
                                selectedItem: screenState.branch != null
                                    ? branches.firstWhere((element) =>
                                        element.id == screenState.branch)
                                    : null), // stores
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
                                    ClipboardData? data =
                                        await Clipboard.getData(
                                            Clipboard.kTextPlain);
                                    screenState.phoneNumberController.text =
                                        PhoneNumberDetection.getPhoneNumber(
                                            data?.text ?? '');
                                    screenState.refresh();
                                  },
                                  icon: Icon(
                                    Icons.paste_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                              ContactsHelper.getContactsDialog(context,
                                  (phone) {
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
                      readOnly: true,
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
                  // map preview .
                  IgnorePointer(
                    child: SizedBox(
                      height: 16,
                      child: Opacity(
                          opacity: 0,
                          child: WebViewWidget(
                              controller:
                                  webViewController ?? WebViewController())),
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
                                destination: screenState.customerLocation ??
                                    LatLng(0, 0),
                                origin: activeBranch?.location ?? LatLng(0, 0),
                                destance: (d, cost) {
                                  distance = d;
                                  deliveryCost = cost;
                                },
                                geoDistanceModel: screenState.geoDistanceModel,
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
                      validator: true,
                      validatorFunction: (value) {
                        var id = ProfilePreferencesHelper().getProfileId();

                        if (isC4D(id ?? -1)) {
                          return null;
                        }

                        if (screenState.payments == 'cash') {
                          if (value == null || value.isEmpty) {
                            return S.current.pleaseCompleteField;
                          } else {
                            int price = int.tryParse(value) ?? 0;

                            if (price <= 0)
                              return S.current.valueMustBeGreaterThanZero;
                          }
                        }

                        return null;
                      },
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
                                                          shape:
                                                              StadiumBorder()),
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
                                                          shape:
                                                              StadiumBorder()),
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
                                checked: memoryBytes != null,
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
                                            color: Theme.of(context)
                                                .disabledColor),
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
                                  checked: pdfModel?.pdfFilePath != null,
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
                                          Icons.attach_file_rounded,
                                          color:
                                              Theme.of(context).disabledColor,
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
                                    visible: pdfModel?.pdfFilePath != null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
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
                              orderDate = DateTime(
                                  dateTime.year,
                                  dateTime.month,
                                  dateTime.day,
                                  time.hour,
                                  time.minute);
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
                      visible: screenState.payments == 'card' &&
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
                  Visibility(
                    visible: AppConfig.packageType == 1 &&
                        screenState.payments == 'cash',
                    child: ListTile(
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
          }),
    );
  }

  Future<void> getClipBoardData() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    screenState.toController.text = data?.text ?? '';
    /// trim is used to make sure that the link will display in the filed what ever white spaces he have
    /// note that trim will apply in the begin an end of text so there is no actual data will lose in this possess
    screenState.toController.text = screenState.toController.text.trim();
    screenState.refresh();
    return;
  }

  // function to upload image then create order
  Future<void> createOrderWithImage() async {
    getIt<ImageUploadService>().uploadImage(imagePath).then((value) {
      if (value == null) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: S.current.errorUploadingImages)
            .show(screenState.context);
      }
      screenState.addNewOrder(CreateOrderRequest(
          pdf: pdfModel?.getPdfRequest(),
          orderIsMain: orderIsMain,
          distance: distance,
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
          orderCost: screenState.priceController.text.trim().isEmpty
              ? 0
              : num.tryParse(screenState.priceController.text.trim()),
          image: value,
          date: orderDate == null
              ? DateTime.now().toUtc().toIso8601String()
              : orderDate?.toUtc().toIso8601String(),
          payment: screenState.payments,
          deliveryCost: deliveryCost,
          costType: screenState.costType));
    });
  }

  // function create order without upload image
  Future<void> createOrderWithoutImage() async {
    screenState.addNewOrder(CreateOrderRequest(
        pdf: pdfModel?.getPdfRequest(),
        orderType: orderType,
        orderIsMain: orderIsMain,
        distance: distance,
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
        orderCost: screenState.priceController.text.trim().isEmpty
            ? 0
            : num.tryParse(screenState.priceController.text.trim()),
        image: null,
        date: orderDate == null
            ? DateTime.now().toUtc().toIso8601String()
            : orderDate?.toUtc().toIso8601String(),
        payment: screenState.payments,
        deliveryCost: deliveryCost,
        costType: screenState.costType));
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
