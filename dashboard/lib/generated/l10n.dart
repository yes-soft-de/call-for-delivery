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

  /// `Book a car`
  String get bookACar {
    return Intl.message(
      'Book a car',
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

  /// `Car`
  String get car {
    return Intl.message(
      'Car',
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

  /// `Order is finished`
  String get orderIsFinished {
    return Intl.message(
      'Order is finished',
      name: 'orderIsFinished',
      desc: '',
      args: [],
    );
  }

  /// `Orders Finished`
  String get ordersFinished {
    return Intl.message(
      'Orders Finished',
      name: 'ordersFinished',
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

  /// `Please Complete the Form`
  String get pleaseCompleteTheForm {
    return Intl.message(
      'Please Complete the Form',
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

  /// `Current Balance:`
  String get currentBalance {
    return Intl.message(
      'Current Balance:',
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

  /// `Active Cars`
  String get activeCars {
    return Intl.message(
      'Active Cars',
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

  /// `No Image`
  String get noImage {
    return Intl.message(
      'No Image',
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

  /// `The number of cars unknown`
  String get unknownNumberOfCar {
    return Intl.message(
      'The number of cars unknown',
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

  /// `This store is not active yet`
  String get inactive {
    return Intl.message(
      'This store is not active yet',
      name: 'inactive',
      desc: '',
      args: [],
    );
  }

  /// `You reach your limit of orders you can renew your subscription from settings`
  String get outOforders {
    return Intl.message(
      'You reach your limit of orders you can renew your subscription from settings',
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

  /// `There is no car available please wait your ongoing orders to finish`
  String get outOfCars {
    return Intl.message(
      'There is no car available please wait your ongoing orders to finish',
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

  /// `Please press again to exit`
  String get exitWarning {
    return Intl.message(
      'Please press again to exit',
      name: 'exitWarning',
      desc: '',
      args: [],
    );
  }

  /// `Completed Orders`
  String get countCompletedOrders {
    return Intl.message(
      'Completed Orders',
      name: 'countCompletedOrders',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing Orders`
  String get countOngoingOrders {
    return Intl.message(
      'Ongoing Orders',
      name: 'countOngoingOrders',
      desc: '',
      args: [],
    );
  }

  /// `Clients Count`
  String get countClients {
    return Intl.message(
      'Clients Count',
      name: 'countClients',
      desc: '',
      args: [],
    );
  }

  /// `Captains Count`
  String get countCaptains {
    return Intl.message(
      'Captains Count',
      name: 'countCaptains',
      desc: '',
      args: [],
    );
  }

  /// `Products Count`
  String get countProducts {
    return Intl.message(
      'Products Count',
      name: 'countProducts',
      desc: '',
      args: [],
    );
  }

  /// `Stores Count`
  String get countStores {
    return Intl.message(
      'Stores Count',
      name: 'countStores',
      desc: '',
      args: [],
    );
  }

  /// `Today Order`
  String get countTodayOrder {
    return Intl.message(
      'Today Order',
      name: 'countTodayOrder',
      desc: '',
      args: [],
    );
  }

  /// `Store Balance`
  String get storeBalance {
    return Intl.message(
      'Store Balance',
      name: 'storeBalance',
      desc: '',
      args: [],
    );
  }

  /// `Payments for store`
  String get paymentsForStore {
    return Intl.message(
      'Payments for store',
      name: 'paymentsForStore',
      desc: '',
      args: [],
    );
  }

  /// `Amount owed for store`
  String get remainingAmountForStore {
    return Intl.message(
      'Amount owed for store',
      name: 'remainingAmountForStore',
      desc: '',
      args: [],
    );
  }

  /// `Total payments for store`
  String get sumPaymentsForStore {
    return Intl.message(
      'Total payments for store',
      name: 'sumPaymentsForStore',
      desc: '',
      args: [],
    );
  }

  /// `Store Availability`
  String get storeAvailable {
    return Intl.message(
      'Store Availability',
      name: 'storeAvailable',
      desc: '',
      args: [],
    );
  }

  /// ` Inactive Stores`
  String get storesInActive {
    return Intl.message(
      ' Inactive Stores',
      name: 'storesInActive',
      desc: '',
      args: [],
    );
  }

  /// `Stores List`
  String get storesList {
    return Intl.message(
      'Stores List',
      name: 'storesList',
      desc: '',
      args: [],
    );
  }

  /// `Add Stores`
  String get addStore {
    return Intl.message(
      'Add Stores',
      name: 'addStore',
      desc: '',
      args: [],
    );
  }

  /// `Update store`
  String get updateStore {
    return Intl.message(
      'Update store',
      name: 'updateStore',
      desc: '',
      args: [],
    );
  }

  /// `Search for store`
  String get searchForStore {
    return Intl.message(
      'Search for store',
      name: 'searchForStore',
      desc: '',
      args: [],
    );
  }

  /// `Store Shift`
  String get workTime {
    return Intl.message(
      'Store Shift',
      name: 'workTime',
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

  /// `Store Info`
  String get storeInfo {
    return Intl.message(
      'Store Info',
      name: 'storeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Store Image`
  String get storeImage {
    return Intl.message(
      'Store Image',
      name: 'storeImage',
      desc: '',
      args: [],
    );
  }

  /// `Store Created Successfully`
  String get storeCreatedSuccessfully {
    return Intl.message(
      'Store Created Successfully',
      name: 'storeCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Store Updated Successfully`
  String get storeUpdatedSuccessfully {
    return Intl.message(
      'Store Updated Successfully',
      name: 'storeUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `This store is active`
  String get active {
    return Intl.message(
      'This store is active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `city`
  String get city {
    return Intl.message(
      'city',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Empty Stuff`
  String get emptyStaff {
    return Intl.message(
      'Empty Stuff',
      name: 'emptyStaff',
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

  /// `Packages categories's`
  String get packageCategory {
    return Intl.message(
      'Packages categories\'s',
      name: 'packageCategory',
      desc: '',
      args: [],
    );
  }

  /// `Add category`
  String get addCategory {
    return Intl.message(
      'Add category',
      name: 'addCategory',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Category name`
  String get categoryName {
    return Intl.message(
      'Category name',
      name: 'categoryName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Category Updated Successfully`
  String get categoryUpdatedSuccessfully {
    return Intl.message(
      'Category Updated Successfully',
      name: 'categoryUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Package info`
  String get packageInfo {
    return Intl.message(
      'Package info',
      name: 'packageInfo',
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

  /// `Car count`
  String get carCount {
    return Intl.message(
      'Car count',
      name: 'carCount',
      desc: '',
      args: [],
    );
  }

  /// `Order count`
  String get orderCount {
    return Intl.message(
      'Order count',
      name: 'orderCount',
      desc: '',
      args: [],
    );
  }

  /// `Package name`
  String get packageName {
    return Intl.message(
      'Package name',
      name: 'packageName',
      desc: '',
      args: [],
    );
  }

  /// `The number of days of validity of the package`
  String get dayCount {
    return Intl.message(
      'The number of days of validity of the package',
      name: 'dayCount',
      desc: '',
      args: [],
    );
  }

  /// `Packages`
  String get packages {
    return Intl.message(
      'Packages',
      name: 'packages',
      desc: '',
      args: [],
    );
  }

  /// `Add package`
  String get addPackage {
    return Intl.message(
      'Add package',
      name: 'addPackage',
      desc: '',
      args: [],
    );
  }

  /// `Package Added successfully`
  String get addPackageSuccessfully {
    return Intl.message(
      'Package Added successfully',
      name: 'addPackageSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Package updated successfully`
  String get updatePackageSuccessfully {
    return Intl.message(
      'Package updated successfully',
      name: 'updatePackageSuccessfully',
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

  /// `Company profile created successfully`
  String get companyProfileCreatedSuccessfully {
    return Intl.message(
      'Company profile created successfully',
      name: 'companyProfileCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Company profile updated successfully`
  String get companyProfileUpdatedSuccessfully {
    return Intl.message(
      'Company profile updated successfully',
      name: 'companyProfileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Company information`
  String get companyInfo {
    return Intl.message(
      'Company information',
      name: 'companyInfo',
      desc: '',
      args: [],
    );
  }

  /// `Phone 2`
  String get phone2 {
    return Intl.message(
      'Phone 2',
      name: 'phone2',
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

  /// `Whatsapp`
  String get whatsapp {
    return Intl.message(
      'Whatsapp',
      name: 'whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Kilometers limit`
  String get kilometerLimt {
    return Intl.message(
      'Kilometers limit',
      name: 'kilometerLimt',
      desc: '',
      args: [],
    );
  }

  /// `bonus on max limit`
  String get kilometerLimtMax {
    return Intl.message(
      'bonus on max limit',
      name: 'kilometerLimtMax',
      desc: '',
      args: [],
    );
  }

  /// `bonus on min limit`
  String get kilometerLimtMin {
    return Intl.message(
      'bonus on min limit',
      name: 'kilometerLimtMin',
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

  /// `Choose Branch`
  String get chooseBranch {
    return Intl.message(
      'Choose Branch',
      name: 'chooseBranch',
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

  /// `Add Note`
  String get addNote {
    return Intl.message(
      'Add Note',
      name: 'addNote',
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

  /// `Send to`
  String get sendTo {
    return Intl.message(
      'Send to',
      name: 'sendTo',
      desc: '',
      args: [],
    );
  }

  /// `Captains`
  String get captains {
    return Intl.message(
      'Captains',
      name: 'captains',
      desc: '',
      args: [],
    );
  }

  /// `Updates`
  String get notice {
    return Intl.message(
      'Updates',
      name: 'notice',
      desc: '',
      args: [],
    );
  }

  /// `Company finance`
  String get companyFinance {
    return Intl.message(
      'Company finance',
      name: 'companyFinance',
      desc: '',
      args: [],
    );
  }

  /// `Contact info`
  String get contactInfo {
    return Intl.message(
      'Contact info',
      name: 'contactInfo',
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

  /// `Add offer`
  String get addOffer {
    return Intl.message(
      'Add offer',
      name: 'addOffer',
      desc: '',
      args: [],
    );
  }

  /// `offer updated successfully`
  String get updateOfferSuccessfully {
    return Intl.message(
      'offer updated successfully',
      name: 'updateOfferSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `offer added successfully`
  String get addOfferSuccessfully {
    return Intl.message(
      'offer added successfully',
      name: 'addOfferSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Stores Active`
  String get storesActive {
    return Intl.message(
      'Stores Active',
      name: 'storesActive',
      desc: '',
      args: [],
    );
  }

  /// `Orders count`
  String get allOrdersCount {
    return Intl.message(
      'Orders count',
      name: 'allOrdersCount',
      desc: '',
      args: [],
    );
  }

  /// `Inactive Captains`
  String get inActiveCaptains {
    return Intl.message(
      'Inactive Captains',
      name: 'inActiveCaptains',
      desc: '',
      args: [],
    );
  }

  /// `Salary`
  String get salary {
    return Intl.message(
      'Salary',
      name: 'salary',
      desc: '',
      args: [],
    );
  }

  /// `Account Status`
  String get captainStatus {
    return Intl.message(
      'Account Status',
      name: 'captainStatus',
      desc: '',
      args: [],
    );
  }

  /// `Online Status`
  String get status {
    return Intl.message(
      'Online Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Captain Activated Successfully`
  String get captainActivated {
    return Intl.message(
      'Captain Activated Successfully',
      name: 'captainActivated',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get captainStateActive {
    return Intl.message(
      'Active',
      name: 'captainStateActive',
      desc: '',
      args: [],
    );
  }

  /// `InActive`
  String get captainStateInactive {
    return Intl.message(
      'InActive',
      name: 'captainStateInactive',
      desc: '',
      args: [],
    );
  }

  /// `Search for captain`
  String get searchForCaptain {
    return Intl.message(
      'Search for captain',
      name: 'searchForCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Mechanich Licence`
  String get mechanichLicence {
    return Intl.message(
      'Mechanich Licence',
      name: 'mechanichLicence',
      desc: '',
      args: [],
    );
  }

  /// `Identity`
  String get identity {
    return Intl.message(
      'Identity',
      name: 'identity',
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

  /// `Create Date`
  String get createDate {
    return Intl.message(
      'Create Date',
      name: 'createDate',
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

  /// `Captain updated successfully`
  String get captainUpdatedSuccessfully {
    return Intl.message(
      'Captain updated successfully',
      name: 'captainUpdatedSuccessfully',
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

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
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

  /// `Distance`
  String get distance {
    return Intl.message(
      'Distance',
      name: 'distance',
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

  /// `Order Image`
  String get orderImage {
    return Intl.message(
      'Order Image',
      name: 'orderImage',
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

  /// `Km`
  String get km {
    return Intl.message(
      'Km',
      name: 'km',
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

  /// `Captain not arrived`
  String get captainNotArrived {
    return Intl.message(
      'Captain not arrived',
      name: 'captainNotArrived',
      desc: '',
      args: [],
    );
  }

  /// `Payment created successfully`
  String get paymentSuccessfully {
    return Intl.message(
      'Payment created successfully',
      name: 'paymentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Payment updated successfully`
  String get updatePaymentSuccessfully {
    return Intl.message(
      'Payment updated successfully',
      name: 'updatePaymentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Store payments`
  String get storePayments {
    return Intl.message(
      'Store payments',
      name: 'storePayments',
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

  /// `Payment deleted successfully`
  String get paymentsDeletedSuccessfully {
    return Intl.message(
      'Payment deleted successfully',
      name: 'paymentsDeletedSuccessfully',
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

  /// `Code`
  String get countryCode {
    return Intl.message(
      'Code',
      name: 'countryCode',
      desc: '',
      args: [],
    );
  }

  /// `Captain not arrived to store`
  String get captainNotArrivedToStore {
    return Intl.message(
      'Captain not arrived to store',
      name: 'captainNotArrivedToStore',
      desc: '',
      args: [],
    );
  }

  /// `Captain Finance`
  String get captainFinance {
    return Intl.message(
      'Captain Finance',
      name: 'captainFinance',
      desc: '',
      args: [],
    );
  }

  /// `Finance by orders`
  String get financeByOrders {
    return Intl.message(
      'Finance by orders',
      name: 'financeByOrders',
      desc: '',
      args: [],
    );
  }

  /// `Finance by hours`
  String get financeByHours {
    return Intl.message(
      'Finance by hours',
      name: 'financeByHours',
      desc: '',
      args: [],
    );
  }

  /// `Finance on order`
  String get financeCountOrder {
    return Intl.message(
      'Finance on order',
      name: 'financeCountOrder',
      desc: '',
      args: [],
    );
  }

  /// `Orders in month`
  String get bounceCountOrdersInMonth {
    return Intl.message(
      'Orders in month',
      name: 'bounceCountOrdersInMonth',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Minimum kilometers`
  String get countKilometersFrom {
    return Intl.message(
      'Minimum kilometers',
      name: 'countKilometersFrom',
      desc: '',
      args: [],
    );
  }

  /// `Max kilometers`
  String get countKilometersTo {
    return Intl.message(
      'Max kilometers',
      name: 'countKilometersTo',
      desc: '',
      args: [],
    );
  }

  /// `Add work plan`
  String get addWorkPackage {
    return Intl.message(
      'Add work plan',
      name: 'addWorkPackage',
      desc: '',
      args: [],
    );
  }

  /// `e.g :`
  String get eg {
    return Intl.message(
      'e.g :',
      name: 'eg',
      desc: '',
      args: [],
    );
  }

  /// `Count Hours`
  String get countHours {
    return Intl.message(
      'Count Hours',
      name: 'countHours',
      desc: '',
      args: [],
    );
  }

  /// `Compensation for every order`
  String get compensationForEveryOrder {
    return Intl.message(
      'Compensation for every order',
      name: 'compensationForEveryOrder',
      desc: '',
      args: [],
    );
  }

  /// `Count order in month`
  String get countOrdersInMonth {
    return Intl.message(
      'Count order in month',
      name: 'countOrdersInMonth',
      desc: '',
      args: [],
    );
  }

  /// `Month compensation`
  String get monthCompensation {
    return Intl.message(
      'Month compensation',
      name: 'monthCompensation',
      desc: '',
      args: [],
    );
  }

  /// `Bounce max count orders in month`
  String get bounceMaxCountOrdersInMonth {
    return Intl.message(
      'Bounce max count orders in month',
      name: 'bounceMaxCountOrdersInMonth',
      desc: '',
      args: [],
    );
  }

  /// `Bounce min count orders in month`
  String get bounceMinCountOrdersInMonth {
    return Intl.message(
      'Bounce min count orders in month',
      name: 'bounceMinCountOrdersInMonth',
      desc: '',
      args: [],
    );
  }

  /// `Captain Payments`
  String get captainPayments {
    return Intl.message(
      'Captain Payments',
      name: 'captainPayments',
      desc: '',
      args: [],
    );
  }

  /// `inActive Supplier`
  String get inActiveSupplier {
    return Intl.message(
      'inActive Supplier',
      name: 'inActiveSupplier',
      desc: '',
      args: [],
    );
  }

  /// `Suppliers`
  String get suppliers {
    return Intl.message(
      'Suppliers',
      name: 'suppliers',
      desc: '',
      args: [],
    );
  }

  /// `Supplier Categories`
  String get suppliersCategories {
    return Intl.message(
      'Supplier Categories',
      name: 'suppliersCategories',
      desc: '',
      args: [],
    );
  }

  /// `Category image`
  String get categoryImage {
    return Intl.message(
      'Category image',
      name: 'categoryImage',
      desc: '',
      args: [],
    );
  }

  /// `Supplier updated successfully`
  String get supplierUpdatedSuccessfully {
    return Intl.message(
      'Supplier updated successfully',
      name: 'supplierUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Count orders`
  String get countOrders {
    return Intl.message(
      'Count orders',
      name: 'countOrders',
      desc: '',
      args: [],
    );
  }

  /// `Count orders max from nineteen`
  String get countOrdersMaxFromNineteen {
    return Intl.message(
      'Count orders max from nineteen',
      name: 'countOrdersMaxFromNineteen',
      desc: '',
      args: [],
    );
  }

  /// `Profit`
  String get financialDues {
    return Intl.message(
      'Profit',
      name: 'financialDues',
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

  /// `Extra orders than required`
  String get countOverOrdersThanRequired {
    return Intl.message(
      'Extra orders than required',
      name: 'countOverOrdersThanRequired',
      desc: '',
      args: [],
    );
  }

  /// `Monthly target`
  String get monthTargetSuccess {
    return Intl.message(
      'Monthly target',
      name: 'monthTargetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Count orders completed`
  String get countOrdersCompleted {
    return Intl.message(
      'Count orders completed',
      name: 'countOrdersCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Date Financial cycle ends`
  String get dateFinancialCycleEnds {
    return Intl.message(
      'Date Financial cycle ends',
      name: 'dateFinancialCycleEnds',
      desc: '',
      args: [],
    );
  }

  /// `Achieved`
  String get achieved {
    return Intl.message(
      'Achieved',
      name: 'achieved',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get failed {
    return Intl.message(
      'Failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `You cannot choose plan right now , please try again`
  String get youCannotChoosePlan {
    return Intl.message(
      'You cannot choose plan right now , please try again',
      name: 'youCannotChoosePlan',
      desc: '',
      args: [],
    );
  }

  /// `Here we are showing your balance status`
  String get BalanceHint {
    return Intl.message(
      'Here we are showing your balance status',
      name: 'BalanceHint',
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

  /// `Captain total category`
  String get captainTotalCategory {
    return Intl.message(
      'Captain total category',
      name: 'captainTotalCategory',
      desc: '',
      args: [],
    );
  }

  /// `Count orders completed`
  String get contOrderCompleted {
    return Intl.message(
      'Count orders completed',
      name: 'contOrderCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Count orders left`
  String get countOfOrdersLeft {
    return Intl.message(
      'Count orders left',
      name: 'countOfOrdersLeft',
      desc: '',
      args: [],
    );
  }

  /// `Update date`
  String get updateDate {
    return Intl.message(
      'Update date',
      name: 'updateDate',
      desc: '',
      args: [],
    );
  }

  /// `Inactive plan`
  String get inactivePlan {
    return Intl.message(
      'Inactive plan',
      name: 'inactivePlan',
      desc: '',
      args: [],
    );
  }

  /// `Updated by`
  String get updatedBy {
    return Intl.message(
      'Updated by',
      name: 'updatedBy',
      desc: '',
      args: [],
    );
  }

  /// `Refuse`
  String get refuse {
    return Intl.message(
      'Refuse',
      name: 'refuse',
      desc: '',
      args: [],
    );
  }

  /// `Finance request`
  String get FinanceRequest {
    return Intl.message(
      'Finance request',
      name: 'FinanceRequest',
      desc: '',
      args: [],
    );
  }

  /// `Activated plan`
  String get activatedPlan {
    return Intl.message(
      'Activated plan',
      name: 'activatedPlan',
      desc: '',
      args: [],
    );
  }

  /// `Amount for store`
  String get amountForStore {
    return Intl.message(
      'Amount for store',
      name: 'amountForStore',
      desc: '',
      args: [],
    );
  }

  /// `Finance dues cycle`
  String get financialDuesCycle {
    return Intl.message(
      'Finance dues cycle',
      name: 'financialDuesCycle',
      desc: '',
      args: [],
    );
  }

  /// `Captain dues`
  String get sumCaptainFinancialDues {
    return Intl.message(
      'Captain dues',
      name: 'sumCaptainFinancialDues',
      desc: '',
      args: [],
    );
  }

  /// `Payments to captain`
  String get sumPaymentsToCaptainFinance {
    return Intl.message(
      'Payments to captain',
      name: 'sumPaymentsToCaptainFinance',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get financeStatus {
    return Intl.message(
      'Status',
      name: 'financeStatus',
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

  /// `Cycle start`
  String get cycleStart {
    return Intl.message(
      'Cycle start',
      name: 'cycleStart',
      desc: '',
      args: [],
    );
  }

  /// `Cycle end`
  String get cycleEnd {
    return Intl.message(
      'Cycle end',
      name: 'cycleEnd',
      desc: '',
      args: [],
    );
  }

  /// `Financial dues cycles`
  String get financialDuesCycles {
    return Intl.message(
      'Financial dues cycles',
      name: 'financialDuesCycles',
      desc: '',
      args: [],
    );
  }

  /// `Current cycle`
  String get currentFinancialDuesCycle {
    return Intl.message(
      'Current cycle',
      name: 'currentFinancialDuesCycle',
      desc: '',
      args: [],
    );
  }

  /// `Financial dues details`
  String get financialDuesDetails {
    return Intl.message(
      'Financial dues details',
      name: 'financialDuesDetails',
      desc: '',
      args: [],
    );
  }

  /// `Finance order status`
  String get financeStoreStatus {
    return Intl.message(
      'Finance order status',
      name: 'financeStoreStatus',
      desc: '',
      args: [],
    );
  }

  /// `Account balance`
  String get accountBalance {
    return Intl.message(
      'Account balance',
      name: 'accountBalance',
      desc: '',
      args: [],
    );
  }

  /// `In these windows we are showing you current financial details for cycle date`
  String get currentFinancialCycleHint {
    return Intl.message(
      'In these windows we are showing you current financial details for cycle date',
      name: 'currentFinancialCycleHint',
      desc: '',
      args: [],
    );
  }

  /// `Payment To Captain`
  String get paymentToCaptain {
    return Intl.message(
      'Payment To Captain',
      name: 'paymentToCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Make Payment`
  String get makePayment {
    return Intl.message(
      'Make Payment',
      name: 'makePayment',
      desc: '',
      args: [],
    );
  }

  /// `Current Cycle`
  String get currentFinancialCycle {
    return Intl.message(
      'Current Cycle',
      name: 'currentFinancialCycle',
      desc: '',
      args: [],
    );
  }

  /// `Delivery cars`
  String get deliveryCars {
    return Intl.message(
      'Delivery cars',
      name: 'deliveryCars',
      desc: '',
      args: [],
    );
  }

  /// `Add cars`
  String get addCars {
    return Intl.message(
      'Add cars',
      name: 'addCars',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Cars Cost`
  String get deliveryCarsCost {
    return Intl.message(
      'Delivery Cars Cost',
      name: 'deliveryCarsCost',
      desc: '',
      args: [],
    );
  }

  /// `Car Model`
  String get carModel {
    return Intl.message(
      'Car Model',
      name: 'carModel',
      desc: '',
      args: [],
    );
  }

  /// `Profit`
  String get profit {
    return Intl.message(
      'Profit',
      name: 'profit',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Dead Line`
  String get deadLine {
    return Intl.message(
      'Dead Line',
      name: 'deadLine',
      desc: '',
      args: [],
    );
  }

  /// `Offer log`
  String get offerLog {
    return Intl.message(
      'Offer log',
      name: 'offerLog',
      desc: '',
      args: [],
    );
  }

  /// `Waiting to accept your offer`
  String get pendingOfferMsg {
    return Intl.message(
      'Waiting to accept your offer',
      name: 'pendingOfferMsg',
      desc: '',
      args: [],
    );
  }

  /// `Store reject your offer`
  String get rejectOfferMsg {
    return Intl.message(
      'Store reject your offer',
      name: 'rejectOfferMsg',
      desc: '',
      args: [],
    );
  }

  /// `Store accept your offer`
  String get acceptOfferMsg {
    return Intl.message(
      'Store accept your offer',
      name: 'acceptOfferMsg',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get confirmed {
    return Intl.message(
      'Confirmed',
      name: 'confirmed',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `Supplier offer`
  String get supplierOffer {
    return Intl.message(
      'Supplier offer',
      name: 'supplierOffer',
      desc: '',
      args: [],
    );
  }

  /// `Bid order`
  String get bidOrder {
    return Intl.message(
      'Bid order',
      name: 'bidOrder',
      desc: '',
      args: [],
    );
  }

  /// `Edit store profile`
  String get editProfile {
    return Intl.message(
      'Edit store profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Manage branch`
  String get manageBranch {
    return Intl.message(
      'Manage branch',
      name: 'manageBranch',
      desc: '',
      args: [],
    );
  }

  /// `Store orders`
  String get storeOrders {
    return Intl.message(
      'Store orders',
      name: 'storeOrders',
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

  /// `Subscription Date`
  String get subscriptionDate {
    return Intl.message(
      'Subscription Date',
      name: 'subscriptionDate',
      desc: '',
      args: [],
    );
  }

  /// `Expiration Data`
  String get expirationData {
    return Intl.message(
      'Expiration Data',
      name: 'expirationData',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Status`
  String get subscriptionStatus {
    return Intl.message(
      'Subscription Status',
      name: 'subscriptionStatus',
      desc: '',
      args: [],
    );
  }

  /// `Package Cost`
  String get packageCost {
    return Intl.message(
      'Package Cost',
      name: 'packageCost',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Inactive`
  String get subscriptionInactive {
    return Intl.message(
      'Subscription Inactive',
      name: 'subscriptionInactive',
      desc: '',
      args: [],
    );
  }

  /// `Expired Subscriptions`
  String get expiredSubscriptions {
    return Intl.message(
      'Expired Subscriptions',
      name: 'expiredSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Finance Subscriptions`
  String get financeSubscriptions {
    return Intl.message(
      'Finance Subscriptions',
      name: 'financeSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Activated`
  String get subscriptionActive {
    return Intl.message(
      'Activated',
      name: 'subscriptionActive',
      desc: '',
      args: [],
    );
  }

  /// `Here you find all your subscriptions financial information with included all payments `
  String get subscriptionsFinanceHint {
    return Intl.message(
      'Here you find all your subscriptions financial information with included all payments ',
      name: 'subscriptionsFinanceHint',
      desc: '',
      args: [],
    );
  }

  /// `Here you find all financial details included in this subscription with date`
  String get subscriptionsFinanceDetailsHint {
    return Intl.message(
      'Here you find all financial details included in this subscription with date',
      name: 'subscriptionsFinanceDetailsHint',
      desc: '',
      args: [],
    );
  }

  /// `Payment From Store`
  String get paymentFromStore {
    return Intl.message(
      'Payment From Store',
      name: 'paymentFromStore',
      desc: '',
      args: [],
    );
  }

  /// `Payments from Company`
  String get sumPaymentsFromCompany {
    return Intl.message(
      'Payments from Company',
      name: 'sumPaymentsFromCompany',
      desc: '',
      args: [],
    );
  }

  /// `Store Dues`
  String get sumAmountStorOwnerDues {
    return Intl.message(
      'Store Dues',
      name: 'sumAmountStorOwnerDues',
      desc: '',
      args: [],
    );
  }

  /// `Payments to captain`
  String get sumPaymentsToCaptain {
    return Intl.message(
      'Payments to captain',
      name: 'sumPaymentsToCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Cash with captain`
  String get sumAmountWithCaptain {
    return Intl.message(
      'Cash with captain',
      name: 'sumAmountWithCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Cash order`
  String get cashOrders {
    return Intl.message(
      'Cash order',
      name: 'cashOrders',
      desc: '',
      args: [],
    );
  }

  /// `Payments To Captain`
  String get paymentsToCaptain {
    return Intl.message(
      'Payments To Captain',
      name: 'paymentsToCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Payments To Store`
  String get paymentsToStore {
    return Intl.message(
      'Payments To Store',
      name: 'paymentsToStore',
      desc: '',
      args: [],
    );
  }

  /// `Supplier profit margin`
  String get supplierProfitMargin {
    return Intl.message(
      'Supplier profit margin',
      name: 'supplierProfitMargin',
      desc: '',
      args: [],
    );
  }

  /// `Store profit margin`
  String get storeProfitMargin {
    return Intl.message(
      'Store profit margin',
      name: 'storeProfitMargin',
      desc: '',
      args: [],
    );
  }

  /// `Payments From Captain`
  String get paymentsFromCaptain {
    return Intl.message(
      'Payments From Captain',
      name: 'paymentsFromCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Order cost to store`
  String get orderCashStatus {
    return Intl.message(
      'Order cost to store',
      name: 'orderCashStatus',
      desc: '',
      args: [],
    );
  }

  /// `Payments From Captain`
  String get sumPaymentsFromCaptain {
    return Intl.message(
      'Payments From Captain',
      name: 'sumPaymentsFromCaptain',
      desc: '',
      args: [],
    );
  }

  /// `In this screen you can see our work planes `
  String get planHint {
    return Intl.message(
      'In this screen you can see our work planes ',
      name: 'planHint',
      desc: '',
      args: [],
    );
  }

  /// `Please choose your plan`
  String get choosePlan {
    return Intl.message(
      'Please choose your plan',
      name: 'choosePlan',
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

  /// `order`
  String get orderWithoutDef {
    return Intl.message(
      'order',
      name: 'orderWithoutDef',
      desc: '',
      args: [],
    );
  }

  /// `You can change captain financial request here`
  String get youCanChangeCaptainFinancialPlan {
    return Intl.message(
      'You can change captain financial request here',
      name: 'youCanChangeCaptainFinancialPlan',
      desc: '',
      args: [],
    );
  }

  /// `Change captain plan`
  String get changeCaptainPlan {
    return Intl.message(
      'Change captain plan',
      name: 'changeCaptainPlan',
      desc: '',
      args: [],
    );
  }

  /// `There is no order cash deserved `
  String get youCannotMakePaymentThereIsNoOrderCash {
    return Intl.message(
      'There is no order cash deserved ',
      name: 'youCannotMakePaymentThereIsNoOrderCash',
      desc: '',
      args: [],
    );
  }

  /// `Your request to change captain plan failed `
  String get yourRequestToChangeCaptainPlanFailed {
    return Intl.message(
      'Your request to change captain plan failed ',
      name: 'yourRequestToChangeCaptainPlanFailed',
      desc: '',
      args: [],
    );
  }

  /// `delivery date`
  String get deliveryDate {
    return Intl.message(
      'delivery date',
      name: 'deliveryDate',
      desc: '',
      args: [],
    );
  }

  /// `Cash With Captain`
  String get orderCashWithCaptain {
    return Intl.message(
      'Cash With Captain',
      name: 'orderCashWithCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Captain Notes`
  String get captainNote {
    return Intl.message(
      'Captain Notes',
      name: 'captainNote',
      desc: '',
      args: [],
    );
  }

  /// `Pay Exclusively`
  String get youNeedToPayExclusively {
    return Intl.message(
      'Pay Exclusively',
      name: 'youNeedToPayExclusively',
      desc: '',
      args: [],
    );
  }

  /// `Car Updated successfully`
  String get carUpdatedSuccessfully {
    return Intl.message(
      'Car Updated successfully',
      name: 'carUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Finance category deleted successfully`
  String get financeCategoryDeletedSuccessfully {
    return Intl.message(
      'Finance category deleted successfully',
      name: 'financeCategoryDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Are sure about deleting this captain finance plan`
  String get areSureAboutDeleteThisFinance {
    return Intl.message(
      'Are sure about deleting this captain finance plan',
      name: 'areSureAboutDeleteThisFinance',
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

  /// `Pending orders`
  String get pendingOrders {
    return Intl.message(
      'Pending orders',
      name: 'pendingOrders',
      desc: '',
      args: [],
    );
  }

  /// `Hidden`
  String get hidden {
    return Intl.message(
      'Hidden',
      name: 'hidden',
      desc: '',
      args: [],
    );
  }

  /// `Ordered not accepted`
  String get orderedNotAccepted {
    return Intl.message(
      'Ordered not accepted',
      name: 'orderedNotAccepted',
      desc: '',
      args: [],
    );
  }

  /// `Not completed account`
  String get notCompletedAccount {
    return Intl.message(
      'Not completed account',
      name: 'notCompletedAccount',
      desc: '',
      args: [],
    );
  }

  /// `not accepted`
  String get notAccepted {
    return Intl.message(
      'not accepted',
      name: 'notAccepted',
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

  /// `Order created successfully`
  String get orderCreatedSuccessfully {
    return Intl.message(
      'Order created successfully',
      name: 'orderCreatedSuccessfully',
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

  /// `Order can contains a sub orders`
  String get thisOrderCanBeLinked {
    return Intl.message(
      'Order can contains a sub orders',
      name: 'thisOrderCanBeLinked',
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

  /// `Order updated successfully`
  String get orderUpdatedSuccessfully {
    return Intl.message(
      'Order updated successfully',
      name: 'orderUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Last week`
  String get lastWeek {
    return Intl.message(
      'Last week',
      name: 'lastWeek',
      desc: '',
      args: [],
    );
  }

  /// `Choose store`
  String get chooseStore {
    return Intl.message(
      'Choose store',
      name: 'chooseStore',
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

  /// `Update order state`
  String get updateOrderState {
    return Intl.message(
      'Update order state',
      name: 'updateOrderState',
      desc: '',
      args: [],
    );
  }

  /// `Is captain in store`
  String get confirmCaptainLocation {
    return Intl.message(
      'Is captain in store',
      name: 'confirmCaptainLocation',
      desc: '',
      args: [],
    );
  }

  /// `Unconfirmed`
  String get unconfirmed {
    return Intl.message(
      'Unconfirmed',
      name: 'unconfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Captain paid to provider ?`
  String get captainPaidToProvider {
    return Intl.message(
      'Captain paid to provider ?',
      name: 'captainPaidToProvider',
      desc: '',
      args: [],
    );
  }

  /// `Collected payment note`
  String get collectedPaymentNote {
    return Intl.message(
      'Collected payment note',
      name: 'collectedPaymentNote',
      desc: '',
      args: [],
    );
  }

  /// `Collected Payment`
  String get collectedPayment {
    return Intl.message(
      'Collected Payment',
      name: 'collectedPayment',
      desc: '',
      args: [],
    );
  }

  /// `Collected payment not match with bill that you should receive`
  String get collectedPaymentNotMatch {
    return Intl.message(
      'Collected payment not match with bill that you should receive',
      name: 'collectedPaymentNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please provide us with distance you reached out and collected payment with this order To finish the order`
  String get finishingOrderMessageWithPayment {
    return Intl.message(
      'Please provide us with distance you reached out and collected payment with this order To finish the order',
      name: 'finishingOrderMessageWithPayment',
      desc: '',
      args: [],
    );
  }

  /// `Please provide us with distance you reached out with this order To finish the order`
  String get finishingOrderMessage {
    return Intl.message(
      'Please provide us with distance you reached out with this order To finish the order',
      name: 'finishingOrderMessage',
      desc: '',
      args: [],
    );
  }

  /// `Order status updated successfully`
  String get updateOrderStatusSuccessfully {
    return Intl.message(
      'Order status updated successfully',
      name: 'updateOrderStatusSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Order Assigned Successfully`
  String get orderAssignedSuccessfully {
    return Intl.message(
      'Order Assigned Successfully',
      name: 'orderAssignedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about reset this order and remove it form captain`
  String get areYouSureAboutRependingOrder {
    return Intl.message(
      'Are you sure about reset this order and remove it form captain',
      name: 'areYouSureAboutRependingOrder',
      desc: '',
      args: [],
    );
  }

  /// `Assign captain to handle this order`
  String get assignCaptainHint {
    return Intl.message(
      'Assign captain to handle this order',
      name: 'assignCaptainHint',
      desc: '',
      args: [],
    );
  }

  /// `Assign Captain`
  String get assignCaptain {
    return Intl.message(
      'Assign Captain',
      name: 'assignCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Assign`
  String get assign {
    return Intl.message(
      'Assign',
      name: 'assign',
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

  /// `Package Orders `
  String get packageOrderStatus {
    return Intl.message(
      'Package Orders ',
      name: 'packageOrderStatus',
      desc: '',
      args: [],
    );
  }

  /// `Package Captain`
  String get packageCaptainsStatus {
    return Intl.message(
      'Package Captain',
      name: 'packageCaptainsStatus',
      desc: '',
      args: [],
    );
  }

  /// `Is Future Subscriptions`
  String get isFutureSubscriptions {
    return Intl.message(
      'Is Future Subscriptions',
      name: 'isFutureSubscriptions',
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

  /// `Last 24h orders`
  String get last24CountOrder {
    return Intl.message(
      'Last 24h orders',
      name: 'last24CountOrder',
      desc: '',
      args: [],
    );
  }

  /// `Last 7 days orders`
  String get last7WeekOrders {
    return Intl.message(
      'Last 7 days orders',
      name: 'last7WeekOrders',
      desc: '',
      args: [],
    );
  }

  /// `Paid Order`
  String get paidOrder {
    return Intl.message(
      'Paid Order',
      name: 'paidOrder',
      desc: '',
      args: [],
    );
  }

  /// `Unpaid Order`
  String get unPaidOrder {
    return Intl.message(
      'Unpaid Order',
      name: 'unPaidOrder',
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

  /// `Unavailable`
  String get unavailable {
    return Intl.message(
      'Unavailable',
      name: 'unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Unverified`
  String get accountUnVerified {
    return Intl.message(
      'Unverified',
      name: 'accountUnVerified',
      desc: '',
      args: [],
    );
  }

  /// `Verified`
  String get accountVerified {
    return Intl.message(
      'Verified',
      name: 'accountVerified',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully`
  String get accountDeletedSuccessfully {
    return Intl.message(
      'Account deleted successfully',
      name: 'accountDeletedSuccessfully',
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

  /// `Account has order records`
  String get accountHasOrdersRecord {
    return Intl.message(
      'Account has order records',
      name: 'accountHasOrdersRecord',
      desc: '',
      args: [],
    );
  }

  /// `Account has payments record`
  String get accountHasPaymentsRecord {
    return Intl.message(
      'Account has payments record',
      name: 'accountHasPaymentsRecord',
      desc: '',
      args: [],
    );
  }

  /// `Total cash orders`
  String get totalCashOrder {
    return Intl.message(
      'Total cash orders',
      name: 'totalCashOrder',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Choose payment method`
  String get choosePaymentMethod {
    return Intl.message(
      'Choose payment method',
      name: 'choosePaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Group order`
  String get groupOrder {
    return Intl.message(
      'Group order',
      name: 'groupOrder',
      desc: '',
      args: [],
    );
  }

  /// `Account Managing`
  String get accountManaging {
    return Intl.message(
      'Account Managing',
      name: 'accountManaging',
      desc: '',
      args: [],
    );
  }

  /// `Account Info`
  String get accountInfo {
    return Intl.message(
      'Account Info',
      name: 'accountInfo',
      desc: '',
      args: [],
    );
  }

  /// `Remaining Orders`
  String get packageOrderRemainingOrders {
    return Intl.message(
      'Remaining Orders',
      name: 'packageOrderRemainingOrders',
      desc: '',
      args: [],
    );
  }

  /// `Package Orders`
  String get packageOrderCount {
    return Intl.message(
      'Package Orders',
      name: 'packageOrderCount',
      desc: '',
      args: [],
    );
  }

  /// `Package captains count`
  String get packageCaptainsCount {
    return Intl.message(
      'Package captains count',
      name: 'packageCaptainsCount',
      desc: '',
      args: [],
    );
  }

  /// `Remaining Captains`
  String get packageRemainingCaptains {
    return Intl.message(
      'Remaining Captains',
      name: 'packageRemainingCaptains',
      desc: '',
      args: [],
    );
  }

  /// `Unknown action`
  String get unknownAction {
    return Intl.message(
      'Unknown action',
      name: 'unknownAction',
      desc: '',
      args: [],
    );
  }

  /// `Updated order state`
  String get UpdatedOrderState {
    return Intl.message(
      'Updated order state',
      name: 'UpdatedOrderState',
      desc: '',
      args: [],
    );
  }

  /// `Order Canceled`
  String get orderedCanceled {
    return Intl.message(
      'Order Canceled',
      name: 'orderedCanceled',
      desc: '',
      args: [],
    );
  }

  /// `Order assigned to captain`
  String get assignedOrderToCaptain {
    return Intl.message(
      'Order assigned to captain',
      name: 'assignedOrderToCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Created new order`
  String get createdNewOrder {
    return Intl.message(
      'Created new order',
      name: 'createdNewOrder',
      desc: '',
      args: [],
    );
  }

  /// `Unlinked order from group order`
  String get unlinkedSubOrderFromGroupedOrder {
    return Intl.message(
      'Unlinked order from group order',
      name: 'unlinkedSubOrderFromGroupedOrder',
      desc: '',
      args: [],
    );
  }

  /// `Updated order`
  String get updatedOrder {
    return Intl.message(
      'Updated order',
      name: 'updatedOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order hided to edit by admin`
  String get orderHidedToEditByAdmin {
    return Intl.message(
      'Order hided to edit by admin',
      name: 'orderHidedToEditByAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Un assign order`
  String get unAssignOrder {
    return Intl.message(
      'Un assign order',
      name: 'unAssignOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order hided to be edit`
  String get orderHidedToEditByStore {
    return Intl.message(
      'Order hided to be edit',
      name: 'orderHidedToEditByStore',
      desc: '',
      args: [],
    );
  }

  /// `Unlinked suborder`
  String get unlinkedSubOrder {
    return Intl.message(
      'Unlinked suborder',
      name: 'unlinkedSubOrder',
      desc: '',
      args: [],
    );
  }

  /// `New suborder created`
  String get newSubOrderCreated {
    return Intl.message(
      'New suborder created',
      name: 'newSubOrderCreated',
      desc: '',
      args: [],
    );
  }

  /// `order unhidden due captains available`
  String get orderUnHidedDuCaptainAvailable {
    return Intl.message(
      'order unhidden due captains available',
      name: 'orderUnHidedDuCaptainAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Order hidden due time has expired`
  String get orderHidedDuTimeExpired {
    return Intl.message(
      'Order hidden due time has expired',
      name: 'orderHidedDuTimeExpired',
      desc: '',
      args: [],
    );
  }

  /// `Order recycled`
  String get orderRecycled {
    return Intl.message(
      'Order recycled',
      name: 'orderRecycled',
      desc: '',
      args: [],
    );
  }

  /// `Order canceled`
  String get canceledOrder {
    return Intl.message(
      'Order canceled',
      name: 'canceledOrder',
      desc: '',
      args: [],
    );
  }

  /// `Captain finished filling information`
  String get captainFinishedFillingOrderInformation {
    return Intl.message(
      'Captain finished filling information',
      name: 'captainFinishedFillingOrderInformation',
      desc: '',
      args: [],
    );
  }

  /// `Total orders count`
  String get totalOrdersCount {
    return Intl.message(
      'Total orders count',
      name: 'totalOrdersCount',
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

  /// `Action`
  String get action {
    return Intl.message(
      'Action',
      name: 'action',
      desc: '',
      args: [],
    );
  }

  /// `Action By`
  String get actionBy {
    return Intl.message(
      'Action By',
      name: 'actionBy',
      desc: '',
      args: [],
    );
  }

  /// `Order status`
  String get currentOrderStatus {
    return Intl.message(
      'Order status',
      name: 'currentOrderStatus',
      desc: '',
      args: [],
    );
  }

  /// `Order action logs`
  String get orderLogHistory {
    return Intl.message(
      'Order action logs',
      name: 'orderLogHistory',
      desc: '',
      args: [],
    );
  }

  /// `In this window we will view action logs history in this order`
  String get actionLogHistoryHint {
    return Intl.message(
      'In this window we will view action logs history in this order',
      name: 'actionLogHistoryHint',
      desc: '',
      args: [],
    );
  }

  /// `Action date`
  String get actionDate {
    return Intl.message(
      'Action date',
      name: 'actionDate',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `Update profile`
  String get updatePersonalInformation {
    return Intl.message(
      'Update profile',
      name: 'updatePersonalInformation',
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

  /// `Offer status`
  String get offerStatus {
    return Intl.message(
      'Offer status',
      name: 'offerStatus',
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

  /// `Client Distance`
  String get clientDistance {
    return Intl.message(
      'Client Distance',
      name: 'clientDistance',
      desc: '',
      args: [],
    );
  }

  /// `Conflicts answer`
  String get ordersCashConflictsAnswer {
    return Intl.message(
      'Conflicts answer',
      name: 'ordersCashConflictsAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Not answered by store`
  String get ordersCashNotAnswered {
    return Intl.message(
      'Not answered by store',
      name: 'ordersCashNotAnswered',
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

  /// `Subscription management`
  String get subscriptionManagement {
    return Intl.message(
      'Subscription management',
      name: 'subscriptionManagement',
      desc: '',
      args: [],
    );
  }

  /// `Current subscriptions`
  String get currentSubscriptions {
    return Intl.message(
      'Current subscriptions',
      name: 'currentSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Create subscription`
  String get createSubscription {
    return Intl.message(
      'Create subscription',
      name: 'createSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Edit subscription`
  String get editSubscriptions {
    return Intl.message(
      'Edit subscription',
      name: 'editSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Delete future subscription`
  String get deleteFutureSubscription {
    return Intl.message(
      'Delete future subscription',
      name: 'deleteFutureSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Not implemented yet`
  String get notImplementedYet {
    return Intl.message(
      'Not implemented yet',
      name: 'notImplementedYet',
      desc: '',
      args: [],
    );
  }

  /// `Here you find all your expired subscriptions financial information with included all payments `
  String get expiredSubscriptionsFinanceHint {
    return Intl.message(
      'Here you find all your expired subscriptions financial information with included all payments ',
      name: 'expiredSubscriptionsFinanceHint',
      desc: '',
      args: [],
    );
  }

  /// `Package extend`
  String get packageExtend {
    return Intl.message(
      'Package extend',
      name: 'packageExtend',
      desc: '',
      args: [],
    );
  }

  /// `Package extended successfully`
  String get packageExtendedSuccessfully {
    return Intl.message(
      'Package extended successfully',
      name: 'packageExtendedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe to captain offer`
  String get subscribeToCaptainOffer {
    return Intl.message(
      'Subscribe to captain offer',
      name: 'subscribeToCaptainOffer',
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

  /// `Ended subscriptions`
  String get endedSubscriptions {
    return Intl.message(
      'Ended subscriptions',
      name: 'endedSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about deleting all future subscriptions`
  String get deleteAllFutureSubscriptions {
    return Intl.message(
      'Are you sure about deleting all future subscriptions',
      name: 'deleteAllFutureSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Future subscriptions deleted successfully`
  String get futureSubscriptionsDeletedSuccessfully {
    return Intl.message(
      'Future subscriptions deleted successfully',
      name: 'futureSubscriptionsDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Subscribed to captain offer with a success`
  String get subscribedToOfferSuccessfully {
    return Intl.message(
      'Subscribed to captain offer with a success',
      name: 'subscribedToOfferSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Are sure about delete this subscriptions`
  String get areSureAboutDeleteThisSubscriptions {
    return Intl.message(
      'Are sure about delete this subscriptions',
      name: 'areSureAboutDeleteThisSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Are you want to delete all payments`
  String get areYouWantToDeleteAllPayments {
    return Intl.message(
      'Are you want to delete all payments',
      name: 'areYouWantToDeleteAllPayments',
      desc: '',
      args: [],
    );
  }

  /// `Are you want to delete captain offer event even if it used`
  String get areYouWantToDeleteCaptainOfferEvenIfUsed {
    return Intl.message(
      'Are you want to delete captain offer event even if it used',
      name: 'areYouWantToDeleteCaptainOfferEvenIfUsed',
      desc: '',
      args: [],
    );
  }

  /// `Delete Captain Offer subscription`
  String get deleteCaptainOfferSubscription {
    return Intl.message(
      'Delete Captain Offer subscription',
      name: 'deleteCaptainOfferSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about deleting captain offer subscription`
  String get areSureAboutDeleteThisCaptainOfferSubscriptions {
    return Intl.message(
      'Are you sure about deleting captain offer subscription',
      name: 'areSureAboutDeleteThisCaptainOfferSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Delete captain offer subscription successfully`
  String get deleteCaptainOfferSubscriptionSuccessfully {
    return Intl.message(
      'Delete captain offer subscription successfully',
      name: 'deleteCaptainOfferSubscriptionSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Captain Distance`
  String get captainDistance {
    return Intl.message(
      'Captain Distance',
      name: 'captainDistance',
      desc: '',
      args: [],
    );
  }

  /// `Geo Distance`
  String get geoDistance {
    return Intl.message(
      'Geo Distance',
      name: 'geoDistance',
      desc: '',
      args: [],
    );
  }

  /// `Captain cannot accept another order from this store , Please wait to deliver orders belongs to this store after that try again`
  String get youCannotAcceptAnotherOrderFromThisStore {
    return Intl.message(
      'Captain cannot accept another order from this store , Please wait to deliver orders belongs to this store after that try again',
      name: 'youCannotAcceptAnotherOrderFromThisStore',
      desc: '',
      args: [],
    );
  }

  /// `Inactive Offer`
  String get inactiveOffer {
    return Intl.message(
      'Inactive Offer',
      name: 'inactiveOffer',
      desc: '',
      args: [],
    );
  }

  /// `12.934,13.4124`
  String get provideClientCoordinationsHint {
    return Intl.message(
      '12.934,13.4124',
      name: 'provideClientCoordinationsHint',
      desc: '',
      args: [],
    );
  }

  /// `Delivery location`
  String get provideClientCoordinations {
    return Intl.message(
      'Delivery location',
      name: 'provideClientCoordinations',
      desc: '',
      args: [],
    );
  }

  /// `Phone number start with zero please remove it and try again`
  String get yourNumberStartWithZero {
    return Intl.message(
      'Phone number start with zero please remove it and try again',
      name: 'yourNumberStartWithZero',
      desc: '',
      args: [],
    );
  }

  /// `Store answer confirm/denied receiving order cash from captain`
  String get storeAnswerOrderCash {
    return Intl.message(
      'Store answer confirm/denied receiving order cash from captain',
      name: 'storeAnswerOrderCash',
      desc: '',
      args: [],
    );
  }

  /// `New subOrder created by administration`
  String get newSubOrderCreatedByAdministration {
    return Intl.message(
      'New subOrder created by administration',
      name: 'newSubOrderCreatedByAdministration',
      desc: '',
      args: [],
    );
  }

  /// `Store branch to client distance updated`
  String get storeBranchToClientDistanceUpdated {
    return Intl.message(
      'Store branch to client distance updated',
      name: 'storeBranchToClientDistanceUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Store branch to client distance and client location updated`
  String get storeBranchToClientDistanceAndDestinationUpdated {
    return Intl.message(
      'Store branch to client distance and client location updated',
      name: 'storeBranchToClientDistanceAndDestinationUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Receipt of the cash amount was confirmed using the command`
  String get cashPaymentConfirmed {
    return Intl.message(
      'Receipt of the cash amount was confirmed using the command',
      name: 'cashPaymentConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Payment conflict answer resolved`
  String get payConflictAnswersResolved {
    return Intl.message(
      'Payment conflict answer resolved',
      name: 'payConflictAnswersResolved',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message(
      'Admin',
      name: 'admin',
      desc: '',
      args: [],
    );
  }

  /// `Distance provided by captain`
  String get distanceProvidedByCaptain {
    return Intl.message(
      'Distance provided by captain',
      name: 'distanceProvidedByCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Distance from branch to client`
  String get storeBranchToClientDistance {
    return Intl.message(
      'Distance from branch to client',
      name: 'storeBranchToClientDistance',
      desc: '',
      args: [],
    );
  }

  /// `Subscription with new plan was a success`
  String get successRenewNewPlan {
    return Intl.message(
      'Subscription with new plan was a success',
      name: 'successRenewNewPlan',
      desc: '',
      args: [],
    );
  }

  /// `Subscription deleted successfully`
  String get subscriptionDeletedSuccessfully {
    return Intl.message(
      'Subscription deleted successfully',
      name: 'subscriptionDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Unable to delete this subscription , It has a recorded payments`
  String get unableToDeletePaymentsExist {
    return Intl.message(
      'Unable to delete this subscription , It has a recorded payments',
      name: 'unableToDeletePaymentsExist',
      desc: '',
      args: [],
    );
  }

  /// `There is no valid subscription`
  String get thereIsNoValidSubscription {
    return Intl.message(
      'There is no valid subscription',
      name: 'thereIsNoValidSubscription',
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

  /// `New sub order`
  String get newOrderLink {
    return Intl.message(
      'New sub order',
      name: 'newOrderLink',
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

  /// `Order conflicted Successfully`
  String get orderConflictedSuccessfully {
    return Intl.message(
      'Order conflicted Successfully',
      name: 'orderConflictedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Store Answer`
  String get storeAnswer {
    return Intl.message(
      'Store Answer',
      name: 'storeAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Captain Answer`
  String get captainAnswer {
    return Intl.message(
      'Captain Answer',
      name: 'captainAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Are sure about resolving this order finance conflict`
  String get areSureAboutResolveThisOrder {
    return Intl.message(
      'Are sure about resolving this order finance conflict',
      name: 'areSureAboutResolveThisOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order log`
  String get storeOrderLog {
    return Intl.message(
      'Order log',
      name: 'storeOrderLog',
      desc: '',
      args: [],
    );
  }

  /// `Captain Ratings`
  String get captainsRating {
    return Intl.message(
      'Captain Ratings',
      name: 'captainsRating',
      desc: '',
      args: [],
    );
  }

  /// `You cannot subscribe with captain offer because store out of subscriptions`
  String get cannotSubscribeToCaptainOffer {
    return Intl.message(
      'You cannot subscribe with captain offer because store out of subscriptions',
      name: 'cannotSubscribeToCaptainOffer',
      desc: '',
      args: [],
    );
  }

  /// `Captain Activity`
  String get captainActivity {
    return Intl.message(
      'Captain Activity',
      name: 'captainActivity',
      desc: '',
      args: [],
    );
  }

  /// `Captain Rataings Details`
  String get captainratingDetails {
    return Intl.message(
      'Captain Rataings Details',
      name: 'captainratingDetails',
      desc: '',
      args: [],
    );
  }

  /// `Number of rates`
  String get numberofRatings {
    return Intl.message(
      'Number of rates',
      name: 'numberofRatings',
      desc: '',
      args: [],
    );
  }

  /// `No comments`
  String get noComment {
    return Intl.message(
      'No comments',
      name: 'noComment',
      desc: '',
      args: [],
    );
  }

  /// `Updated order status by administration`
  String get updatedOrderStatusByAdministration {
    return Intl.message(
      'Updated order status by administration',
      name: 'updatedOrderStatusByAdministration',
      desc: '',
      args: [],
    );
  }

  /// `Conflicted answers resolved by administration`
  String get payConflictAnswersResolvedByAdministration {
    return Intl.message(
      'Conflicted answers resolved by administration',
      name: 'payConflictAnswersResolvedByAdministration',
      desc: '',
      args: [],
    );
  }

  /// `Update store answer for cash order`
  String get updateStoreAnswerSuccessfully {
    return Intl.message(
      'Update store answer for cash order',
      name: 'updateStoreAnswerSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Cash Received`
  String get receivedCash {
    return Intl.message(
      'Cash Received',
      name: 'receivedCash',
      desc: '',
      args: [],
    );
  }

  /// `Cash not Received`
  String get notReceivedCash {
    return Intl.message(
      'Cash not Received',
      name: 'notReceivedCash',
      desc: '',
      args: [],
    );
  }

  /// `Choose from date`
  String get chooseFromDate {
    return Intl.message(
      'Choose from date',
      name: 'chooseFromDate',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Are sure about answering behalf store`
  String get areSureAboutAnsweringBehalfStore {
    return Intl.message(
      'Are sure about answering behalf store',
      name: 'areSureAboutAnsweringBehalfStore',
      desc: '',
      args: [],
    );
  }

  /// `Rate Captain`
  String get rateCaptainDetails {
    return Intl.message(
      'Rate Captain',
      name: 'rateCaptainDetails',
      desc: '',
      args: [],
    );
  }

  /// `Captain Activity`
  String get captainractivityDetails {
    return Intl.message(
      'Captain Activity',
      name: 'captainractivityDetails',
      desc: '',
      args: [],
    );
  }

  /// `This order cannot be assigned to this captain because the request is hidden`
  String get theOrderHidden {
    return Intl.message(
      'This order cannot be assigned to this captain because the request is hidden',
      name: 'theOrderHidden',
      desc: '',
      args: [],
    );
  }

  /// `Order updated successfully`
  String get orderRecycledSuccessfully {
    return Intl.message(
      'Order updated successfully',
      name: 'orderRecycledSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Confirm recycle order `
  String get confirmRecycleOrder {
    return Intl.message(
      'Confirm recycle order ',
      name: 'confirmRecycleOrder',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure ?\n you will recycle this order`
  String get recycleOrderWarning {
    return Intl.message(
      'Are you sure ?\n you will recycle this order',
      name: 'recycleOrderWarning',
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

  /// `You can choose captain plan`
  String get youCanChooseCaptainPlan {
    return Intl.message(
      'You can choose captain plan',
      name: 'youCanChooseCaptainPlan',
      desc: '',
      args: [],
    );
  }

  /// `Top store activity`
  String get topstoreActivity {
    return Intl.message(
      'Top store activity',
      name: 'topstoreActivity',
      desc: '',
      args: [],
    );
  }

  /// `The recipient location field has been updated by the administration`
  String get destinationUpdate {
    return Intl.message(
      'The recipient location field has been updated by the administration',
      name: 'destinationUpdate',
      desc: '',
      args: [],
    );
  }

  /// `The request has been recycled by the administration`
  String get recycleOrderDone {
    return Intl.message(
      'The request has been recycled by the administration',
      name: 'recycleOrderDone',
      desc: '',
      args: [],
    );
  }

  /// `A distance was added to the calculated distance automatically, directly by the administration`
  String get storeBranchToClientDistanceDirectly {
    return Intl.message(
      'A distance was added to the calculated distance automatically, directly by the administration',
      name: 'storeBranchToClientDistanceDirectly',
      desc: '',
      args: [],
    );
  }

  /// `A distance was added to the calculated distance automatically using the coordinates of the new location by the administration`
  String get storeBranchToClientDistance2 {
    return Intl.message(
      'A distance was added to the calculated distance automatically using the coordinates of the new location by the administration',
      name: 'storeBranchToClientDistance2',
      desc: '',
      args: [],
    );
  }

  /// `Receipt of the cash amount has been confirmed/denied by the administration on behalf of the store`
  String get isCashPaymentConfirmedByStore {
    return Intl.message(
      'Receipt of the cash amount has been confirmed/denied by the administration on behalf of the store',
      name: 'isCashPaymentConfirmedByStore',
      desc: '',
      args: [],
    );
  }

  /// `copied successfully`
  String get copied {
    return Intl.message(
      'copied successfully',
      name: 'copied',
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
