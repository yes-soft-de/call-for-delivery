// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:c4d/consts/country_code.dart';
import 'package:c4d/consts/secret_payments_keys.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/tap_payment_loader.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:c4d/utils/models/payment_gateway_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

void showTapPayment({
  required BuildContext context,
  required PaymentGatewayModel paymentModel,
  required Function(
    bool succeeded,
    String responseID,
    String transactionID,
    String sdkErrorMessage,
  ) callback,
}) {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  var tapPaymentInfo = getIt<PaymentHiveHelper>().getTapPaymentInfo();
  firstNameController.text = tapPaymentInfo.firstName;
  middleNameController.text = tapPaymentInfo.middleName;
  lastNameController.text = tapPaymentInfo.lastName;
  emailController.text = tapPaymentInfo.email;
  phoneNumberController.text = tapPaymentInfo.phoneNumber;

  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.5 +
            MediaQuery.of(context).viewInsets.bottom,
        child: _PaymentsPortal(
          paymentModel: paymentModel,
          callback: (succeeded, responseID, transactionID, sdkErrorMessage) {
            Navigator.pop(context);
            callback(succeeded, responseID, transactionID, sdkErrorMessage);
          },
          emailController: emailController,
          firstNameController: firstNameController,
          lastNameController: lastNameController,
          middleNameController: middleNameController,
          phoneNumberController: phoneNumberController,
        ),
      );
    },
  );
}

class _PaymentsPortal extends StatefulWidget {
  final PaymentGatewayModel paymentModel;
  final Function(bool succeeded, String responseID, String transactionID,
      String sdkErrorMessage) callback;

  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;

  _PaymentsPortal(
      {Key? key,
      required this.paymentModel,
      required this.callback,
      required this.firstNameController,
      required this.middleNameController,
      required this.lastNameController,
      required this.emailController,
      required this.phoneNumberController})
      : super(key: key);
  @override
  _PaymentsPortalState createState() => _PaymentsPortalState();
}

class _PaymentsPortalState extends State<_PaymentsPortal> {
  late Map<dynamic, dynamic> tapSDKResult;
  String responseID = '';
  String sdkStatus = '';
  late String transactionID;
  String? sdkErrorCode;
  String? sdkErrorMessage;
  String? sdkErrorDescription;
  AwesomeLoaderController loaderController = AwesomeLoaderController();

  late Color _buttonColor;

  @override
  void initState() {
    super.initState();
    _buttonColor = Color(0xff2ace00);
    transactionID = 'trans_${widget.paymentModel.amount}';
    configureSDK();
  }

  // configure SDK
  Future<void> configureSDK() async {
    // configure app
    configureApp();
    // sdk session configurations
    // setupSDKSession();
  }

  // configure app key and bundle-id (You must get those keys from tap)
  Future<void> configureApp() async {
    GoSellSdkFlutter.configureApp(
        bundleId:
            Platform.isAndroid ? 'de.yessoft.c4d_store' : 'de.yessoft.c4d',
        productionSecreteKey: Platform.isAndroid
            ? SecretPaymentsKeys.production
            : SecretPaymentsKeys.productionIOS,
        sandBoxsecretKey: Platform.isAndroid
            ? SecretPaymentsKeys.sandBox
            : SecretPaymentsKeys.sandBoxIOS,
        lang: getIt<LocalizationService>().getLanguage());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setupSDKSession() async {
    try {
      GoSellSdkFlutter.sessionConfigurations(
          trxMode: TransactionMode.PURCHASE,
          paymentMetaData: {},
          taxes: [],
          shippings: [],
          customer: Customer(
              customerId:
                  '', // customer id is important to retrieve cards saved for this customer
              email: widget.emailController.text,
              isdNumber: CountryCode.COUNTRY_CODE_KSA,
              number: widget.phoneNumberController.text,
              firstName: widget.firstNameController.text,
              middleName: widget.middleNameController.text,
              lastName: widget.lastNameController.text,
              metaData: null),
          transactionCurrency: 'sar',
          amount: widget.paymentModel.amount.toStringAsFixed(2),
          // Post URL
          postURL: 'https://tap.company',
          // Payment description
          paymentDescription: S.current.storeFee,
          // Payment Reference
          paymentReference:
              Reference(transaction: transactionID, gosellID: '97tap23'),
          // payment Descriptor
          paymentStatementDescriptor: 'C4d Client payments',
          // Save Card Switch
          isUserAllowedToSaveCard: false,
          // Enable/Disable 3DSecure
          isRequires3DSecure: true,
          // Receipt SMS/Email
          receipt: Receipt(true, true),
          // Authorize Action [Capture - Void]
          authorizeAction: AuthorizeAction(
              type: AuthorizeActionType.CAPTURE, timeInHours: 1),
          // Destinations
          destinations: null,
          // merchant id
          merchantID: '23718734',
          // Allowed cards
          allowedCadTypes: CardType.ALL,
          applePayMerchantID: 'merchant.c4d_store',
          allowsToSaveSameCardMoreThanOnce: false,
          // pass the card holder name to the SDK
          cardHolderName:
              '${widget.firstNameController.text} ${widget.middleNameController.text} ${widget.lastNameController.text}',
          // disable changing the card holder name by the user
          allowsToEditCardHolderName: false,
          // select payments you need to show [Default is all, and you can choose between WEB-CARD-APPLEPAY ]
          paymentType: PaymentType.ALL,
          // Transaction mode
          sdkMode: SDKMode.Sandbox,
          paymentItems: []);
    } on PlatformException {
      // platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      tapSDKResult = {};
    });
  }

  Future<void> startSDK() async {
    setState(() {
      loaderController.start();
    });

    tapSDKResult = await GoSellSdkFlutter.startPaymentSDK;
    loaderController.stopWhenFull();
    print('>>>> ${tapSDKResult['sdk_result']}');
    setState(() {
      switch (tapSDKResult['sdk_result']) {
        case 'SUCCESS':
          sdkStatus = 'SUCCESS';
          handleSDKResult();
          widget.callback(
              true, responseID, transactionID, sdkErrorMessage ?? '');
          break;
        case 'FAILED':
          sdkStatus = 'FAILED';
          handleSDKResult();
          widget.callback(
              false, responseID, transactionID, S.current.paymentFailed);
          getIt<Logger>().error(
              'Payment Portal',
              {
                'code': '$sdkErrorCode',
                'message': '$sdkErrorMessage',
                'description': '$sdkErrorDescription'
              }.toString(),
              StackTrace.current);
          break;
        case 'SDK_ERROR':
          print('sdk error............');
          print(tapSDKResult['sdk_error_code']);
          print(tapSDKResult['sdk_error_message']);
          print(tapSDKResult['sdk_error_description']);
          print('sdk error............');
          sdkErrorCode = tapSDKResult['sdk_error_code'].toString();
          sdkErrorMessage = tapSDKResult['sdk_error_message'];
          sdkErrorDescription = tapSDKResult['sdk_error_description'];
          widget.callback(
              false, responseID, transactionID, S.current.paymentFailed);
          getIt<Logger>().error(
              'Payment Portal',
              {
                'code': '$sdkErrorCode',
                'message': '$sdkErrorMessage',
                'description': '$sdkErrorDescription'
              }.toString(),
              StackTrace.current);
          break;

        case 'NOT_IMPLEMENTED':
          sdkStatus = 'NOT_IMPLEMENTED';
          break;
      }
    });
  }

  void handleSDKResult() {
    switch (tapSDKResult['trx_mode']) {
      case 'CHARGE':
        printSDKResult('Charge');
        break;
      case 'AUTHORIZE':
        printSDKResult('Authorize');
        break;

      case 'SAVE_CARD':
        printSDKResult('Save Card');
        break;

      case 'TOKENIZE':
        print('TOKENIZE token : ${tapSDKResult['token']}');
        print('TOKENIZE token_currency  : ${tapSDKResult['token_currency']}');
        print('TOKENIZE card_first_six : ${tapSDKResult['card_first_six']}');
        print('TOKENIZE card_last_four : ${tapSDKResult['card_last_four']}');
        print('TOKENIZE card_object  : ${tapSDKResult['card_object']}');
        print('TOKENIZE card_exp_month : ${tapSDKResult['card_exp_month']}');
        print('TOKENIZE card_exp_year    : ${tapSDKResult['card_exp_year']}');

        responseID = tapSDKResult['token'];
        break;
    }
  }

  void printSDKResult(String trx_mode) {
    print('$trx_mode status                : ${tapSDKResult['status']}');
    print('$trx_mode id               : ${tapSDKResult['charge_id']}');
    print('$trx_mode  description        : ${tapSDKResult['description']}');
    print('$trx_mode  message           : ${tapSDKResult['message']}');
    print('$trx_mode  card_first_six : ${tapSDKResult['card_first_six']}');
    print('$trx_mode  card_last_four   : ${tapSDKResult['card_last_four']}');
    print('$trx_mode  card_object         : ${tapSDKResult['card_object']}');
    print('$trx_mode  card_brand          : ${tapSDKResult['card_brand']}');
    print('$trx_mode  card_exp_month  : ${tapSDKResult['card_exp_month']}');
    print('$trx_mode  card_exp_year: ${tapSDKResult['card_exp_year']}');
    print('$trx_mode  acquirer_id  : ${tapSDKResult['acquirer_id']}');
    print(
        '$trx_mode  acquirer_response_code : ${tapSDKResult['acquirer_response_code']}');
    print(
        '$trx_mode  acquirer_response_message: ${tapSDKResult['acquirer_response_message']}');
    print('$trx_mode  source_id: ${tapSDKResult['source_id']}');
    print('$trx_mode  source_channel     : ${tapSDKResult['source_channel']}');
    print('$trx_mode  source_object      : ${tapSDKResult['source_object']}');
    print(
        '$trx_mode source_payment_type : ${tapSDKResult['source_payment_type']}');
    responseID = tapSDKResult['charge_id'] ?? '';
  }

  List<PaymentItem> payments = [];

  final GlobalKey<FormState> _details = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
          appBar: CustomC4dAppBar.appBar(context, title: S.current.paymentInfo,
              onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }),
          body: Form(
            key: _details,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.youHaveToFillTheFormFirst,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(height: 20),
                          PaymentFiled(
                            title: S.current.firstName,
                            controller: widget.firstNameController,
                          ),
                          PaymentFiled(
                            title: S.current.middleName,
                            controller: widget.middleNameController,
                          ),
                          PaymentFiled(
                            title: S.current.lastName,
                            controller: widget.lastNameController,
                          ),
                          PaymentFiled(
                            title: S.current.email,
                            controller: widget.emailController,
                            email: true,
                          ),
                          PaymentFiled(
                            title: S.current.phoneNumber,
                            controller: widget.phoneNumberController,
                            maxLength: 9,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: _buttonColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.all(
                                      Radius.circular(30))),
                            ),
                            onPressed: () async {
                              getIt<PaymentHiveHelper>()
                                  .saveTapPaymentInfo(TapPaymentInfo(
                                email: widget.emailController.text,
                                firstName: widget.firstNameController.text,
                                lastName: widget.lastNameController.text,
                                middleName: widget.middleNameController.text,
                                phoneNumber: widget.phoneNumberController.text,
                              ));
                              if (_details.currentState?.validate() == true &&
                                  (widget.emailController.text.isNotEmpty ||
                                      widget.phoneNumberController.text
                                          .isNotEmpty)) {
                                if (kIsWeb) {
                                  // var sdk = PaymentPortalWeb(
                                  //     amount: widget.model.order.orderCost
                                  //         .toStringAsFixed(2),
                                  //     email: emailController.text,
                                  //     firstName: firstNameController.text,
                                  //     items: payments,
                                  //     lastName: lastNameController.text,
                                  //     middleName: middleNameController.text,
                                  //     orderID:
                                  //         widget.model.order.id.toString(),
                                  //     phoneNumber: phoneNumberController.text,
                                  //     transID: transactionID,
                                  //     context: context);
                                  // sdk.startSdk();
                                } else {
                                  await setupSDKSession();
                                  await startSDK();
                                }
                              } else {
                                CustomFlushBarHelper.createError(
                                        title: S.current.warnning,
                                        message:
                                            S.current.pleaseCompleteTheForm)
                                    .show(context);
                              }
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: AwesomeLoader(
                                      outerColor: Colors.white,
                                      innerColor: Colors.white,
                                      strokeWidth: 3.0,
                                      controller: loaderController,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(S.current.paymentResume,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16.0)),
                                  const Spacer(),
                                  const Icon(
                                    Icons.lock_outline,
                                    color: Colors.white,
                                  ),
                                ]),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class PaymentFiled extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool isLast;
  final bool phone;
  final bool email;
  final int? maxLength;

  const PaymentFiled({
    super.key,
    required this.title,
    required this.controller,
    this.isLast = false,
    this.phone = false,
    this.email = false,
    this.maxLength,
  });

  @override
  State<PaymentFiled> createState() => _PaymentFiledState();
}

class _PaymentFiledState extends State<PaymentFiled> {
  AutovalidateMode mode = AutovalidateMode.disabled;
  bool expand = false;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      expand = widget.maxLength != null;
    }
    final node = FocusScope.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Color(0xFF767676),
                ),
          ),
          SizedBox(
            height: expand ? 70 : 50,
            child: TextFormField(
              autovalidateMode: mode,
              maxLength: widget.maxLength,
              validator: (v) {
                var err = validator(v);
                if (err != null) expand = true;
                return err;
              },
              controller: widget.controller,
              onEditingComplete: widget.isLast ? null : () => node.nextFocus(),
              onFieldSubmitted: widget.isLast ? (_) => node.unfocus() : null,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? validator(value) {
    if (mode == AutovalidateMode.disabled) {
      setState(() {
        mode = AutovalidateMode.onUserInteraction;
      });
    }
    if (value == null) {
      return S.current.pleaseCompleteField;
    } else if (value.isEmpty) {
      return S.of(context).pleaseCompleteField;
    } else if (widget.phone && value.length < 9) {
      return S.of(context).phoneNumbertooShort;
    } else if (widget.phone && value.length > (widget.maxLength ?? 9)) {
      return S.current.phoneNumberLong;
    } else if (widget.phone &&
        RegExp(r'[0-9]').allMatches(value).length != value.length) {
      return S.current.pleaseEnterValidPhoneNumber;
    } else {
      return null;
    }
  }

  TextInputType? get keyboardType {
    if (widget.phone) return TextInputType.phone;
    if (widget.email) return TextInputType.emailAddress;
    return null;
  }
}

class TapPaymentInfo {
  String firstName;
  String middleName;
  String lastName;
  String email;
  String phoneNumber;

  TapPaymentInfo({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  TapPaymentInfo.empty()
      : firstName = '',
        email = '',
        lastName = '',
        middleName = '',
        phoneNumber = '';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory TapPaymentInfo.fromMap(Map<String, dynamic> map) {
    return TapPaymentInfo(
      firstName: (map['firstName'] ?? '') as String,
      middleName: (map['middleName'] ?? '') as String,
      lastName: (map['lastName'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      phoneNumber: (map['phoneNumber'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TapPaymentInfo.fromJson(String source) =>
      TapPaymentInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}

@injectable
class PaymentHiveHelper {
  var box = Hive.box('Payment');

  void saveTapPaymentInfo(TapPaymentInfo info) {
    box.put('tapPaymentInfo', info.toJson());
  }

  TapPaymentInfo getTapPaymentInfo() {
    var v = box.get('tapPaymentInfo');
    if (v == null) return TapPaymentInfo.empty();
    return TapPaymentInfo.fromJson(v);
  }
}
