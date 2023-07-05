// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email`
  String get pleaseEnterYourEmail {
    return Intl.message(
      'Please Enter Your Email',
      name: 'pleaseEnterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `I have an account`
  String get iHaveAnAccount {
    return Intl.message(
      'I have an account',
      name: 'iHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Error Happened`
  String get errorHappened {
    return Intl.message(
      'Error Happened',
      name: 'errorHappened',
      desc: '',
      args: [],
    );
  }

  /// `Error Loading Data`
  String get errorLoadingData {
    return Intl.message(
      'Error Loading Data',
      name: 'errorLoadingData',
      desc: '',
      args: [],
    );
  }

  /// `Email Address is Required`
  String get emailAddressIsRequired {
    return Intl.message(
      'Email Address is Required',
      name: 'emailAddressIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Captain`
  String get captain {
    return Intl.message(
      'Captain',
      name: 'captain',
      desc: '',
      args: [],
    );
  }

  /// `Store Owner`
  String get storeOwner {
    return Intl.message(
      'Store Owner',
      name: 'storeOwner',
      desc: '',
      args: [],
    );
  }

  /// `Chat Room`
  String get chatRoom {
    return Intl.message(
      'Chat Room',
      name: 'chatRoom',
      desc: '',
      args: [],
    );
  }

  /// `Start Writing`
  String get startWriting {
    return Intl.message(
      'Start Writing',
      name: 'startWriting',
      desc: '',
      args: [],
    );
  }

  /// `Accept Order`
  String get acceptOrder {
    return Intl.message(
      'Accept Order',
      name: 'acceptOrder',
      desc: '',
      args: [],
    );
  }

  /// `I Arrived at the Store`
  String get iArrivedAtTheStore {
    return Intl.message(
      'I Arrived at the Store',
      name: 'iArrivedAtTheStore',
      desc: '',
      args: [],
    );
  }

  /// `I Got the Package`
  String get iGotThePackage {
    return Intl.message(
      'I Got the Package',
      name: 'iGotThePackage',
      desc: '',
      args: [],
    );
  }

  /// `I Got the Cash`
  String get iGotTheCash {
    return Intl.message(
      'I Got the Cash',
      name: 'iGotTheCash',
      desc: '',
      args: [],
    );
  }

  /// `I Finished Delivering`
  String get iFinishedDelivering {
    return Intl.message(
      'I Finished Delivering',
      name: 'iFinishedDelivering',
      desc: '',
      args: [],
    );
  }

  /// `Order is in undefined State`
  String get orderIsInUndefinedState {
    return Intl.message(
      'Order is in undefined State',
      name: 'orderIsInUndefinedState',
      desc: '',
      args: [],
    );
  }

  /// `Searching for Captain`
  String get searchingForCaptain {
    return Intl.message(
      'Searching for Captain',
      name: 'searchingForCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Captain is in the way`
  String get captainIsInTheWay {
    return Intl.message(
      'Captain is in the way',
      name: 'captainIsInTheWay',
      desc: '',
      args: [],
    );
  }

  /// `Captain is in store`
  String get captainIsInStore {
    return Intl.message(
      'Captain is in store',
      name: 'captainIsInStore',
      desc: '',
      args: [],
    );
  }

  /// `Captain is Delivering`
  String get captainIsDelivering {
    return Intl.message(
      'Captain is Delivering',
      name: 'captainIsDelivering',
      desc: '',
      args: [],
    );
  }

  /// `Captain got the cash`
  String get captainGotTheCash {
    return Intl.message(
      'Captain got the cash',
      name: 'captainGotTheCash',
      desc: '',
      args: [],
    );
  }

  /// `Order is done!`
  String get orderIsDone {
    return Intl.message(
      'Order is done!',
      name: 'orderIsDone',
      desc: '',
      args: [],
    );
  }

  /// `Please input phone number`
  String get pleaseInputPhoneNumber {
    return Intl.message(
      'Please input phone number',
      name: 'pleaseInputPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Code`
  String get confirmCode {
    return Intl.message(
      'Confirm Code',
      name: 'confirmCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Saudi Arabia`
  String get saudiArabia {
    return Intl.message(
      'Saudi Arabia',
      name: 'saudiArabia',
      desc: '',
      args: [],
    );
  }

  /// `Lebanon`
  String get lebanon {
    return Intl.message(
      'Lebanon',
      name: 'lebanon',
      desc: '',
      args: [],
    );
  }

  /// `Syria`
  String get syria {
    return Intl.message(
      'Syria',
      name: 'syria',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Send me code`
  String get sendMeCode {
    return Intl.message(
      'Send me code',
      name: 'sendMeCode',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signOut {
    return Intl.message(
      'Sign out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Order Created, Return to Orders`
  String get orderCreatedReturnToOrders {
    return Intl.message(
      'Order Created, Return to Orders',
      name: 'orderCreatedReturnToOrders',
      desc: '',
      args: [],
    );
  }

  /// `New Order`
  String get newOrder {
    return Intl.message(
      'New Order',
      name: 'newOrder',
      desc: '',
      args: [],
    );
  }

  /// `Renew Subscription`
  String get renewSubscription {
    return Intl.message(
      'Renew Subscription',
      name: 'renewSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Register Success, Setup my profile`
  String get registerSuccessSetupMyProfile {
    return Intl.message(
      'Register Success, Setup my profile',
      name: 'registerSuccessSetupMyProfile',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Size`
  String get chooseYourSize {
    return Intl.message(
      'Choose Your Size',
      name: 'chooseYourSize',
      desc: '',
      args: [],
    );
  }

  /// `1 - 20 Employee`
  String get smallLessThan20Employee {
    return Intl.message(
      '1 - 20 Employee',
      name: 'smallLessThan20Employee',
      desc: '',
      args: [],
    );
  }

  /// `21 - 100 Employees`
  String get mediumMoreThan20EmployeesLessThan100 {
    return Intl.message(
      '21 - 100 Employees',
      name: 'mediumMoreThan20EmployeesLessThan100',
      desc: '',
      args: [],
    );
  }

  /// `+100 Employees`
  String get largeMoreThan100Employees {
    return Intl.message(
      '+100 Employees',
      name: 'largeMoreThan100Employees',
      desc: '',
      args: [],
    );
  }

  /// `Open Chat Room`
  String get openChatRoom {
    return Intl.message(
      'Open Chat Room',
      name: 'openChatRoom',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Current Orders`
  String get currentOrders {
    return Intl.message(
      'Current Orders',
      name: 'currentOrders',
      desc: '',
      args: [],
    );
  }

  /// `Nearby Orders`
  String get nearbyOrders {
    return Intl.message(
      'Nearby Orders',
      name: 'nearbyOrders',
      desc: '',
      args: [],
    );
  }

  /// `Chat with Store Owner`
  String get chatWithStoreOwner {
    return Intl.message(
      'Chat with Store Owner',
      name: 'chatWithStoreOwner',
      desc: '',
      args: [],
    );
  }

  /// `Store Owner`
  String get whatsappWithStoreOwner {
    return Intl.message(
      'Store Owner',
      name: 'whatsappWithStoreOwner',
      desc: '',
      args: [],
    );
  }

  /// `Client`
  String get whatsappWithClient {
    return Intl.message(
      'Client',
      name: 'whatsappWithClient',
      desc: '',
      args: [],
    );
  }

  /// `Get Direction`
  String get getDirection {
    return Intl.message(
      'Get Direction',
      name: 'getDirection',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `I am`
  String get iAm {
    return Intl.message(
      'I am',
      name: 'iAm',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Preferred language`
  String get iSpeak {
    return Intl.message(
      'Preferred language',
      name: 'iSpeak',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `And I am`
  String get andIAm {
    return Intl.message(
      'And I am',
      name: 'andIAm',
      desc: '',
      args: [],
    );
  }

  /// `ME`
  String get me {
    return Intl.message(
      'ME',
      name: 'me',
      desc: '',
      args: [],
    );
  }

  /// `We need your image and your driver licence in order to sign up`
  String get weNeedYourImageAndYourDriverLicenceInOrder {
    return Intl.message(
      'We need your image and your driver licence in order to sign up',
      name: 'weNeedYourImageAndYourDriverLicenceInOrder',
      desc: '',
      args: [],
    );
  }

  /// `We need  your image in order to sign up`
  String get weNeedYourImageInOrderToSignUp {
    return Intl.message(
      'We need  your image in order to sign up',
      name: 'weNeedYourImageInOrderToSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Upload and submit`
  String get uploadAndSubmit {
    return Intl.message(
      'Upload and submit',
      name: 'uploadAndSubmit',
      desc: '',
      args: [],
    );
  }

  /// `This Might Take a while, please wait`
  String get thisMightTakeAWhilePleaseWait {
    return Intl.message(
      'This Might Take a while, please wait',
      name: 'thisMightTakeAWhilePleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Uploading Image, Please Wait`
  String get uploadingImagesPleaseWait {
    return Intl.message(
      'Uploading Image, Please Wait',
      name: 'uploadingImagesPleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Driver Licence`
  String get driverLicence {
    return Intl.message(
      'Driver Licence',
      name: 'driverLicence',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Uploading and Submitting`
  String get uploadingAndSubmitting {
    return Intl.message(
      'Uploading and Submitting',
      name: 'uploadingAndSubmitting',
      desc: '',
      args: [],
    );
  }

  /// `Uploading Images`
  String get uploadingImages {
    return Intl.message(
      'Uploading Images',
      name: 'uploadingImages',
      desc: '',
      args: [],
    );
  }

  /// `Submitting Profile`
  String get submittingProfile {
    return Intl.message(
      'Submitting Profile',
      name: 'submittingProfile',
      desc: '',
      args: [],
    );
  }

  /// `Error Uploading Images!!`
  String get errorUploadingImages {
    return Intl.message(
      'Error Uploading Images!!',
      name: 'errorUploadingImages',
      desc: '',
      args: [],
    );
  }

  /// `Account Created`
  String get accountCreated {
    return Intl.message(
      'Account Created',
      name: 'accountCreated',
      desc: '',
      args: [],
    );
  }

  /// `Move to Orders`
  String get moveToOrders {
    return Intl.message(
      'Move to Orders',
      name: 'moveToOrders',
      desc: '',
      args: [],
    );
  }

  /// `Contact Phone Number`
  String get contactPhoneNumber {
    return Intl.message(
      'Contact Phone Number',
      name: 'contactPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Pay Subscription`
  String get paySubscription {
    return Intl.message(
      'Pay Subscription',
      name: 'paySubscription',
      desc: '',
      args: [],
    );
  }

  /// `Earn Cash`
  String get earnCash {
    return Intl.message(
      'Earn Cash',
      name: 'earnCash',
      desc: '',
      args: [],
    );
  }

  /// `Deliver`
  String get deliver {
    return Intl.message(
      'Deliver',
      name: 'deliver',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Check Orders`
  String get checkOrders {
    return Intl.message(
      'Check Orders',
      name: 'checkOrders',
      desc: '',
      args: [],
    );
  }

  /// `Open the app`
  String get openTheApp {
    return Intl.message(
      'Open the app',
      name: 'openTheApp',
      desc: '',
      args: [],
    );
  }

  /// `Book a captain`
  String get bookACar {
    return Intl.message(
      'Book a captain',
      name: 'bookACar',
      desc: '',
      args: [],
    );
  }

  /// `We Deliver`
  String get weDeliver {
    return Intl.message(
      'We Deliver',
      name: 'weDeliver',
      desc: '',
      args: [],
    );
  }

  /// `Help me more`
  String get helpMeMore {
    return Intl.message(
      'Help me more',
      name: 'helpMeMore',
      desc: '',
      args: [],
    );
  }

  /// `Request Meeting`
  String get requestMeeting {
    return Intl.message(
      'Request Meeting',
      name: 'requestMeeting',
      desc: '',
      args: [],
    );
  }

  /// `To find out more, please leave your phone.\nand we will contact you personally`
  String get toFindOutMorePleaseLeaveYourPhonenandWeWill {
    return Intl.message(
      'To find out more, please leave your phone.\nand we will contact you personally',
      name: 'toFindOutMorePleaseLeaveYourPhonenandWeWill',
      desc: '',
      args: [],
    );
  }

  /// `We will contact you soon`
  String get weWillContactYouSoon {
    return Intl.message(
      'We will contact you soon',
      name: 'weWillContactYouSoon',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to mandob_moshtarayat`
  String get welcomeTomandob_moshtarayat {
    return Intl.message(
      'Welcome to mandob_moshtarayat',
      name: 'welcomeTomandob_moshtarayat',
      desc: '',
      args: [],
    );
  }

  /// `Init Data`
  String get initData {
    return Intl.message(
      'Init Data',
      name: 'initData',
      desc: '',
      args: [],
    );
  }

  /// `Save Location as Branch 01`
  String get saveLocationAsBranch01 {
    return Intl.message(
      'Save Location as Branch 01',
      name: 'saveLocationAsBranch01',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Orders Screen`
  String get welcomeToOrdersScreen {
    return Intl.message(
      'Welcome to Orders Screen',
      name: 'welcomeToOrdersScreen',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password is too short`
  String get passwordIsTooShort {
    return Intl.message(
      'Password is too short',
      name: 'passwordIsTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get nameIsRequired {
    return Intl.message(
      'Name is required',
      name: 'nameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your City`
  String get chooseYourCity {
    return Intl.message(
      'Choose Your City',
      name: 'chooseYourCity',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `From WhatsApp`
  String get fromWhatsapp {
    return Intl.message(
      'From WhatsApp',
      name: 'fromWhatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Default Branch`
  String get defaultBranch {
    return Intl.message(
      'Default Branch',
      name: 'defaultBranch',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `online`
  String get online {
    return Intl.message(
      'online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Mohammad`
  String get mohammad {
    return Intl.message(
      'Mohammad',
      name: 'mohammad',
      desc: '',
      args: [],
    );
  }

  /// `Deliver To`
  String get deliverTo {
    return Intl.message(
      'Deliver To',
      name: 'deliverTo',
      desc: '',
      args: [],
    );
  }

  /// `Captain`
  String get whatsappWithCaptain {
    return Intl.message(
      'Captain',
      name: 'whatsappWithCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Branch 01`
  String get branch01 {
    return Intl.message(
      'Branch 01',
      name: 'branch01',
      desc: '',
      args: [],
    );
  }

  /// `Create new order`
  String get createNewOrder {
    return Intl.message(
      'Create new order',
      name: 'createNewOrder',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Branch`
  String get branch {
    return Intl.message(
      'Branch',
      name: 'branch',
      desc: '',
      args: [],
    );
  }

  /// `Save Branches`
  String get saveBranches {
    return Intl.message(
      'Save Branches',
      name: 'saveBranches',
      desc: '',
      args: [],
    );
  }

  /// `Bank Name`
  String get bankName {
    return Intl.message(
      'Bank Name',
      name: 'bankName',
      desc: '',
      args: [],
    );
  }

  /// `Account Number`
  String get accountNumber {
    return Intl.message(
      'Account Number',
      name: 'accountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Error Loading Branches`
  String get errorLoadingBranches {
    return Intl.message(
      'Error Loading Branches',
      name: 'errorLoadingBranches',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Our Bank Name`
  String get ourBankName {
    return Intl.message(
      'Our Bank Name',
      name: 'ourBankName',
      desc: '',
      args: [],
    );
  }

  /// `Our Bank Account Number`
  String get ourBankAccountNumber {
    return Intl.message(
      'Our Bank Account Number',
      name: 'ourBankAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Package`
  String get package {
    return Intl.message(
      'Package',
      name: 'package',
      desc: '',
      args: [],
    );
  }

  /// `Order/Month`
  String get ordermonth {
    return Intl.message(
      'Order/Month',
      name: 'ordermonth',
      desc: '',
      args: [],
    );
  }

  /// `Captain`
  String get car {
    return Intl.message(
      'Captain',
      name: 'car',
      desc: '',
      args: [],
    );
  }

  /// `APPLY`
  String get apply {
    return Intl.message(
      'APPLY',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Recipient Phone Number`
  String get recipientPhoneNumber {
    return Intl.message(
      'Recipient Phone Number',
      name: 'recipientPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Pick a Language`
  String get pickALanguage {
    return Intl.message(
      'Pick a Language',
      name: 'pickALanguage',
      desc: '',
      args: [],
    );
  }

  /// `Pick a Job`
  String get pickAJob {
    return Intl.message(
      'Pick a Job',
      name: 'pickAJob',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Please Select a Branch`
  String get pleaseSelectABranch {
    return Intl.message(
      'Please Select a Branch',
      name: 'pleaseSelectABranch',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `Created`
  String get created {
    return Intl.message(
      'Created',
      name: 'created',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Captain Accepted Order`
  String get captainAcceptedOrder {
    return Intl.message(
      'Captain Accepted Order',
      name: 'captainAcceptedOrder',
      desc: '',
      args: [],
    );
  }

  /// `Captain in Store`
  String get captainInStore {
    return Intl.message(
      'Captain in Store',
      name: 'captainInStore',
      desc: '',
      args: [],
    );
  }

  /// `Captain Started Delivery`
  String get captainStartedDelivery {
    return Intl.message(
      'Captain Started Delivery',
      name: 'captainStartedDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Captain Got Cash`
  String get captainGotCash {
    return Intl.message(
      'Captain Got Cash',
      name: 'captainGotCash',
      desc: '',
      args: [],
    );
  }

  /// `Your monthly orders finished`
  String get orderIsFinished {
    return Intl.message(
      'Your monthly orders finished',
      name: 'orderIsFinished',
      desc: '',
      args: [],
    );
  }

  /// `Order is created`
  String get orderIsCreated {
    return Intl.message(
      'Order is created',
      name: 'orderIsCreated',
      desc: '',
      args: [],
    );
  }

  /// `Activity Log`
  String get activityLog {
    return Intl.message(
      'Activity Log',
      name: 'activityLog',
      desc: '',
      args: [],
    );
  }

  /// `Save Success`
  String get saveSuccess {
    return Intl.message(
      'Save Success',
      name: 'saveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Reason of the report`
  String get reasonOfTheReport {
    return Intl.message(
      'Reason of the report',
      name: 'reasonOfTheReport',
      desc: '',
      args: [],
    );
  }

  /// `Create new Report`
  String get createNewReport {
    return Intl.message(
      'Create new Report',
      name: 'createNewReport',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Field can't be empty`
  String get pleaseCompleteTheForm {
    return Intl.message(
      'Field can\'t be empty',
      name: 'pleaseCompleteTheForm',
      desc: '',
      args: [],
    );
  }

  /// `Report sent`
  String get reportSent {
    return Intl.message(
      'Report sent',
      name: 'reportSent',
      desc: '',
      args: [],
    );
  }

  /// `Reason is Required`
  String get reasonIsRequired {
    return Intl.message(
      'Reason is Required',
      name: 'reasonIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please Provide us with the Client Name`
  String get pleaseProvideUsWithTheClientName {
    return Intl.message(
      'Please Provide us with the Client Name',
      name: 'pleaseProvideUsWithTheClientName',
      desc: '',
      args: [],
    );
  }

  /// `Please Provide us the client phone number`
  String get pleaseProvideUsTheClientPhoneNumber {
    return Intl.message(
      'Please Provide us the client phone number',
      name: 'pleaseProvideUsTheClientPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Store Name`
  String get storeName {
    return Intl.message(
      'Store Name',
      name: 'storeName',
      desc: '',
      args: [],
    );
  }

  /// `Store Phone`
  String get storePhone {
    return Intl.message(
      'Store Phone',
      name: 'storePhone',
      desc: '',
      args: [],
    );
  }

  /// `Phone is required`
  String get phoneIsRequired {
    return Intl.message(
      'Phone is required',
      name: 'phoneIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `New name`
  String get newName {
    return Intl.message(
      'New name',
      name: 'newName',
      desc: '',
      args: [],
    );
  }

  /// `Our Packages`
  String get ourPackages {
    return Intl.message(
      'Our Packages',
      name: 'ourPackages',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Please Provide the distance`
  String get pleaseProvideTheDistance {
    return Intl.message(
      'Please Provide the distance',
      name: 'pleaseProvideTheDistance',
      desc: '',
      args: [],
    );
  }

  /// `Finish Order, Provide distance in KM`
  String get finishOrderProvideDistanceInKm {
    return Intl.message(
      'Finish Order, Provide distance in KM',
      name: 'finishOrderProvideDistanceInKm',
      desc: '',
      args: [],
    );
  }

  /// `My Status`
  String get myStatus {
    return Intl.message(
      'My Status',
      name: 'myStatus',
      desc: '',
      args: [],
    );
  }

  /// `Direct Support`
  String get directSupport {
    return Intl.message(
      'Direct Support',
      name: 'directSupport',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message(
      'My Orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Please Download mandob_moshtarayat`
  String get pleaseDownloadmandob_moshtarayat {
    return Intl.message(
      'Please Download mandob_moshtarayat',
      name: 'pleaseDownloadmandob_moshtarayat',
      desc: '',
      args: [],
    );
  }

  /// `My Plan`
  String get myPlan {
    return Intl.message(
      'My Plan',
      name: 'myPlan',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account Number`
  String get bankAccountNumber {
    return Intl.message(
      'Bank Account Number',
      name: 'bankAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `STC Pay Code`
  String get stcPayCode {
    return Intl.message(
      'STC Pay Code',
      name: 'stcPayCode',
      desc: '',
      args: [],
    );
  }

  /// `Current Balance`
  String get currentBalance {
    return Intl.message(
      'Current Balance',
      name: 'currentBalance',
      desc: '',
      args: [],
    );
  }

  /// `Next Payment Date:`
  String get nextPaymentDate {
    return Intl.message(
      'Next Payment Date:',
      name: 'nextPaymentDate',
      desc: '',
      args: [],
    );
  }

  /// `Saudi Riyal`
  String get saudiRiyal {
    return Intl.message(
      'Saudi Riyal',
      name: 'saudiRiyal',
      desc: '',
      args: [],
    );
  }

  /// `Active Plan`
  String get activePlan {
    return Intl.message(
      'Active Plan',
      name: 'activePlan',
      desc: '',
      args: [],
    );
  }

  /// `Active Captains`
  String get activeCars {
    return Intl.message(
      'Active Captains',
      name: 'activeCars',
      desc: '',
      args: [],
    );
  }

  /// `Orders / Month`
  String get ordersMonth {
    return Intl.message(
      'Orders / Month',
      name: 'ordersMonth',
      desc: '',
      args: [],
    );
  }

  /// `Payment History`
  String get paymentHistory {
    return Intl.message(
      'Payment History',
      name: 'paymentHistory',
      desc: '',
      args: [],
    );
  }

  /// `Completed Orders`
  String get completedOrders {
    return Intl.message(
      'Completed Orders',
      name: 'completedOrders',
      desc: '',
      args: [],
    );
  }

  /// `Latest Updates`
  String get latestUpdates {
    return Intl.message(
      'Latest Updates',
      name: 'latestUpdates',
      desc: '',
      args: [],
    );
  }

  /// `My Balance`
  String get myBalance {
    return Intl.message(
      'My Balance',
      name: 'myBalance',
      desc: '',
      args: [],
    );
  }

  /// `No Image , Please provide one`
  String get noImage {
    return Intl.message(
      'No Image , Please provide one',
      name: 'noImage',
      desc: '',
      args: [],
    );
  }

  /// `How we work`
  String get howWeWork {
    return Intl.message(
      'How we work',
      name: 'howWeWork',
      desc: '',
      args: [],
    );
  }

  /// `Took`
  String get took {
    return Intl.message(
      'Took',
      name: 'took',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get minutes {
    return Intl.message(
      'minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get minute {
    return Intl.message(
      'minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `I Agree to the Terms os service.`
  String get iAgreeToTheTermsOsService {
    return Intl.message(
      'I Agree to the Terms os service.',
      name: 'iAgreeToTheTermsOsService',
      desc: '',
      args: [],
    );
  }

  /// `I Agree To The Terms Of Service & privacy policy`
  String get iAgreeToTheTermsOfServicePrivacyPolicy {
    return Intl.message(
      'I Agree To The Terms Of Service & privacy policy',
      name: 'iAgreeToTheTermsOfServicePrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Business Name`
  String get businessName {
    return Intl.message(
      'Business Name',
      name: 'businessName',
      desc: '',
      args: [],
    );
  }

  /// `The number of Captain unknown`
  String get unknownNumberOfCar {
    return Intl.message(
      'The number of Captain unknown',
      name: 'unknownNumberOfCar',
      desc: '',
      args: [],
    );
  }

  /// `Recipient Name`
  String get recipientName {
    return Intl.message(
      'Recipient Name',
      name: 'recipientName',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Go`
  String get go {
    return Intl.message(
      'Go',
      name: 'go',
      desc: '',
      args: [],
    );
  }

  /// `Error logging in, firebase account not found`
  String get errorLoggingInFirebaseAccountNotFound {
    return Intl.message(
      'Error logging in, firebase account not found',
      name: 'errorLoggingInFirebaseAccountNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Location of customer`
  String get locationOfCustomer {
    return Intl.message(
      'Location of customer',
      name: 'locationOfCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about deleting this order , please confirm`
  String get sureForDelete {
    return Intl.message(
      'Are you sure about deleting this order , please confirm',
      name: 'sureForDelete',
      desc: '',
      args: [],
    );
  }

  /// `the order has been deleted successfully`
  String get deleteSuccess {
    return Intl.message(
      'the order has been deleted successfully',
      name: 'deleteSuccess',
      desc: '',
      args: [],
    );
  }

  /// `distance in KM`
  String get ProvideDistanceInKm {
    return Intl.message(
      'distance in KM',
      name: 'ProvideDistanceInKm',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription not verified yet`
  String get notVerified {
    return Intl.message(
      'Your subscription not verified yet',
      name: 'notVerified',
      desc: '',
      args: [],
    );
  }

  /// `Subscription options`
  String get renewPlan {
    return Intl.message(
      'Subscription options',
      name: 'renewPlan',
      desc: '',
      args: [],
    );
  }

  /// `Renew old package`
  String get renewOldPlan {
    return Intl.message(
      'Renew old package',
      name: 'renewOldPlan',
      desc: '',
      args: [],
    );
  }

  /// `Subscription with new package`
  String get renewNewPlan {
    return Intl.message(
      'Subscription with new package',
      name: 'renewNewPlan',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription has been renewed`
  String get successRenew {
    return Intl.message(
      'Your subscription has been renewed',
      name: 'successRenew',
      desc: '',
      args: [],
    );
  }

  /// `Important Note`
  String get warnning {
    return Intl.message(
      'Important Note',
      name: 'warnning',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription not activate yet please wait`
  String get SubscriptionInactive {
    return Intl.message(
      'Your subscription not activate yet please wait',
      name: 'SubscriptionInactive',
      desc: '',
      args: [],
    );
  }

  /// `You reach your limit of orders you can renew your subscription`
  String get outOforders {
    return Intl.message(
      'You reach your limit of orders you can renew your subscription',
      name: 'outOforders',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription is out of date please renew your subscription`
  String get finishedDate {
    return Intl.message(
      'Your subscription is out of date please renew your subscription',
      name: 'finishedDate',
      desc: '',
      args: [],
    );
  }

  /// `Your request not accepted from administration you can contact us to get info`
  String get unaccept {
    return Intl.message(
      'Your request not accepted from administration you can contact us to get info',
      name: 'unaccept',
      desc: '',
      args: [],
    );
  }

  /// `There is no captain available please wait your ongoing orders to finish`
  String get outOfCars {
    return Intl.message(
      'There is no captain available please wait your ongoing orders to finish',
      name: 'outOfCars',
      desc: '',
      args: [],
    );
  }

  /// `You dont have a subscription yet`
  String get notSubscription {
    return Intl.message(
      'You dont have a subscription yet',
      name: 'notSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message(
      'Subscribe',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Your account not activated yet please wait`
  String get captainNotActive {
    return Intl.message(
      'Your account not activated yet please wait',
      name: 'captainNotActive',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get day {
    return Intl.message(
      'day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message(
      'days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `second`
  String get second {
    return Intl.message(
      'second',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get seconds {
    return Intl.message(
      'seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `hour`
  String get hour {
    return Intl.message(
      'hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Your renew has been failed please try again`
  String get failureRenew {
    return Intl.message(
      'Your renew has been failed please try again',
      name: 'failureRenew',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get store {
    return Intl.message(
      'Store',
      name: 'store',
      desc: '',
      args: [],
    );
  }

  /// `Update Branches`
  String get updateBranches {
    return Intl.message(
      'Update Branches',
      name: 'updateBranches',
      desc: '',
      args: [],
    );
  }

  /// `Update Branch`
  String get updateBranch {
    return Intl.message(
      'Update Branch',
      name: 'updateBranch',
      desc: '',
      args: [],
    );
  }

  /// `Save Branch`
  String get saveBranch {
    return Intl.message(
      'Save Branch',
      name: 'saveBranch',
      desc: '',
      args: [],
    );
  }

  /// `Edit Branch Name`
  String get editBranchName {
    return Intl.message(
      'Edit Branch Name',
      name: 'editBranchName',
      desc: '',
      args: [],
    );
  }

  /// `Branch has been updated successfully`
  String get updateBranchSuccess {
    return Intl.message(
      'Branch has been updated successfully',
      name: 'updateBranchSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Sorry your request for update branch faild please try again`
  String get updateBranchFailure {
    return Intl.message(
      'Sorry your request for update branch faild please try again',
      name: 'updateBranchFailure',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is too short`
  String get phoneNumbertooShort {
    return Intl.message(
      'Phone number is too short',
      name: 'phoneNumbertooShort',
      desc: '',
      args: [],
    );
  }

  /// `Add Branch`
  String get addBranch {
    return Intl.message(
      'Add Branch',
      name: 'addBranch',
      desc: '',
      args: [],
    );
  }

  /// `Branch has been added successfully`
  String get addBranchSuccess {
    return Intl.message(
      'Branch has been added successfully',
      name: 'addBranchSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Sorry your request for add branch faild please try again`
  String get addBranchFailure {
    return Intl.message(
      'Sorry your request for add branch faild please try again',
      name: 'addBranchFailure',
      desc: '',
      args: [],
    );
  }

  /// `Our Service`
  String get ourService {
    return Intl.message(
      'Our Service',
      name: 'ourService',
      desc: '',
      args: [],
    );
  }

  /// `Most Sold Product`
  String get mostSoldProduct {
    return Intl.message(
      'Most Sold Product',
      name: 'mostSoldProduct',
      desc: '',
      args: [],
    );
  }

  /// `Best Store`
  String get bestStore {
    return Intl.message(
      'Best Store',
      name: 'bestStore',
      desc: '',
      args: [],
    );
  }

  /// `Nearby Store`
  String get nearbyStore {
    return Intl.message(
      'Nearby Store',
      name: 'nearbyStore',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get showAll {
    return Intl.message(
      'Show All',
      name: 'showAll',
      desc: '',
      args: [],
    );
  }

  /// `Deliver on me`
  String get deliverForMe {
    return Intl.message(
      'Deliver on me',
      name: 'deliverForMe',
      desc: '',
      args: [],
    );
  }

  /// `External Order`
  String get externalOrder {
    return Intl.message(
      'External Order',
      name: 'externalOrder',
      desc: '',
      args: [],
    );
  }

  /// `Best Stores`
  String get BestStores {
    return Intl.message(
      'Best Stores',
      name: 'BestStores',
      desc: '',
      args: [],
    );
  }

  /// `Search for store , product`
  String get searchFor {
    return Intl.message(
      'Search for store , product',
      name: 'searchFor',
      desc: '',
      args: [],
    );
  }

  /// `views`
  String get views {
    return Intl.message(
      'views',
      name: 'views',
      desc: '',
      args: [],
    );
  }

  /// `highest rate`
  String get sortByRate {
    return Intl.message(
      'highest rate',
      name: 'sortByRate',
      desc: '',
      args: [],
    );
  }

  /// `Order Number`
  String get orderNumber {
    return Intl.message(
      'Order Number',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `order date`
  String get orderDate {
    return Intl.message(
      'order date',
      name: 'orderDate',
      desc: '',
      args: [],
    );
  }

  /// `order status`
  String get orderStatus {
    return Intl.message(
      'order status',
      name: 'orderStatus',
      desc: '',
      args: [],
    );
  }

  /// `cost`
  String get cost {
    return Intl.message(
      'cost',
      name: 'cost',
      desc: '',
      args: [],
    );
  }

  /// `Highest Rate`
  String get highestRate {
    return Intl.message(
      'Highest Rate',
      name: 'highestRate',
      desc: '',
      args: [],
    );
  }

  /// `By Earlier`
  String get sortByEarlier {
    return Intl.message(
      'By Earlier',
      name: 'sortByEarlier',
      desc: '',
      args: [],
    );
  }

  /// `search for order by order number`
  String get searchForOrder {
    return Intl.message(
      'search for order by order number',
      name: 'searchForOrder',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Personal Data`
  String get personalData {
    return Intl.message(
      'Personal Data',
      name: 'personalData',
      desc: '',
      args: [],
    );
  }

  /// `Orders Log`
  String get orderLog {
    return Intl.message(
      'Orders Log',
      name: 'orderLog',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Social Media`
  String get socialMedia {
    return Intl.message(
      'Social Media',
      name: 'socialMedia',
      desc: '',
      args: [],
    );
  }

  /// `Search for a notification`
  String get searchForNotifications {
    return Intl.message(
      'Search for a notification',
      name: 'searchForNotifications',
      desc: '',
      args: [],
    );
  }

  /// `category`
  String get category {
    return Intl.message(
      'category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `product`
  String get product {
    return Intl.message(
      'product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `There is problem with your connection , please try again`
  String get networkError {
    return Intl.message(
      'There is problem with your connection , please try again',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Search for`
  String get searchF {
    return Intl.message(
      'Search for',
      name: 'searchF',
      desc: '',
      args: [],
    );
  }

  /// `Most wanted`
  String get mostWanted {
    return Intl.message(
      'Most wanted',
      name: 'mostWanted',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Birth Date`
  String get birthDate {
    return Intl.message(
      'Birth Date',
      name: 'birthDate',
      desc: '',
      args: [],
    );
  }

  /// `e.g yazan`
  String get nameHint {
    return Intl.message(
      'e.g yazan',
      name: 'nameHint',
      desc: '',
      args: [],
    );
  }

  /// `choose your birth data`
  String get birthDateHint {
    return Intl.message(
      'choose your birth data',
      name: 'birthDateHint',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Update Data`
  String get updateYourData {
    return Intl.message(
      'Update Data',
      name: 'updateYourData',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get community {
    return Intl.message(
      'Community',
      name: 'community',
      desc: '',
      args: [],
    );
  }

  /// `waiting`
  String get waiting {
    return Intl.message(
      'waiting',
      name: 'waiting',
      desc: '',
      args: [],
    );
  }

  /// `Order List`
  String get orderList {
    return Intl.message(
      'Order List',
      name: 'orderList',
      desc: '',
      args: [],
    );
  }

  /// `Bill`
  String get bill {
    return Intl.message(
      'Bill',
      name: 'bill',
      desc: '',
      args: [],
    );
  }

  /// `order price`
  String get orderPrice {
    return Intl.message(
      'order price',
      name: 'orderPrice',
      desc: '',
      args: [],
    );
  }

  /// `total`
  String get sum {
    return Intl.message(
      'total',
      name: 'sum',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get sar {
    return Intl.message(
      'SAR',
      name: 'sar',
      desc: '',
      args: [],
    );
  }

  /// `deliver price`
  String get deliverPrice {
    return Intl.message(
      'deliver price',
      name: 'deliverPrice',
      desc: '',
      args: [],
    );
  }

  /// `waiting for a captain to accept this order`
  String get waitingDescription {
    return Intl.message(
      'waiting for a captain to accept this order',
      name: 'waitingDescription',
      desc: '',
      args: [],
    );
  }

  /// `captain packing your order`
  String get captainInStoreDescription {
    return Intl.message(
      'captain packing your order',
      name: 'captainInStoreDescription',
      desc: '',
      args: [],
    );
  }

  /// `captain on his way to you`
  String get deliveringDescription {
    return Intl.message(
      'captain on his way to you',
      name: 'deliveringDescription',
      desc: '',
      args: [],
    );
  }

  /// `captain headed to store`
  String get captainAcceptOrderDescription {
    return Intl.message(
      'captain headed to store',
      name: 'captainAcceptOrderDescription',
      desc: '',
      args: [],
    );
  }

  /// `your order has delivered`
  String get orderDeliveredDescription {
    return Intl.message(
      'your order has delivered',
      name: 'orderDeliveredDescription',
      desc: '',
      args: [],
    );
  }

  /// `You can know your order status in this interface`
  String get orderStatusDescription {
    return Intl.message(
      'You can know your order status in this interface',
      name: 'orderStatusDescription',
      desc: '',
      args: [],
    );
  }

  /// `Destination Address`
  String get destinationAddress {
    return Intl.message(
      'Destination Address',
      name: 'destinationAddress',
      desc: '',
      args: [],
    );
  }

  /// `Receipt point`
  String get myAddress {
    return Intl.message(
      'Receipt point',
      name: 'myAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please place your order details here`
  String get orderDetailHint {
    return Intl.message(
      'Please place your order details here',
      name: 'orderDetailHint',
      desc: '',
      args: [],
    );
  }

  /// `Please place your destination address`
  String get destinationAddressHint {
    return Intl.message(
      'Please place your destination address',
      name: 'destinationAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Please place your address`
  String get myAddressHint {
    return Intl.message(
      'Please place your address',
      name: 'myAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get card {
    return Intl.message(
      'Card',
      name: 'card',
      desc: '',
      args: [],
    );
  }

  /// `Please update your current location if you want to`
  String get chooseAddressNote {
    return Intl.message(
      'Please update your current location if you want to',
      name: 'chooseAddressNote',
      desc: '',
      args: [],
    );
  }

  /// `Order Time`
  String get orderTime {
    return Intl.message(
      'Order Time',
      name: 'orderTime',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get paymentMethodHint {
    return Intl.message(
      'Choose',
      name: 'paymentMethodHint',
      desc: '',
      args: [],
    );
  }

  /// `Data fetched succesfuly`
  String get statusCodeOk {
    return Intl.message(
      'Data fetched succesfuly',
      name: 'statusCodeOk',
      desc: '',
      args: [],
    );
  }

  /// `The request has succeeded and a new resource has been created as a result`
  String get statusCodeCreated {
    return Intl.message(
      'The request has succeeded and a new resource has been created as a result',
      name: 'statusCodeCreated',
      desc: '',
      args: [],
    );
  }

  /// `The server could not understand the request due to invalid syntax`
  String get statusCodeBadRequest {
    return Intl.message(
      'The server could not understand the request due to invalid syntax',
      name: 'statusCodeBadRequest',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized`
  String get statusCodeUnauthorized {
    return Intl.message(
      'Unauthorized',
      name: 'statusCodeUnauthorized',
      desc: '',
      args: [],
    );
  }

  /// `Data not found`
  String get StatusCodeNotFound {
    return Intl.message(
      'Data not found',
      name: 'StatusCodeNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get note {
    return Intl.message(
      'Notes',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Order created successfully`
  String get successCreateOrder {
    return Intl.message(
      'Order created successfully',
      name: 'successCreateOrder',
      desc: '',
      args: [],
    );
  }

  /// `Please choose payment method`
  String get pleaseProvidePaymentMethode {
    return Intl.message(
      'Please choose payment method',
      name: 'pleaseProvidePaymentMethode',
      desc: '',
      args: [],
    );
  }

  /// `Please provide your address on our map`
  String get pleaseProvideYourAddress {
    return Intl.message(
      'Please provide your address on our map',
      name: 'pleaseProvideYourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty please choose items to add`
  String get yourCartEmpty {
    return Intl.message(
      'Your cart is empty please choose items to add',
      name: 'yourCartEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please place your order notes`
  String get noteOfOrder {
    return Intl.message(
      'Please place your order notes',
      name: 'noteOfOrder',
      desc: '',
      args: [],
    );
  }

  /// `choose location`
  String get chooseLocation {
    return Intl.message(
      'choose location',
      name: 'chooseLocation',
      desc: '',
      args: [],
    );
  }

  /// `Choose Receipt Location`
  String get chooseReceiptPoint {
    return Intl.message(
      'Choose Receipt Location',
      name: 'chooseReceiptPoint',
      desc: '',
      args: [],
    );
  }

  /// `Choose Destination Location`
  String get chooseDestinationPoint {
    return Intl.message(
      'Choose Destination Location',
      name: 'chooseDestinationPoint',
      desc: '',
      args: [],
    );
  }

  /// `Finish Order`
  String get finishedOrdering {
    return Intl.message(
      'Finish Order',
      name: 'finishedOrdering',
      desc: '',
      args: [],
    );
  }

  /// `Private Order`
  String get privateOrder {
    return Intl.message(
      'Private Order',
      name: 'privateOrder',
      desc: '',
      args: [],
    );
  }

  /// `Store Products`
  String get storeProducts {
    return Intl.message(
      'Store Products',
      name: 'storeProducts',
      desc: '',
      args: [],
    );
  }

  /// `Order Type`
  String get orderType {
    return Intl.message(
      'Order Type',
      name: 'orderType',
      desc: '',
      args: [],
    );
  }

  /// `Order number not found!!`
  String get orderNumberNotFound {
    return Intl.message(
      'Order number not found!!',
      name: 'orderNumberNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Can not remove it, Exceeded time allowed`
  String get exceededAllowedTime {
    return Intl.message(
      'Can not remove it, Exceeded time allowed',
      name: 'exceededAllowedTime',
      desc: '',
      args: [],
    );
  }

  /// `Can not remove it, The captain received the order`
  String get notAllowedCaptainReceived {
    return Intl.message(
      'Can not remove it, The captain received the order',
      name: 'notAllowedCaptainReceived',
      desc: '',
      args: [],
    );
  }

  /// `Orders Details`
  String get updateOrders {
    return Intl.message(
      'Orders Details',
      name: 'updateOrders',
      desc: '',
      args: [],
    );
  }

  /// `You can update your order item from this interface`
  String get updateOrderNote {
    return Intl.message(
      'You can update your order item from this interface',
      name: 'updateOrderNote',
      desc: '',
      args: [],
    );
  }

  /// `WELCOME TO TWASLNA APP`
  String get welcomeToOurApp {
    return Intl.message(
      'WELCOME TO TWASLNA APP',
      name: 'welcomeToOurApp',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been updated`
  String get updateOrderSuccess {
    return Intl.message(
      'Your order has been updated',
      name: 'updateOrderSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `username or phone number`
  String get registerHint {
    return Intl.message(
      'username or phone number',
      name: 'registerHint',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been registered successfully`
  String get registerSuccess {
    return Intl.message(
      'Your account has been registered successfully',
      name: 'registerSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been logged successfully`
  String get loginSuccess {
    return Intl.message(
      'Your account has been logged successfully',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `There is no data to show you yet`
  String get homeDataEmpty {
    return Intl.message(
      'There is no data to show you yet',
      name: 'homeDataEmpty',
      desc: '',
      args: [],
    );
  }

  /// `refresh`
  String get refresh {
    return Intl.message(
      'refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `The next problems occurred`
  String get errOc {
    return Intl.message(
      'The next problems occurred',
      name: 'errOc',
      desc: '',
      args: [],
    );
  }

  /// `Please login to resuming order sending`
  String get pleaseLoginToMakeOrder {
    return Intl.message(
      'Please login to resuming order sending',
      name: 'pleaseLoginToMakeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Please fill the field`
  String get pleaseCompleteField {
    return Intl.message(
      'Please fill the field',
      name: 'pleaseCompleteField',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error`
  String get internalServerError {
    return Intl.message(
      'Internal server error',
      name: 'internalServerError',
      desc: '',
      args: [],
    );
  }

  /// `This Error happened`
  String get thisErrorHappened {
    return Intl.message(
      'This Error happened',
      name: 'thisErrorHappened',
      desc: '',
      args: [],
    );
  }

  /// `Please login to continue`
  String get pleaseLoginToContinue {
    return Intl.message(
      'Please login to continue',
      name: 'pleaseLoginToContinue',
      desc: '',
      args: [],
    );
  }

  /// `You can't edit, captain in the store.`
  String get notAllowedCaptainInStore {
    return Intl.message(
      'You can\'t edit, captain in the store.',
      name: 'notAllowedCaptainInStore',
      desc: '',
      args: [],
    );
  }

  /// `Wrong username or password`
  String get invalidCredentials {
    return Intl.message(
      'Wrong username or password',
      name: 'invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Error with Decoding Data`
  String get dataDecodeError {
    return Intl.message(
      'Error with Decoding Data',
      name: 'dataDecodeError',
      desc: '',
      args: [],
    );
  }

  /// `Add Products`
  String get addProducts {
    return Intl.message(
      'Add Products',
      name: 'addProducts',
      desc: '',
      args: [],
    );
  }

  /// `There is no profile data available`
  String get profileDataEmpty {
    return Intl.message(
      'There is no profile data available',
      name: 'profileDataEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Profile Data Fetched Successfully`
  String get profileFetchedSuccessfully {
    return Intl.message(
      'Profile Data Fetched Successfully',
      name: 'profileFetchedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Upload profile was a success`
  String get uploadProfileSuccess {
    return Intl.message(
      'Upload profile was a success',
      name: 'uploadProfileSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Upload image was a success`
  String get uploadImageSuccess {
    return Intl.message(
      'Upload image was a success',
      name: 'uploadImageSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `error download image`
  String get errorDownloadingImage {
    return Intl.message(
      'error download image',
      name: 'errorDownloadingImage',
      desc: '',
      args: [],
    );
  }

  /// `New Messages`
  String get lastSeenMessage {
    return Intl.message(
      'New Messages',
      name: 'lastSeenMessage',
      desc: '',
      args: [],
    );
  }

  /// `Be the first one to send message`
  String get firstSendMessage {
    return Intl.message(
      'Be the first one to send message',
      name: 'firstSendMessage',
      desc: '',
      args: [],
    );
  }

  /// `Chat With Captain`
  String get chatWithCaptain {
    return Intl.message(
      'Chat With Captain',
      name: 'chatWithCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `The order has been cancelled by the client`
  String get cancelledHint {
    return Intl.message(
      'The order has been cancelled by the client',
      name: 'cancelledHint',
      desc: '',
      args: [],
    );
  }

  /// `Completion Time`
  String get completeTime {
    return Intl.message(
      'Completion Time',
      name: 'completeTime',
      desc: '',
      args: [],
    );
  }

  /// `The total cost without delivery cost`
  String get totalBillCostHint {
    return Intl.message(
      'The total cost without delivery cost',
      name: 'totalBillCostHint',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Image`
  String get invoiceImage {
    return Intl.message(
      'Invoice Image',
      name: 'invoiceImage',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Cost`
  String get invoiceCost {
    return Intl.message(
      'Invoice Cost',
      name: 'invoiceCost',
      desc: '',
      args: [],
    );
  }

  /// `This account already exist`
  String get accountAlreadyExist {
    return Intl.message(
      'This account already exist',
      name: 'accountAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Stores`
  String get stores {
    return Intl.message(
      'Stores',
      name: 'stores',
      desc: '',
      args: [],
    );
  }

  /// `Rate Store`
  String get rateStore {
    return Intl.message(
      'Rate Store',
      name: 'rateStore',
      desc: '',
      args: [],
    );
  }

  /// `Rate this store in your opinion`
  String get rateStoreMessage {
    return Intl.message(
      'Rate this store in your opinion',
      name: 'rateStoreMessage',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `stores has been rated`
  String get storeRated {
    return Intl.message(
      'stores has been rated',
      name: 'storeRated',
      desc: '',
      args: [],
    );
  }

  /// `Your rate has been submitted`
  String get rateSubmitting {
    return Intl.message(
      'Your rate has been submitted',
      name: 'rateSubmitting',
      desc: '',
      args: [],
    );
  }

  /// `Download Twaslna App on Play Store`
  String get downloadTwaslnaApp {
    return Intl.message(
      'Download Twaslna App on Play Store',
      name: 'downloadTwaslnaApp',
      desc: '',
      args: [],
    );
  }

  /// `Rate this captain upon your opinion`
  String get rateCaptainMessage {
    return Intl.message(
      'Rate this captain upon your opinion',
      name: 'rateCaptainMessage',
      desc: '',
      args: [],
    );
  }

  /// `Rate Captain`
  String get rateCaptain {
    return Intl.message(
      'Rate Captain',
      name: 'rateCaptain',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `With taxes `
  String get withTaxes {
    return Intl.message(
      'With taxes ',
      name: 'withTaxes',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get showingCart {
    return Intl.message(
      'Cart',
      name: 'showingCart',
      desc: '',
      args: [],
    );
  }

  /// `Item`
  String get item {
    return Intl.message(
      'Item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `Electronic`
  String get electronic {
    return Intl.message(
      'Electronic',
      name: 'electronic',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Sold`
  String get sold {
    return Intl.message(
      'Sold',
      name: 'sold',
      desc: '',
      args: [],
    );
  }

  /// `Specification`
  String get specification {
    return Intl.message(
      'Specification',
      name: 'specification',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get totalPrice {
    return Intl.message(
      'Total Price',
      name: 'totalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get productQuantity {
    return Intl.message(
      'Quantity',
      name: 'productQuantity',
      desc: '',
      args: [],
    );
  }

  /// `You have products from other store , Do you want to clear your cart and add the new ones`
  String get youHaveProductsFromDifferentStore {
    return Intl.message(
      'You have products from other store , Do you want to clear your cart and add the new ones',
      name: 'youHaveProductsFromDifferentStore',
      desc: '',
      args: [],
    );
  }

  /// `Product Rated`
  String get productRated {
    return Intl.message(
      'Product Rated',
      name: 'productRated',
      desc: '',
      args: [],
    );
  }

  /// `Please rate this product`
  String get rateProductMessage {
    return Intl.message(
      'Please rate this product',
      name: 'rateProductMessage',
      desc: '',
      args: [],
    );
  }

  /// `Rate Product`
  String get rateProduct {
    return Intl.message(
      'Rate Product',
      name: 'rateProduct',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Saller`
  String get seller {
    return Intl.message(
      'Saller',
      name: 'seller',
      desc: '',
      args: [],
    );
  }

  /// `Favorite Categories`
  String get favoriteCategories {
    return Intl.message(
      'Favorite Categories',
      name: 'favoriteCategories',
      desc: '',
      args: [],
    );
  }

  /// `Favorite Stores`
  String get favoriteStores {
    return Intl.message(
      'Favorite Stores',
      name: 'favoriteStores',
      desc: '',
      args: [],
    );
  }

  /// `Preferred Language`
  String get preferredLanguage {
    return Intl.message(
      'Preferred Language',
      name: 'preferredLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Item added to cart`
  String get cartItemAdded {
    return Intl.message(
      'Item added to cart',
      name: 'cartItemAdded',
      desc: '',
      args: [],
    );
  }

  /// `Item removed from cart`
  String get cartItemRemoved {
    return Intl.message(
      'Item removed from cart',
      name: 'cartItemRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Products Details`
  String get productDetails {
    return Intl.message(
      'Products Details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  /// `Invalid number`
  String get invalidNumber {
    return Intl.message(
      'Invalid number',
      name: 'invalidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Code`
  String get invalidCode {
    return Intl.message(
      'Invalid Code',
      name: 'invalidCode',
      desc: '',
      args: [],
    );
  }

  /// `Code number`
  String get codeNumber {
    return Intl.message(
      'Code number',
      name: 'codeNumber',
      desc: '',
      args: [],
    );
  }

  /// `Code has expired`
  String get codeTimeOut {
    return Intl.message(
      'Code has expired',
      name: 'codeTimeOut',
      desc: '',
      args: [],
    );
  }

  /// `The code has been successfully sent`
  String get resendCodeSuccessfully {
    return Intl.message(
      'The code has been successfully sent',
      name: 'resendCodeSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `You must enter the code first`
  String get notVerifiedNumber {
    return Intl.message(
      'You must enter the code first',
      name: 'notVerifiedNumber',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstName {
    return Intl.message(
      'First name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Middle name`
  String get middleName {
    return Intl.message(
      'Middle name',
      name: 'middleName',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastName {
    return Intl.message(
      'Last name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Payment process has been failed , please try again later`
  String get paymentFailed {
    return Intl.message(
      'Payment process has been failed , please try again later',
      name: 'paymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Extra details`
  String get extraDetails {
    return Intl.message(
      'Extra details',
      name: 'extraDetails',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productName {
    return Intl.message(
      'Product Name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Enter product information`
  String get enterProductInfo {
    return Intl.message(
      'Enter product information',
      name: 'enterProductInfo',
      desc: '',
      args: [],
    );
  }

  /// `Upload image if you have`
  String get uploadImageIfyouHave {
    return Intl.message(
      'Upload image if you have',
      name: 'uploadImageIfyouHave',
      desc: '',
      args: [],
    );
  }

  /// `Press here`
  String get pressHere {
    return Intl.message(
      'Press here',
      name: 'pressHere',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Your Request have been sent`
  String get yourRequestSent {
    return Intl.message(
      'Your Request have been sent',
      name: 'yourRequestSent',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPass {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPass',
      desc: '',
      args: [],
    );
  }

  /// `Our partners`
  String get partners {
    return Intl.message(
      'Our partners',
      name: 'partners',
      desc: '',
      args: [],
    );
  }

  /// `Payments via`
  String get paymentsVia {
    return Intl.message(
      'Payments via',
      name: 'paymentsVia',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirmNewPass {
    return Intl.message(
      'Confirm new password',
      name: 'confirmNewPass',
      desc: '',
      args: [],
    );
  }

  /// `Password updated successfully`
  String get passwordUpdatedSuccess {
    return Intl.message(
      'Password updated successfully',
      name: 'passwordUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `We will send a verification code to your number`
  String get informSendCode {
    return Intl.message(
      'We will send a verification code to your number',
      name: 'informSendCode',
      desc: '',
      args: [],
    );
  }

  /// `Password not matching`
  String get passwordNotMatch {
    return Intl.message(
      'Password not matching',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Phone number invalid format , cause is more than 9`
  String get phoneNumberLong {
    return Intl.message(
      'Phone number invalid format , cause is more than 9',
      name: 'phoneNumberLong',
      desc: '',
      args: [],
    );
  }

  /// `Similar Products`
  String get similarProducts {
    return Intl.message(
      'Similar Products',
      name: 'similarProducts',
      desc: '',
      args: [],
    );
  }

  /// `Account not exist`
  String get accountNotExist {
    return Intl.message(
      'Account not exist',
      name: 'accountNotExist',
      desc: '',
      args: [],
    );
  }

  /// `All prices in payments portal are included with 15% vat`
  String get paymentPortalHint {
    return Intl.message(
      'All prices in payments portal are included with 15% vat',
      name: 'paymentPortalHint',
      desc: '',
      args: [],
    );
  }

  /// `15% vat`
  String get tax {
    return Intl.message(
      '15% vat',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Pay Attention to cart content because changes have been made`
  String get cartAttention {
    return Intl.message(
      'Pay Attention to cart content because changes have been made',
      name: 'cartAttention',
      desc: '',
      args: [],
    );
  }

  /// `Checking Cart`
  String get cartValidation {
    return Intl.message(
      'Checking Cart',
      name: 'cartValidation',
      desc: '',
      args: [],
    );
  }

  /// `Without vat fee`
  String get withoutTax {
    return Intl.message(
      'Without vat fee',
      name: 'withoutTax',
      desc: '',
      args: [],
    );
  }

  /// `vat fee`
  String get extraTax {
    return Intl.message(
      'vat fee',
      name: 'extraTax',
      desc: '',
      args: [],
    );
  }

  /// `Payment Resume`
  String get paymentResume {
    return Intl.message(
      'Payment Resume',
      name: 'paymentResume',
      desc: '',
      args: [],
    );
  }

  /// `Record Number`
  String get recordNumber {
    return Intl.message(
      'Record Number',
      name: 'recordNumber',
      desc: '',
      args: [],
    );
  }

  /// `National Address`
  String get nationalAddress {
    return Intl.message(
      'National Address',
      name: 'nationalAddress',
      desc: '',
      args: [],
    );
  }

  /// `Tax Number`
  String get taxNumber {
    return Intl.message(
      'Tax Number',
      name: 'taxNumber',
      desc: '',
      args: [],
    );
  }

  /// `Captain rated successfully`
  String get captainRated {
    return Intl.message(
      'Captain rated successfully',
      name: 'captainRated',
      desc: '',
      args: [],
    );
  }

  /// `Launch our app`
  String get launch {
    return Intl.message(
      'Launch our app',
      name: 'launch',
      desc: '',
      args: [],
    );
  }

  /// `If you have somthing to deliver far from you dont wory just open our app`
  String get lanchDescribtion {
    return Intl.message(
      'If you have somthing to deliver far from you dont wory just open our app',
      name: 'lanchDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `You need to book a captain to deliver your package to your destenation`
  String get bookACarDescribtion {
    return Intl.message(
      'You need to book a captain to deliver your package to your destenation',
      name: 'bookACarDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `We will deliver your package for you in the fastest way and the best`
  String get weDeliverDescribtion {
    return Intl.message(
      'We will deliver your package for you in the fastest way and the best',
      name: 'weDeliverDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `If you have the ability to deliver packages for us you are welcome`
  String get lanchDescribtionCaptain {
    return Intl.message(
      'If you have the ability to deliver packages for us you are welcome',
      name: 'lanchDescribtionCaptain',
      desc: '',
      args: [],
    );
  }

  /// `You can check the app for packages near you to deliver`
  String get checkOrdersDescribtion {
    return Intl.message(
      'You can check the app for packages near you to deliver',
      name: 'checkOrdersDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `You can accept your mission to deliver package`
  String get acceptOrderDescribtion {
    return Intl.message(
      'You can accept your mission to deliver package',
      name: 'acceptOrderDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `After accepting your mission you will deliver package to the right destination`
  String get deliverDescribtion {
    return Intl.message(
      'After accepting your mission you will deliver package to the right destination',
      name: 'deliverDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `After you doing your job your effort will be rewarded by earning money`
  String get earnCashDescribtion {
    return Intl.message(
      'After you doing your job your effort will be rewarded by earning money',
      name: 'earnCashDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get countryCode {
    return Intl.message(
      'Code',
      name: 'countryCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordAgain {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordAgain',
      desc: '',
      args: [],
    );
  }

  /// `Write Password Again`
  String get writePasswordAgain {
    return Intl.message(
      'Write Password Again',
      name: 'writePasswordAgain',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Jaddah`
  String get cityHint {
    return Intl.message(
      'Jaddah',
      name: 'cityHint',
      desc: '',
      args: [],
    );
  }

  /// `Bimo`
  String get bankNameHint {
    return Intl.message(
      'Bimo',
      name: 'bankNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone number`
  String get pleaseEnterValidPhoneNumber {
    return Intl.message(
      'Please enter phone number',
      name: 'pleaseEnterValidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `invalid character`
  String get pleaseEnterValidCountryCode {
    return Intl.message(
      'invalid character',
      name: 'pleaseEnterValidCountryCode',
      desc: '',
      args: [],
    );
  }

  /// `Setup Account`
  String get storeAccountInit {
    return Intl.message(
      'Setup Account',
      name: 'storeAccountInit',
      desc: '',
      args: [],
    );
  }

  /// `Empty Field`
  String get emptyField {
    return Intl.message(
      'Empty Field',
      name: 'emptyField',
      desc: '',
      args: [],
    );
  }

  /// `Invalid`
  String get InvalidInput {
    return Intl.message(
      'Invalid',
      name: 'InvalidInput',
      desc: '',
      args: [],
    );
  }

  /// `Store name must not be less than 3 character`
  String get storeNameIsToShort {
    return Intl.message(
      'Store name must not be less than 3 character',
      name: 'storeNameIsToShort',
      desc: '',
      args: [],
    );
  }

  /// `Choose your capacity`
  String get chooseYourCompanyCapacity {
    return Intl.message(
      'Choose your capacity',
      name: 'chooseYourCompanyCapacity',
      desc: '',
      args: [],
    );
  }

  /// `Package Info`
  String get packageInfo {
    return Intl.message(
      'Package Info',
      name: 'packageInfo',
      desc: '',
      args: [],
    );
  }

  /// `Choose your desired package subscriptions based on your wanted category`
  String get chooseYourPackageHint {
    return Intl.message(
      'Choose your desired package subscriptions based on your wanted category',
      name: 'chooseYourPackageHint',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `You subscripted with the package successfully`
  String get packageSubscriptionSuccess {
    return Intl.message(
      'You subscripted with the package successfully',
      name: 'packageSubscriptionSuccess',
      desc: '',
      args: [],
    );
  }

  /// `My Location`
  String get myLocation {
    return Intl.message(
      'My Location',
      name: 'myLocation',
      desc: '',
      args: [],
    );
  }

  /// `Tap the mark icon to to go to your location`
  String get myLocationDescribtion {
    return Intl.message(
      'Tap the mark icon to to go to your location',
      name: 'myLocationDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `My Selected Branches`
  String get selectedBranchesMenu {
    return Intl.message(
      'My Selected Branches',
      name: 'selectedBranchesMenu',
      desc: '',
      args: [],
    );
  }

  /// `Tap the menu icon to show selected branches`
  String get selectedBranchesMenuDescribtion {
    return Intl.message(
      'Tap the menu icon to show selected branches',
      name: 'selectedBranchesMenuDescribtion',
      desc: '',
      args: [],
    );
  }

  /// `Branch management`
  String get branchManagement {
    return Intl.message(
      'Branch management',
      name: 'branchManagement',
      desc: '',
      args: [],
    );
  }

  /// `My Subscription`
  String get mySubscription {
    return Intl.message(
      'My Subscription',
      name: 'mySubscription',
      desc: '',
      args: [],
    );
  }

  /// `Account inactivated`
  String get accountInActivated {
    return Intl.message(
      'Account inactivated',
      name: 'accountInActivated',
      desc: '',
      args: [],
    );
  }

  /// `Account activated`
  String get accountActivated {
    return Intl.message(
      'Account activated',
      name: 'accountActivated',
      desc: '',
      args: [],
    );
  }

  /// `Update profile`
  String get updateProfile {
    return Intl.message(
      'Update profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Employee count`
  String get employeeSize {
    return Intl.message(
      'Employee count',
      name: 'employeeSize',
      desc: '',
      args: [],
    );
  }

  /// `Profile has been updated successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Profile has been updated successfully',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp`
  String get whatsapp {
    return Intl.message(
      'Whatsapp',
      name: 'whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp support`
  String get whatsappSupport {
    return Intl.message(
      'Whatsapp support',
      name: 'whatsappSupport',
      desc: '',
      args: [],
    );
  }

  /// `Confirm deletion of this branch`
  String get confirmDeletionBranch {
    return Intl.message(
      'Confirm deletion of this branch',
      name: 'confirmDeletionBranch',
      desc: '',
      args: [],
    );
  }

  /// `Branch deleted successfully`
  String get deleteBranchSuccess {
    return Intl.message(
      'Branch deleted successfully',
      name: 'deleteBranchSuccess',
      desc: '',
      args: [],
    );
  }

  /// `If you have any difficulties with saving branches please reach out our support team`
  String get saveBranchAlert {
    return Intl.message(
      'If you have any difficulties with saving branches please reach out our support team',
      name: 'saveBranchAlert',
      desc: '',
      args: [],
    );
  }

  /// `This button let you to make a new order`
  String get newOrderHint {
    return Intl.message(
      'This button let you to make a new order',
      name: 'newOrderHint',
      desc: '',
      args: [],
    );
  }

  /// `There is no packages in this category`
  String get emptyPackagesCategory {
    return Intl.message(
      'There is no packages in this category',
      name: 'emptyPackagesCategory',
      desc: '',
      args: [],
    );
  }

  /// `Choose package category`
  String get choosePackageCategories {
    return Intl.message(
      'Choose package category',
      name: 'choosePackageCategories',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Subscription status`
  String get subscriptionStatus {
    return Intl.message(
      'Subscription status',
      name: 'subscriptionStatus',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get inactive {
    return Intl.message(
      'Inactive',
      name: 'inactive',
      desc: '',
      args: [],
    );
  }

  /// `Expiration date`
  String get expirationData {
    return Intl.message(
      'Expiration date',
      name: 'expirationData',
      desc: '',
      args: [],
    );
  }

  /// `Expired subscriptions please renew your subscription`
  String get ExpiredSubscriptions {
    return Intl.message(
      'Expired subscriptions please renew your subscription',
      name: 'ExpiredSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Choose Branch`
  String get chooseBranch {
    return Intl.message(
      'Choose Branch',
      name: 'chooseBranch',
      desc: '',
      args: [],
    );
  }

  /// `Order created successfully`
  String get orderCreatedSuccessfully {
    return Intl.message(
      'Order created successfully',
      name: 'orderCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about creating new order`
  String get confirmMakeOrder {
    return Intl.message(
      'Are you sure about creating new order',
      name: 'confirmMakeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message(
      'Selected',
      name: 'selected',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Order cost contains delivery tax`
  String get orderCostWithDeliveryCost {
    return Intl.message(
      'Order cost contains delivery tax',
      name: 'orderCostWithDeliveryCost',
      desc: '',
      args: [],
    );
  }

  /// `There is no branches available`
  String get thereIsNoBranches {
    return Intl.message(
      'There is no branches available',
      name: 'thereIsNoBranches',
      desc: '',
      args: [],
    );
  }

  /// `Total Payments To Company`
  String get sumPaymentsToCompany {
    return Intl.message(
      'Total Payments To Company',
      name: 'sumPaymentsToCompany',
      desc: '',
      args: [],
    );
  }

  /// `Total Payments From Company`
  String get sumPaymentsFromCompany {
    return Intl.message(
      'Total Payments From Company',
      name: 'sumPaymentsFromCompany',
      desc: '',
      args: [],
    );
  }

  /// `Total Payments To Captain`
  String get sumPaymentsToCaptain {
    return Intl.message(
      'Total Payments To Captain',
      name: 'sumPaymentsToCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Total Payments From Captain`
  String get sumPaymentsFromCaptain {
    return Intl.message(
      'Total Payments From Captain',
      name: 'sumPaymentsFromCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Count Orders Delivered`
  String get countOrdersDelivered {
    return Intl.message(
      'Count Orders Delivered',
      name: 'countOrdersDelivered',
      desc: '',
      args: [],
    );
  }

  /// `My Actual Balance`
  String get amountYouOwn {
    return Intl.message(
      'My Actual Balance',
      name: 'amountYouOwn',
      desc: '',
      args: [],
    );
  }

  /// `Remaining Amount For Company`
  String get remainingAmountForCompany {
    return Intl.message(
      'Remaining Amount For Company',
      name: 'remainingAmountForCompany',
      desc: '',
      args: [],
    );
  }

  /// `Bounce`
  String get bounce {
    return Intl.message(
      'Bounce',
      name: 'bounce',
      desc: '',
      args: [],
    );
  }

  /// `Kilometer Bonus`
  String get kilometerBonus {
    return Intl.message(
      'Kilometer Bonus',
      name: 'kilometerBonus',
      desc: '',
      args: [],
    );
  }

  /// `Profit`
  String get netProfit {
    return Intl.message(
      'Profit',
      name: 'netProfit',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Payments`
  String get payments {
    return Intl.message(
      'Payments',
      name: 'payments',
      desc: '',
      args: [],
    );
  }

  /// `At`
  String get at {
    return Intl.message(
      'At',
      name: 'at',
      desc: '',
      args: [],
    );
  }

  /// `Payment amount`
  String get paymentAmount {
    return Intl.message(
      'Payment amount',
      name: 'paymentAmount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this payment`
  String get areYouSureToDeleteThisPayment {
    return Intl.message(
      'Are you sure you want to delete this payment',
      name: 'areYouSureToDeleteThisPayment',
      desc: '',
      args: [],
    );
  }

  /// `Delivery date`
  String get deliverDate {
    return Intl.message(
      'Delivery date',
      name: 'deliverDate',
      desc: '',
      args: [],
    );
  }

  /// `Created date`
  String get createdDate {
    return Intl.message(
      'Created date',
      name: 'createdDate',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing Order`
  String get onGoingOrder {
    return Intl.message(
      'Ongoing Order',
      name: 'onGoingOrder',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Opening Time`
  String get openingTime {
    return Intl.message(
      'Opening Time',
      name: 'openingTime',
      desc: '',
      args: [],
    );
  }

  /// `Closing Time`
  String get closingTime {
    return Intl.message(
      'Closing Time',
      name: 'closingTime',
      desc: '',
      args: [],
    );
  }

  /// `Work time`
  String get workTime {
    return Intl.message(
      'Work time',
      name: 'workTime',
      desc: '',
      args: [],
    );
  }

  /// `Order Image`
  String get orderImage {
    return Intl.message(
      'Order Image',
      name: 'orderImage',
      desc: '',
      args: [],
    );
  }

  /// `All city`
  String get allCity {
    return Intl.message(
      'All city',
      name: 'allCity',
      desc: '',
      args: [],
    );
  }

  /// `Validation`
  String get validation {
    return Intl.message(
      'Validation',
      name: 'validation',
      desc: '',
      args: [],
    );
  }

  /// `Subscription date`
  String get subscriptionDate {
    return Intl.message(
      'Subscription date',
      name: 'subscriptionDate',
      desc: '',
      args: [],
    );
  }

  /// `Subscription packages`
  String get subscribeWithPackage {
    return Intl.message(
      'Subscription packages',
      name: 'subscribeWithPackage',
      desc: '',
      args: [],
    );
  }

  /// `Notification deleted successfully`
  String get notificationDeletedSuccess {
    return Intl.message(
      'Notification deleted successfully',
      name: 'notificationDeletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Notifications deleted successfully`
  String get notificationsDeletedSuccess {
    return Intl.message(
      'Notifications deleted successfully',
      name: 'notificationsDeletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about deleting selected notifications`
  String get areYouSureAboutDeleteSelectedNotifications {
    return Intl.message(
      'Are you sure about deleting selected notifications',
      name: 'areYouSureAboutDeleteSelectedNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about deleting this notification`
  String get areYouSureAboutDeleteThisNotification {
    return Intl.message(
      'Are you sure about deleting this notification',
      name: 'areYouSureAboutDeleteThisNotification',
      desc: '',
      args: [],
    );
  }

  /// `Sorted by latest`
  String get sortedByLatest {
    return Intl.message(
      'Sorted by latest',
      name: 'sortedByLatest',
      desc: '',
      args: [],
    );
  }

  /// `Pending order`
  String get pendingOrders {
    return Intl.message(
      'Pending order',
      name: 'pendingOrders',
      desc: '',
      args: [],
    );
  }

  /// `You have already subscribed , and your subscription still valid`
  String get renewedFailedYourSubStillActive {
    return Intl.message(
      'You have already subscribed , and your subscription still valid',
      name: 'renewedFailedYourSubStillActive',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about renewing your subscription , because if you do that you will lose current subscriptions`
  String get renewedNoteYourSubStillActive {
    return Intl.message(
      'Are you sure about renewing your subscription , because if you do that you will lose current subscriptions',
      name: 'renewedNoteYourSubStillActive',
      desc: '',
      args: [],
    );
  }

  /// `From date`
  String get firstDate {
    return Intl.message(
      'From date',
      name: 'firstDate',
      desc: '',
      args: [],
    );
  }

  /// `To date`
  String get endDate {
    return Intl.message(
      'To date',
      name: 'endDate',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription extended successfully`
  String get packageExtendedSuccessfully {
    return Intl.message(
      'Your subscription extended successfully',
      name: 'packageExtendedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Temporary subscription extend`
  String get packageExtend {
    return Intl.message(
      'Temporary subscription extend',
      name: 'packageExtend',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription already extended , You can't extend it again`
  String get alreadyExtended {
    return Intl.message(
      'Your subscription already extended , You can\'t extend it again',
      name: 'alreadyExtended',
      desc: '',
      args: [],
    );
  }

  /// `This Package not available to renew any more`
  String get packageNotFoundRenew {
    return Intl.message(
      'This Package not available to renew any more',
      name: 'packageNotFoundRenew',
      desc: '',
      args: [],
    );
  }

  /// `Ads and Offers`
  String get notices {
    return Intl.message(
      'Ads and Offers',
      name: 'notices',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Link Copied Successfully`
  String get copyFinished {
    return Intl.message(
      'Link Copied Successfully',
      name: 'copyFinished',
      desc: '',
      args: [],
    );
  }

  /// `Choose your rate from five stars`
  String get chooseYourRateFromFiveStar {
    return Intl.message(
      'Choose your rate from five stars',
      name: 'chooseYourRateFromFiveStar',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `What we can to improve`
  String get rateCommentReview {
    return Intl.message(
      'What we can to improve',
      name: 'rateCommentReview',
      desc: '',
      args: [],
    );
  }

  /// `Public phone number`
  String get phoneNumberThatShowsForCaptain {
    return Intl.message(
      'Public phone number',
      name: 'phoneNumberThatShowsForCaptain',
      desc: '',
      args: [],
    );
  }

  /// `eg`
  String get eg {
    return Intl.message(
      'eg',
      name: 'eg',
      desc: '',
      args: [],
    );
  }

  /// `Extra captain`
  String get extraCaptain {
    return Intl.message(
      'Extra captain',
      name: 'extraCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Captains Extra Offer`
  String get captainPackageExtra {
    return Intl.message(
      'Captains Extra Offer',
      name: 'captainPackageExtra',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing`
  String get ongoing {
    return Intl.message(
      'Ongoing',
      name: 'ongoing',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled2 {
    return Intl.message(
      'Cancelled',
      name: 'cancelled2',
      desc: '',
      args: [],
    );
  }

  /// `Invalid map link`
  String get invalidMapLink {
    return Intl.message(
      'Invalid map link',
      name: 'invalidMapLink',
      desc: '',
      args: [],
    );
  }

  /// `Km`
  String get km {
    return Intl.message(
      'Km',
      name: 'km',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get distance {
    return Intl.message(
      'Distance',
      name: 'distance',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get unavailable {
    return Intl.message(
      'Unavailable',
      name: 'unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Calculating`
  String get calculating {
    return Intl.message(
      'Calculating',
      name: 'calculating',
      desc: '',
      args: [],
    );
  }

  /// `You subscribed with captain offer with a success`
  String get subscribedToOfferSuccess {
    return Intl.message(
      'You subscribed with captain offer with a success',
      name: 'subscribedToOfferSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Are sure about subscribe with this offer`
  String get confirmationCaptainOffers {
    return Intl.message(
      'Are sure about subscribe with this offer',
      name: 'confirmationCaptainOffers',
      desc: '',
      args: [],
    );
  }

  /// `Company Info`
  String get companyInfo {
    return Intl.message(
      'Company Info',
      name: 'companyInfo',
      desc: '',
      args: [],
    );
  }

  /// `Fax`
  String get fax {
    return Intl.message(
      'Fax',
      name: 'fax',
      desc: '',
      args: [],
    );
  }

  /// `You already subscribed with captain offer , You can subscribe again when your subscription expired`
  String get youSubscribedWithOffer {
    return Intl.message(
      'You already subscribed with captain offer , You can subscribe again when your subscription expired',
      name: 'youSubscribedWithOffer',
      desc: '',
      args: [],
    );
  }

  /// `Destination unavailable`
  String get destinationUnavailable {
    return Intl.message(
      'Destination unavailable',
      name: 'destinationUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `This offer not available to renew any more`
  String get offerNotFoundRenew {
    return Intl.message(
      'This offer not available to renew any more',
      name: 'offerNotFoundRenew',
      desc: '',
      args: [],
    );
  }

  /// `Enquiry about order number`
  String get enquiryAboutOrder {
    return Intl.message(
      'Enquiry about order number',
      name: 'enquiryAboutOrder',
      desc: '',
      args: [],
    );
  }

  /// `Orders Enquiries`
  String get enquiries {
    return Intl.message(
      'Orders Enquiries',
      name: 'enquiries',
      desc: '',
      args: [],
    );
  }

  /// `Sending report within 5 seconds`
  String get sendingReport {
    return Intl.message(
      'Sending report within 5 seconds',
      name: 'sendingReport',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Confirm with yes and no if captain reach you`
  String get confirmingCaptainLocation {
    return Intl.message(
      'Confirm with yes and no if captain reach you',
      name: 'confirmingCaptainLocation',
      desc: '',
      args: [],
    );
  }

  /// `Redo`
  String get redo {
    return Intl.message(
      'Redo',
      name: 'redo',
      desc: '',
      args: [],
    );
  }

  /// `Dear`
  String get dear {
    return Intl.message(
      'Dear',
      name: 'dear',
      desc: '',
      args: [],
    );
  }

  /// `You have consumed 35%`
  String get orderAverage35 {
    return Intl.message(
      'You have consumed 35%',
      name: 'orderAverage35',
      desc: '',
      args: [],
    );
  }

  /// `You have consumed 40%`
  String get orderAverage40 {
    return Intl.message(
      'You have consumed 40%',
      name: 'orderAverage40',
      desc: '',
      args: [],
    );
  }

  /// `You have consumed 75%`
  String get orderAverage75 {
    return Intl.message(
      'You have consumed 75%',
      name: 'orderAverage75',
      desc: '',
      args: [],
    );
  }

  /// `You have consumed 80%`
  String get orderAverage80 {
    return Intl.message(
      'You have consumed 80%',
      name: 'orderAverage80',
      desc: '',
      args: [],
    );
  }

  /// `You have consumed`
  String get youConsumed {
    return Intl.message(
      'You have consumed',
      name: 'youConsumed',
      desc: '',
      args: [],
    );
  }

  /// `Retained cash`
  String get captainOrderCost {
    return Intl.message(
      'Retained cash',
      name: 'captainOrderCost',
      desc: '',
      args: [],
    );
  }

  /// `Retained cash note`
  String get captainPaymentNote {
    return Intl.message(
      'Retained cash note',
      name: 'captainPaymentNote',
      desc: '',
      args: [],
    );
  }

  /// `Order Time Line`
  String get orderTimeLine {
    return Intl.message(
      'Order Time Line',
      name: 'orderTimeLine',
      desc: '',
      args: [],
    );
  }

  /// `Captain Location`
  String get captainLocation {
    return Intl.message(
      'Captain Location',
      name: 'captainLocation',
      desc: '',
      args: [],
    );
  }

  /// `Captain not in Store`
  String get captainNotInStore {
    return Intl.message(
      'Captain not in Store',
      name: 'captainNotInStore',
      desc: '',
      args: [],
    );
  }

  /// `Not Confirmed`
  String get NotConfirmed {
    return Intl.message(
      'Not Confirmed',
      name: 'NotConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `You can't delete order, You exceeded time limit`
  String get youCannotDeleteOrder {
    return Intl.message(
      'You can\'t delete order, You exceeded time limit',
      name: 'youCannotDeleteOrder',
      desc: '',
      args: [],
    );
  }

  /// `Are sure about deleting this order ? `
  String get areYouSureAboutDeleteOrder {
    return Intl.message(
      'Are sure about deleting this order ? ',
      name: 'areYouSureAboutDeleteOrder',
      desc: '',
      args: [],
    );
  }

  /// `You can't delete order, captain accepted this order`
  String get youCannotDeleteOrderCaptainAccepted {
    return Intl.message(
      'You can\'t delete order, captain accepted this order',
      name: 'youCannotDeleteOrderCaptainAccepted',
      desc: '',
      args: [],
    );
  }

  /// `Your store inactive , please wait until be activated by the administration`
  String get inactiveStore {
    return Intl.message(
      'Your store inactive , please wait until be activated by the administration',
      name: 'inactiveStore',
      desc: '',
      args: [],
    );
  }

  /// `Package cost`
  String get packageCost {
    return Intl.message(
      'Package cost',
      name: 'packageCost',
      desc: '',
      args: [],
    );
  }

  /// `Sum payments`
  String get sumPayments {
    return Intl.message(
      'Sum payments',
      name: 'sumPayments',
      desc: '',
      args: [],
    );
  }

  /// `Account Balance`
  String get accountBalance {
    return Intl.message(
      'Account Balance',
      name: 'accountBalance',
      desc: '',
      args: [],
    );
  }

  /// `Here you find all your subscriptions financial information with included all payments `
  String get balanceHint {
    return Intl.message(
      'Here you find all your subscriptions financial information with included all payments ',
      name: 'balanceHint',
      desc: '',
      args: [],
    );
  }

  /// `Finance Subscription Details`
  String get financeSubscriptionDetails {
    return Intl.message(
      'Finance Subscription Details',
      name: 'financeSubscriptionDetails',
      desc: '',
      args: [],
    );
  }

  /// `order`
  String get sOrder {
    return Intl.message(
      'order',
      name: 'sOrder',
      desc: '',
      args: [],
    );
  }

  /// `Cost received from captain`
  String get orderCostHandedByCaptain {
    return Intl.message(
      'Cost received from captain',
      name: 'orderCostHandedByCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get financePaid {
    return Intl.message(
      'Paid',
      name: 'financePaid',
      desc: '',
      args: [],
    );
  }

  /// `Unpaid`
  String get financeUnPaid {
    return Intl.message(
      'Unpaid',
      name: 'financeUnPaid',
      desc: '',
      args: [],
    );
  }

  /// `Partly paid`
  String get financePartlyPaid {
    return Intl.message(
      'Partly paid',
      name: 'financePartlyPaid',
      desc: '',
      args: [],
    );
  }

  /// `Captain Offers`
  String get captainOffers {
    return Intl.message(
      'Captain Offers',
      name: 'captainOffers',
      desc: '',
      args: [],
    );
  }

  /// `New sub order`
  String get newOrderLink {
    return Intl.message(
      'New sub order',
      name: 'newOrderLink',
      desc: '',
      args: [],
    );
  }

  /// `Order can contains a sub orders`
  String get thisOrderCanBeLinked {
    return Intl.message(
      'Order can contains a sub orders',
      name: 'thisOrderCanBeLinked',
      desc: '',
      args: [],
    );
  }

  /// `Group Order`
  String get groupOrder {
    return Intl.message(
      'Group Order',
      name: 'groupOrder',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about creating new sub order , you can split later if needed`
  String get areYouSureAboutCreatingSubOrder {
    return Intl.message(
      'Are you sure about creating new sub order , you can split later if needed',
      name: 'areYouSureAboutCreatingSubOrder',
      desc: '',
      args: [],
    );
  }

  /// `Unlink suborders`
  String get unlinkSubOrders {
    return Intl.message(
      'Unlink suborders',
      name: 'unlinkSubOrders',
      desc: '',
      args: [],
    );
  }

  /// `Order Removed Successfully`
  String get orderRemovedSuccessfully {
    return Intl.message(
      'Order Removed Successfully',
      name: 'orderRemovedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Primary order`
  String get primaryOrder {
    return Intl.message(
      'Primary order',
      name: 'primaryOrder',
      desc: '',
      args: [],
    );
  }

  /// `Suborder`
  String get suborder {
    return Intl.message(
      'Suborder',
      name: 'suborder',
      desc: '',
      args: [],
    );
  }

  /// `Order already accepted by captain`
  String get orderAlreadyAccepted {
    return Intl.message(
      'Order already accepted by captain',
      name: 'orderAlreadyAccepted',
      desc: '',
      args: [],
    );
  }

  /// `Hidden Order`
  String get hiddenOrder {
    return Intl.message(
      'Hidden Order',
      name: 'hiddenOrder',
      desc: '',
      args: [],
    );
  }

  /// `Republish`
  String get republish {
    return Intl.message(
      'Republish',
      name: 'republish',
      desc: '',
      args: [],
    );
  }

  /// `Recycle Order`
  String get recycleOrder {
    return Intl.message(
      'Recycle Order',
      name: 'recycleOrder',
      desc: '',
      args: [],
    );
  }

  /// `title`
  String get title {
    return Intl.message(
      'title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `description`
  String get description {
    return Intl.message(
      'description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `open`
  String get open {
    return Intl.message(
      'open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `close`
  String get closeOrder {
    return Intl.message(
      'close',
      name: 'closeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Open order`
  String get openOrder {
    return Intl.message(
      'Open order',
      name: 'openOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order category`
  String get orderCategory {
    return Intl.message(
      'Order category',
      name: 'orderCategory',
      desc: '',
      args: [],
    );
  }

  /// `Choose category`
  String get chooseCategory {
    return Intl.message(
      'Choose category',
      name: 'chooseCategory',
      desc: '',
      args: [],
    );
  }

  /// `New bidorder`
  String get newBidOrder {
    return Intl.message(
      'New bidorder',
      name: 'newBidOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order Offers`
  String get orderOffers {
    return Intl.message(
      'Order Offers',
      name: 'orderOffers',
      desc: '',
      args: [],
    );
  }

  /// `My bid order`
  String get myBidOrder {
    return Intl.message(
      'My bid order',
      name: 'myBidOrder',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about refuse this offer`
  String get confirmRefuseOffer {
    return Intl.message(
      'Are you sure about refuse this offer',
      name: 'confirmRefuseOffer',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about accept this offer`
  String get confirmAcceptOffer {
    return Intl.message(
      'Are you sure about accept this offer',
      name: 'confirmAcceptOffer',
      desc: '',
      args: [],
    );
  }

  /// `Offer Status Updated Successfully`
  String get offerStatusUpdatedSuccessfully {
    return Intl.message(
      'Offer Status Updated Successfully',
      name: 'offerStatusUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Waiting Supplier`
  String get waitingSupplier {
    return Intl.message(
      'Waiting Supplier',
      name: 'waitingSupplier',
      desc: '',
      args: [],
    );
  }

  /// `Waiting Captain`
  String get waitingCaptain {
    return Intl.message(
      'Waiting Captain',
      name: 'waitingCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Offer price`
  String get offerPrice {
    return Intl.message(
      'Offer price',
      name: 'offerPrice',
      desc: '',
      args: [],
    );
  }

  /// `Deliver Cost`
  String get deliverCost {
    return Intl.message(
      'Deliver Cost',
      name: 'deliverCost',
      desc: '',
      args: [],
    );
  }

  /// `Profit Margin`
  String get profitMargin {
    return Intl.message(
      'Profit Margin',
      name: 'profitMargin',
      desc: '',
      args: [],
    );
  }

  /// `Transportation Count`
  String get transCount {
    return Intl.message(
      'Transportation Count',
      name: 'transCount',
      desc: '',
      args: [],
    );
  }

  /// `Car model`
  String get carModel {
    return Intl.message(
      'Car model',
      name: 'carModel',
      desc: '',
      args: [],
    );
  }

  /// `pending`
  String get pendingOffer {
    return Intl.message(
      'pending',
      name: 'pendingOffer',
      desc: '',
      args: [],
    );
  }

  /// `refused`
  String get refusedOffer {
    return Intl.message(
      'refused',
      name: 'refusedOffer',
      desc: '',
      args: [],
    );
  }

  /// `accepted`
  String get acceptedOffer {
    return Intl.message(
      'accepted',
      name: 'acceptedOffer',
      desc: '',
      args: [],
    );
  }

  /// `confirmed`
  String get confirmed {
    return Intl.message(
      'confirmed',
      name: 'confirmed',
      desc: '',
      args: [],
    );
  }

  /// `offerNumber`
  String get offerNumber {
    return Intl.message(
      'offerNumber',
      name: 'offerNumber',
      desc: '',
      args: [],
    );
  }

  /// `offerStatus`
  String get offerStatus {
    return Intl.message(
      'offerStatus',
      name: 'offerStatus',
      desc: '',
      args: [],
    );
  }

  /// `Notification sound`
  String get notificationSound {
    return Intl.message(
      'Notification sound',
      name: 'notificationSound',
      desc: '',
      args: [],
    );
  }

  /// `Ringtone`
  String get ringtone {
    return Intl.message(
      'Ringtone',
      name: 'ringtone',
      desc: '',
      args: [],
    );
  }

  /// `Order processing by captain `
  String get orderHandledByCaptain {
    return Intl.message(
      'Order processing by captain ',
      name: 'orderHandledByCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Order processed by captain `
  String get orderHandledDoneByCaptain {
    return Intl.message(
      'Order processed by captain ',
      name: 'orderHandledDoneByCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Your branch missing phone number`
  String get yourBranchMissingPhoneNumber {
    return Intl.message(
      'Your branch missing phone number',
      name: 'yourBranchMissingPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Danger Zone`
  String get dangerZone {
    return Intl.message(
      'Danger Zone',
      name: 'dangerZone',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about deleting your account , you won't be able to login with this credential any more`
  String get areSureAboutDeletingYourAccount {
    return Intl.message(
      'Are you sure about deleting your account , you won\'t be able to login with this credential any more',
      name: 'areSureAboutDeletingYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `This area contain a very sensitive action may cause to loose all your data , and there is no going back in current time`
  String get DeletingYourAccountHint {
    return Intl.message(
      'This area contain a very sensitive action may cause to loose all your data , and there is no going back in current time',
      name: 'DeletingYourAccountHint',
      desc: '',
      args: [],
    );
  }

  /// `User deleted successfully`
  String get userDeleted {
    return Intl.message(
      'User deleted successfully',
      name: 'userDeleted',
      desc: '',
      args: [],
    );
  }

  /// `If you will continue this process , this order will be hide from captains until you confirm new adjustment`
  String get updateOrderWarning {
    return Intl.message(
      'If you will continue this process , this order will be hide from captains until you confirm new adjustment',
      name: 'updateOrderWarning',
      desc: '',
      args: [],
    );
  }

  /// `Edit order`
  String get editOrder {
    return Intl.message(
      'Edit order',
      name: 'editOrder',
      desc: '',
      args: [],
    );
  }

  /// `Confirm update order`
  String get confirmUpdateOrder {
    return Intl.message(
      'Confirm update order',
      name: 'confirmUpdateOrder',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contacts {
    return Intl.message(
      'Contacts',
      name: 'contacts',
      desc: '',
      args: [],
    );
  }

  /// `Search in contacts`
  String get searchInContacts {
    return Intl.message(
      'Search in contacts',
      name: 'searchInContacts',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection , and try again`
  String get pleaseCheckYourInternetConnection {
    return Intl.message(
      'Please check your internet connection , and try again',
      name: 'pleaseCheckYourInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message(
      'Try again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the`
  String get iAgreeOn {
    return Intl.message(
      'I agree to the',
      name: 'iAgreeOn',
      desc: '',
      args: [],
    );
  }

  /// `terms of use`
  String get terms {
    return Intl.message(
      'terms of use',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `privacy policy`
  String get privacy {
    return Intl.message(
      'privacy policy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// ` & `
  String get and {
    return Intl.message(
      ' & ',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Attach file`
  String get attachFile {
    return Intl.message(
      'Attach file',
      name: 'attachFile',
      desc: '',
      args: [],
    );
  }

  /// `This order has attached file`
  String get attachedFile {
    return Intl.message(
      'This order has attached file',
      name: 'attachedFile',
      desc: '',
      args: [],
    );
  }

  /// `Now`
  String get now {
    return Intl.message(
      'Now',
      name: 'now',
      desc: '',
      args: [],
    );
  }

  /// `New version`
  String get newVersion {
    return Intl.message(
      'New version',
      name: 'newVersion',
      desc: '',
      args: [],
    );
  }

  /// `There is new version of our app available to update , please update from ^ to & now to avoid having any problems in future`
  String get newVersionHint {
    return Intl.message(
      'There is new version of our app available to update , please update from ^ to & now to avoid having any problems in future',
      name: 'newVersionHint',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `On order package`
  String get onOrderPackage {
    return Intl.message(
      'On order package',
      name: 'onOrderPackage',
      desc: '',
      args: [],
    );
  }

  /// `Geographical range`
  String get geographicalRange {
    return Intl.message(
      'Geographical range',
      name: 'geographicalRange',
      desc: '',
      args: [],
    );
  }

  /// `Extra Cost`
  String get extraCost {
    return Intl.message(
      'Extra Cost',
      name: 'extraCost',
      desc: '',
      args: [],
    );
  }

  /// `Extra cost for every kilometer over geographical range`
  String get extraCostHint {
    return Intl.message(
      'Extra cost for every kilometer over geographical range',
      name: 'extraCostHint',
      desc: '',
      args: [],
    );
  }

  /// `Delivery cost`
  String get deliveryCost {
    return Intl.message(
      'Delivery cost',
      name: 'deliveryCost',
      desc: '',
      args: [],
    );
  }

  /// `Extra Distance`
  String get extraDistance {
    return Intl.message(
      'Extra Distance',
      name: 'extraDistance',
      desc: '',
      args: [],
    );
  }

  /// `Extra order delivery cost`
  String get extraOrderDeliveryCost {
    return Intl.message(
      'Extra order delivery cost',
      name: 'extraOrderDeliveryCost',
      desc: '',
      args: [],
    );
  }

  /// `Order delivery cost`
  String get orderDeliveryCost {
    return Intl.message(
      'Order delivery cost',
      name: 'orderDeliveryCost',
      desc: '',
      args: [],
    );
  }

  /// `Delivery cost details`
  String get deliveryCostDetails {
    return Intl.message(
      'Delivery cost details',
      name: 'deliveryCostDetails',
      desc: '',
      args: [],
    );
  }

  /// `Order without distance`
  String get orderWithoutDistance {
    return Intl.message(
      'Order without distance',
      name: 'orderWithoutDistance',
      desc: '',
      args: [],
    );
  }

  /// `Branch location`
  String get branchLocation {
    return Intl.message(
      'Branch location',
      name: 'branchLocation',
      desc: '',
      args: [],
    );
  }

  /// `Client location`
  String get clientLocation {
    return Intl.message(
      'Client location',
      name: 'clientLocation',
      desc: '',
      args: [],
    );
  }

  /// `Distance updated successfully`
  String get distanceUpdatedSuccessfully {
    return Intl.message(
      'Distance updated successfully',
      name: 'distanceUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Update distance`
  String get updateDistance {
    return Intl.message(
      'Update distance',
      name: 'updateDistance',
      desc: '',
      args: [],
    );
  }

  /// `Orders exceed geographical range`
  String get ordersExceedGeographicalRange {
    return Intl.message(
      'Orders exceed geographical range',
      name: 'ordersExceedGeographicalRange',
      desc: '',
      args: [],
    );
  }

  /// `Total extra distance`
  String get totalExtraDistance {
    return Intl.message(
      'Total extra distance',
      name: 'totalExtraDistance',
      desc: '',
      args: [],
    );
  }

  /// `Captain offer`
  String get captainOffer {
    return Intl.message(
      'Captain offer',
      name: 'captainOffer',
      desc: '',
      args: [],
    );
  }

  /// `Active Offer`
  String get activeOffer {
    return Intl.message(
      'Active Offer',
      name: 'activeOffer',
      desc: '',
      args: [],
    );
  }

  /// `Inactive offer`
  String get unActiveOffer {
    return Intl.message(
      'Inactive offer',
      name: 'unActiveOffer',
      desc: '',
      args: [],
    );
  }

  /// `Please remove order price after setting payment method to credit`
  String get orderPriceOnCreditWarning {
    return Intl.message(
      'Please remove order price after setting payment method to credit',
      name: 'orderPriceOnCreditWarning',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Here you need to confirm if you received order cost from captain or not`
  String get ordersCashHint {
    return Intl.message(
      'Here you need to confirm if you received order cost from captain or not',
      name: 'ordersCashHint',
      desc: '',
      args: [],
    );
  }

  /// `Orders cash`
  String get ordersCash {
    return Intl.message(
      'Orders cash',
      name: 'ordersCash',
      desc: '',
      args: [],
    );
  }

  /// `Confirm order cash answer`
  String get confirmOrderCashAnswer {
    return Intl.message(
      'Confirm order cash answer',
      name: 'confirmOrderCashAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Captains offer`
  String get captainsOffer {
    return Intl.message(
      'Captains offer',
      name: 'captainsOffer',
      desc: '',
      args: [],
    );
  }

  /// `Required to pay`
  String get requiredToPay {
    return Intl.message(
      'Required to pay',
      name: 'requiredToPay',
      desc: '',
      args: [],
    );
  }

  /// `Left to pay`
  String get leftToPay {
    return Intl.message(
      'Left to pay',
      name: 'leftToPay',
      desc: '',
      args: [],
    );
  }

  /// `Package type`
  String get packageType {
    return Intl.message(
      'Package type',
      name: 'packageType',
      desc: '',
      args: [],
    );
  }

  /// `On order`
  String get packageTypeOnOrder {
    return Intl.message(
      'On order',
      name: 'packageTypeOnOrder',
      desc: '',
      args: [],
    );
  }

  /// `Regular`
  String get packageTypeRegular {
    return Intl.message(
      'Regular',
      name: 'packageTypeRegular',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm if you receive order cost from captain please answer with yes or no`
  String get confirmingIfReceiveOrderCost {
    return Intl.message(
      'Please confirm if you receive order cost from captain please answer with yes or no',
      name: 'confirmingIfReceiveOrderCost',
      desc: '',
      args: [],
    );
  }

  /// `Your number start with zero please remove it and try again`
  String get yourNumberStartWithZero {
    return Intl.message(
      'Your number start with zero please remove it and try again',
      name: 'yourNumberStartWithZero',
      desc: '',
      args: [],
    );
  }

  /// `Confirm receive order cash`
  String get confirmOrderCash {
    return Intl.message(
      'Confirm receive order cash',
      name: 'confirmOrderCash',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message(
      'Remember me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Code sent to your device`
  String get codeSendToYou {
    return Intl.message(
      'Code sent to your device',
      name: 'codeSendToYou',
      desc: '',
      args: [],
    );
  }

  /// `Enter verification code`
  String get enterCodeSentToYou {
    return Intl.message(
      'Enter verification code',
      name: 'enterCodeSentToYou',
      desc: '',
      args: [],
    );
  }

  /// `You can resend verification after`
  String get youCanResendAfter {
    return Intl.message(
      'You can resend verification after',
      name: 'youCanResendAfter',
      desc: '',
      args: [],
    );
  }

  /// `Here you can find saved credentials `
  String get credentialsBagHint {
    return Intl.message(
      'Here you can find saved credentials ',
      name: 'credentialsBagHint',
      desc: '',
      args: [],
    );
  }

  /// `Chat room order`
  String get chatRoomOrder {
    return Intl.message(
      'Chat room order',
      name: 'chatRoomOrder',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing chat rooms`
  String get onGoingOrderChatRooms {
    return Intl.message(
      'Ongoing chat rooms',
      name: 'onGoingOrderChatRooms',
      desc: '',
      args: [],
    );
  }

  /// `This order may take some extra time to be delivered due prayer period`
  String get prayerMessage {
    return Intl.message(
      'This order may take some extra time to be delivered due prayer period',
      name: 'prayerMessage',
      desc: '',
      args: [],
    );
  }

  /// `Quick fillUp`
  String get quickFillUp {
    return Intl.message(
      'Quick fillUp',
      name: 'quickFillUp',
      desc: '',
      args: [],
    );
  }

  /// `Total unpaid (cash orders)`
  String get unpaidOrders {
    return Intl.message(
      'Total unpaid (cash orders)',
      name: 'unpaidOrders',
      desc: '',
      args: [],
    );
  }

  /// `press for details`
  String get pressHereDetails {
    return Intl.message(
      'press for details',
      name: 'pressHereDetails',
      desc: '',
      args: [],
    );
  }

  /// `order & delivery cost`
  String get orderCostAndDelivery {
    return Intl.message(
      'order & delivery cost',
      name: 'orderCostAndDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Delivery only`
  String get deliveryOnly {
    return Intl.message(
      'Delivery only',
      name: 'deliveryOnly',
      desc: '',
      args: [],
    );
  }

  /// `Cost type`
  String get costType {
    return Intl.message(
      'Cost type',
      name: 'costType',
      desc: '',
      args: [],
    );
  }

  /// `Problem in updating the order`
  String get problemUpdatingOrder {
    return Intl.message(
      'Problem in updating the order',
      name: 'problemUpdatingOrder',
      desc: '',
      args: [],
    );
  }

  /// `order is either ongoing or delivered`
  String get orderIsEitherOngoingOrDelivered {
    return Intl.message(
      'order is either ongoing or delivered',
      name: 'orderIsEitherOngoingOrDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Wrong order type`
  String get wrongOrderType {
    return Intl.message(
      'Wrong order type',
      name: 'wrongOrderType',
      desc: '',
      args: [],
    );
  }

  /// `Order already has been canceled`
  String get orderAlreadyCancelled {
    return Intl.message(
      'Order already has been canceled',
      name: 'orderAlreadyCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Order not found`
  String get orderNotFound {
    return Intl.message(
      'Order not found',
      name: 'orderNotFound',
      desc: '',
      args: [],
    );
  }

  /// `your balance`
  String get yourBalance {
    return Intl.message(
      'your balance',
      name: 'yourBalance',
      desc: '',
      args: [],
    );
  }

  /// `id`
  String get id {
    return Intl.message(
      'id',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `your value must be greater than 0`
  String get valueMustBeGreaterThanZero {
    return Intl.message(
      'your value must be greater than 0',
      name: 'valueMustBeGreaterThanZero',
      desc: '',
      args: [],
    );
  }

  /// `unlimited orders`
  String get unLimitedOrders {
    return Intl.message(
      'unlimited orders',
      name: 'unLimitedOrders',
      desc: '',
      args: [],
    );
  }

  /// `go to offers`
  String get goToOffers {
    return Intl.message(
      'go to offers',
      name: 'goToOffers',
      desc: '',
      args: [],
    );
  }

  /// `distance has been edited by admin\ntap to more details`
  String get distanceEditedByAdmin {
    return Intl.message(
      'distance has been edited by admin\ntap to more details',
      name: 'distanceEditedByAdmin',
      desc: '',
      args: [],
    );
  }

  /// `distance updated`
  String get distanceUpdated {
    return Intl.message(
      'distance updated',
      name: 'distanceUpdated',
      desc: '',
      args: [],
    );
  }

  /// `admin notes:`
  String get adminNotes {
    return Intl.message(
      'admin notes:',
      name: 'adminNotes',
      desc: '',
      args: [],
    );
  }

  /// `ok`
  String get ok {
    return Intl.message(
      'ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueWord {
    return Intl.message(
      'Continue',
      name: 'continueWord',
      desc: '',
      args: [],
    );
  }

  /// `you can contact with direct support for more detail's`
  String get youCanContactWithDirectSupportForMoreDetails {
    return Intl.message(
      'you can contact with direct support for more detail\'s',
      name: 'youCanContactWithDirectSupportForMoreDetails',
      desc: '',
      args: [],
    );
  }

  /// `Ads & offers`
  String get adsAndOffers {
    return Intl.message(
      'Ads & offers',
      name: 'adsAndOffers',
      desc: '',
      args: [],
    );
  }

  /// `Store fee`
  String get storeFee {
    return Intl.message(
      'Store fee',
      name: 'storeFee',
      desc: '',
      args: [],
    );
  }

  /// `use your current location`
  String get useYourCurrentLocation {
    return Intl.message(
      'use your current location',
      name: 'useYourCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `enter your store name`
  String get enterYourStoreName {
    return Intl.message(
      'enter your store name',
      name: 'enterYourStoreName',
      desc: '',
      args: [],
    );
  }

  /// `start work`
  String get startWork {
    return Intl.message(
      'start work',
      name: 'startWork',
      desc: '',
      args: [],
    );
  }

  /// `please select your store location`
  String get pleaseSelectYourStoreLocation {
    return Intl.message(
      'please select your store location',
      name: 'pleaseSelectYourStoreLocation',
      desc: '',
      args: [],
    );
  }

  /// `welcome`
  String get welcome {
    return Intl.message(
      'welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `get it now`
  String get getItNow {
    return Intl.message(
      'get it now',
      name: 'getItNow',
      desc: '',
      args: [],
    );
  }

  /// `to be payed`
  String get toBePayed {
    return Intl.message(
      'to be payed',
      name: 'toBePayed',
      desc: '',
      args: [],
    );
  }

  /// `number of order`
  String get numberOfOrder {
    return Intl.message(
      'number of order',
      name: 'numberOfOrder',
      desc: '',
      args: [],
    );
  }

  /// `pay now`
  String get payNow {
    return Intl.message(
      'pay now',
      name: 'payNow',
      desc: '',
      args: [],
    );
  }

  /// `plan details`
  String get planDetails {
    return Intl.message(
      'plan details',
      name: 'planDetails',
      desc: '',
      args: [],
    );
  }

  /// `opened price order`
  String get openedPrice {
    return Intl.message(
      'opened price order',
      name: 'openedPrice',
      desc: '',
      args: [],
    );
  }

  /// `subscription is active`
  String get subscriptionIsActivate {
    return Intl.message(
      'subscription is active',
      name: 'subscriptionIsActivate',
      desc: '',
      args: [],
    );
  }

  /// `subscription is not active`
  String get subscriptionIsNotActivate {
    return Intl.message(
      'subscription is not active',
      name: 'subscriptionIsNotActivate',
      desc: '',
      args: [],
    );
  }

  /// `you have not exceeded the limit yet`
  String get youHaveNotExceededTheLimitYet {
    return Intl.message(
      'you have not exceeded the limit yet',
      name: 'youHaveNotExceededTheLimitYet',
      desc: '',
      args: [],
    );
  }

  /// `have exceeded the limit`
  String get youHaveExceededTheLimit {
    return Intl.message(
      'have exceeded the limit',
      name: 'youHaveExceededTheLimit',
      desc: '',
      args: [],
    );
  }

  /// `every 1 km`
  String get every1KM {
    return Intl.message(
      'every 1 km',
      name: 'every1KM',
      desc: '',
      args: [],
    );
  }

  /// `you have to pay when you reach {limit} sar`
  String youHaveToPayWhen(String limit) {
    return Intl.message(
      'you have to pay when you reach $limit sar',
      name: 'youHaveToPayWhen',
      desc: 'The conventional newborn programmer greeting',
      args: [limit],
    );
  }

  /// `Congratulations, you have received a welcome package for delivering one order for only 2.99 riyal`
  String get welcomePlanOffer {
    return Intl.message(
      'Congratulations, you have received a welcome package for delivering one order for only 2.99 riyal',
      name: 'welcomePlanOffer',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations, you have received a welcome package for delivering one order for free`
  String get welcomePlanOfferWithoutPayment {
    return Intl.message(
      'Congratulations, you have received a welcome package for delivering one order for free',
      name: 'welcomePlanOfferWithoutPayment',
      desc: '',
      args: [],
    );
  }

  /// `current cycle details`
  String get currentCycleDetails {
    return Intl.message(
      'current cycle details',
      name: 'currentCycleDetails',
      desc: '',
      args: [],
    );
  }

  /// `package start date`
  String get packageStartDate {
    return Intl.message(
      'package start date',
      name: 'packageStartDate',
      desc: '',
      args: [],
    );
  }

  /// `there is no user with this number`
  String get thereIsNoUserWithThisNumber {
    return Intl.message(
      'there is no user with this number',
      name: 'thereIsNoUserWithThisNumber',
      desc: '',
      args: [],
    );
  }

  /// `payment process completed successfully`
  String get paymentSuccess {
    return Intl.message(
      'payment process completed successfully',
      name: 'paymentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `you dont have to pay yet`
  String get youDontHaveToPayYet {
    return Intl.message(
      'you dont have to pay yet',
      name: 'youDontHaveToPayYet',
      desc: '',
      args: [],
    );
  }

  /// `no payment had been made`
  String get noPaymentHadBeenMade {
    return Intl.message(
      'no payment had been made',
      name: 'noPaymentHadBeenMade',
      desc: '',
      args: [],
    );
  }

  /// `package not exist`
  String get packageNotExist {
    return Intl.message(
      'package not exist',
      name: 'packageNotExist',
      desc: '',
      args: [],
    );
  }

  /// `subscribe not exist`
  String get subscribeNotExist {
    return Intl.message(
      'subscribe not exist',
      name: 'subscribeNotExist',
      desc: '',
      args: [],
    );
  }

  /// `store owner profile not exist`
  String get storeOwnerProfileNotExist {
    return Intl.message(
      'store owner profile not exist',
      name: 'storeOwnerProfileNotExist',
      desc: '',
      args: [],
    );
  }

  /// `payment information`
  String get paymentInfo {
    return Intl.message(
      'payment information',
      name: 'paymentInfo',
      desc: '',
      args: [],
    );
  }

  /// `you have to fill the form first`
  String get youHaveToFillTheFormFirst {
    return Intl.message(
      'you have to fill the form first',
      name: 'youHaveToFillTheFormFirst',
      desc: '',
      args: [],
    );
  }

  /// `you have financial payment to pay\nyou can pay fot it in the financial account screen`
  String get youHaveFinancialPaymentToMade {
    return Intl.message(
      'you have financial payment to pay\nyou can pay fot it in the financial account screen',
      name: 'youHaveFinancialPaymentToMade',
      desc: '',
      args: [],
    );
  }

  /// `You have used up the entire welcome pack`
  String get YouHaveUsedUpTheEntireWelcomePack {
    return Intl.message(
      'You have used up the entire welcome pack',
      name: 'YouHaveUsedUpTheEntireWelcomePack',
      desc: '',
      args: [],
    );
  }

  /// `The cost will now be calculated based on the current business plan:\nThe opening asking price is 12 riyals\nCost per 1 km. 1 riyal`
  String get theCostWillBe {
    return Intl.message(
      'The cost will now be calculated based on the current business plan:\nThe opening asking price is 12 riyals\nCost per 1 km. 1 riyal',
      name: 'theCostWillBe',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
