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

  /// `Welcome to c4d`
  String get welcomeTomandob_moshtarayat_captain {
    return Intl.message(
      'Welcome to c4d',
      name: 'welcomeTomandob_moshtarayat_captain',
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

  /// `order`
  String get orderWithoutDef {
    return Intl.message(
      'order',
      name: 'orderWithoutDef',
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

  /// `Order Accepted`
  String get captainAcceptedOrder {
    return Intl.message(
      'Order Accepted',
      name: 'captainAcceptedOrder',
      desc: '',
      args: [],
    );
  }

  /// `I'm in Store`
  String get captainInStore {
    return Intl.message(
      'I\'m in Store',
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

  /// `Provide distance in KM`
  String get finishOrderProvideDistanceInKm {
    return Intl.message(
      'Provide distance in KM',
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

  /// `Please Download c4d`
  String get pleaseDownloadmandob_moshtarayat_captain {
    return Intl.message(
      'Please Download c4d',
      name: 'pleaseDownloadmandob_moshtarayat_captain',
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

  /// `I Agree to the Terms os service.`
  String get iAgreeToTheTermsOsService {
    return Intl.message(
      'I Agree to the Terms os service.',
      name: 'iAgreeToTheTermsOsService',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the terms of service & privacy policy`
  String get iAgreeToTheTermsOfServicePrivacyPolicy {
    return Intl.message(
      'I agree to the terms of service & privacy policy',
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

  /// `Your subscription not activate yet please wait`
  String get inactive {
    return Intl.message(
      'Your subscription not activate yet please wait',
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

  /// `Order Status`
  String get orderStatus {
    return Intl.message(
      'Order Status',
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

  /// `Personal Data`
  String get personalData {
    return Intl.message(
      'Personal Data',
      name: 'personalData',
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

  /// `On My way to client`
  String get deliveringDescription {
    return Intl.message(
      'On My way to client',
      name: 'deliveringDescription',
      desc: '',
      args: [],
    );
  }

  /// `I'm heading to store`
  String get captainAcceptOrderDescription {
    return Intl.message(
      'I\'m heading to store',
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

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
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

  /// `You need to book a car to deliver your package to your destenation`
  String get bookACarDescribtion {
    return Intl.message(
      'You need to book a car to deliver your package to your destenation',
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

  /// `Are you want to update this order status , please confirm`
  String get confirmUpdateOrderStatus {
    return Intl.message(
      'Are you want to update this order status , please confirm',
      name: 'confirmUpdateOrderStatus',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `The order has been receved by another captain`
  String get orderReceved {
    return Intl.message(
      'The order has been receved by another captain',
      name: 'orderReceved',
      desc: '',
      args: [],
    );
  }

  /// `All City`
  String get allcity {
    return Intl.message(
      'All City',
      name: 'allcity',
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

  /// `You have reached `
  String get youReached {
    return Intl.message(
      'You have reached ',
      name: 'youReached',
      desc: '',
      args: [],
    );
  }

  /// `percent of your orders limit`
  String get orderAverage {
    return Intl.message(
      'percent of your orders limit',
      name: 'orderAverage',
      desc: '',
      args: [],
    );
  }

  /// `Are your sure about renewing your subscription`
  String get confirmRenewSub {
    return Intl.message(
      'Are your sure about renewing your subscription',
      name: 'confirmRenewSub',
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

  /// `Bonus`
  String get bonus {
    return Intl.message(
      'Bonus',
      name: 'bonus',
      desc: '',
      args: [],
    );
  }

  /// `Fuel Bonus`
  String get kiloBonus {
    return Intl.message(
      'Fuel Bonus',
      name: 'kiloBonus',
      desc: '',
      args: [],
    );
  }

  /// `Sum Balance`
  String get sumBalance {
    return Intl.message(
      'Sum Balance',
      name: 'sumBalance',
      desc: '',
      args: [],
    );
  }

  /// `Total Salary`
  String get totalBonus {
    return Intl.message(
      'Total Salary',
      name: 'totalBonus',
      desc: '',
      args: [],
    );
  }

  /// `General Profite`
  String get netProfite {
    return Intl.message(
      'General Profite',
      name: 'netProfite',
      desc: '',
      args: [],
    );
  }

  /// `Balance Details`
  String get balanceDetails {
    return Intl.message(
      'Balance Details',
      name: 'balanceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Sending record has been failed`
  String get sendToRecordFaild {
    return Intl.message(
      'Sending record has been failed',
      name: 'sendToRecordFaild',
      desc: '',
      args: [],
    );
  }

  /// `The report send with a success`
  String get sendToRecordSuccess {
    return Intl.message(
      'The report send with a success',
      name: 'sendToRecordSuccess',
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

  /// `Sending report within 15 seconds`
  String get sendingReport {
    return Intl.message(
      'Sending report within 15 seconds',
      name: 'sendingReport',
      desc: '',
      args: [],
    );
  }

  /// `Company contact info`
  String get social {
    return Intl.message(
      'Company contact info',
      name: 'social',
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

  /// `Dear`
  String get dear {
    return Intl.message(
      'Dear',
      name: 'dear',
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

  /// `You have new notification`
  String get newMessageCommingOut {
    return Intl.message(
      'You have new notification',
      name: 'newMessageCommingOut',
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

  /// `UnActive`
  String get captainStateInactive {
    return Intl.message(
      'UnActive',
      name: 'captainStateInactive',
      desc: '',
      args: [],
    );
  }

  /// `choose your state`
  String get chooseYourState {
    return Intl.message(
      'choose your state',
      name: 'chooseYourState',
      desc: '',
      args: [],
    );
  }

  /// `update profile`
  String get updateProfile {
    return Intl.message(
      'update profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about dispose your changes`
  String get areYouSureToDisposeThis {
    return Intl.message(
      'Are you sure about dispose your changes',
      name: 'areYouSureToDisposeThis',
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

  /// `km`
  String get km {
    return Intl.message(
      'km',
      name: 'km',
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

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Store location`
  String get storeLocation {
    return Intl.message(
      'Store location',
      name: 'storeLocation',
      desc: '',
      args: [],
    );
  }

  /// `chat with client`
  String get chatWithClient {
    return Intl.message(
      'chat with client',
      name: 'chatWithClient',
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

  /// `Upload Bill`
  String get makeBill {
    return Intl.message(
      'Upload Bill',
      name: 'makeBill',
      desc: '',
      args: [],
    );
  }

  /// `Please provide the bill of the order`
  String get pleaseProvideStoreBill {
    return Intl.message(
      'Please provide the bill of the order',
      name: 'pleaseProvideStoreBill',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Location`
  String get receiptPoint {
    return Intl.message(
      'Receipt Location',
      name: 'receiptPoint',
      desc: '',
      args: [],
    );
  }

  /// `Destination`
  String get destinationPoint {
    return Intl.message(
      'Destination',
      name: 'destinationPoint',
      desc: '',
      args: [],
    );
  }

  /// `Expected Order Bill`
  String get expectedOrderBill {
    return Intl.message(
      'Expected Order Bill',
      name: 'expectedOrderBill',
      desc: '',
      args: [],
    );
  }

  /// `Receipt`
  String get receipt {
    return Intl.message(
      'Receipt',
      name: 'receipt',
      desc: '',
      args: [],
    );
  }

  /// `Saving invoice process has been failed`
  String get saveInvoiceFailed {
    return Intl.message(
      'Saving invoice process has been failed',
      name: 'saveInvoiceFailed',
      desc: '',
      args: [],
    );
  }

  /// `Saving invoice was a success`
  String get saveInvoiceSuccess {
    return Intl.message(
      'Saving invoice was a success',
      name: 'saveInvoiceSuccess',
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

  /// `Total cost of store invoice`
  String get totalBillCost {
    return Intl.message(
      'Total cost of store invoice',
      name: 'totalBillCost',
      desc: '',
      args: [],
    );
  }

  /// `Please wait we are invoice saving ...`
  String get savingInvoice {
    return Intl.message(
      'Please wait we are invoice saving ...',
      name: 'savingInvoice',
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

  /// `New Messages`
  String get lastSeenMessage {
    return Intl.message(
      'New Messages',
      name: 'lastSeenMessage',
      desc: '',
      args: [],
    );
  }

  /// `Actual`
  String get actual {
    return Intl.message(
      'Actual',
      name: 'actual',
      desc: '',
      args: [],
    );
  }

  /// `Last Month`
  String get lastMonth {
    return Intl.message(
      'Last Month',
      name: 'lastMonth',
      desc: '',
      args: [],
    );
  }

  /// `Here we are showing your balance status`
  String get myBalanceHint {
    return Intl.message(
      'Here we are showing your balance status',
      name: 'myBalanceHint',
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

  /// `There is no permission to handle this feature`
  String get thereIsNoPermission {
    return Intl.message(
      'There is no permission to handle this feature',
      name: 'thereIsNoPermission',
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

  /// `This account already exist`
  String get accountAlreadyExist {
    return Intl.message(
      'This account already exist',
      name: 'accountAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `Captain Account In Active , Please wait the administration to activate your account`
  String get captainAccountInActive {
    return Intl.message(
      'Captain Account In Active , Please wait the administration to activate your account',
      name: 'captainAccountInActive',
      desc: '',
      args: [],
    );
  }

  /// `Is billed on company`
  String get isBilledForCompany {
    return Intl.message(
      'Is billed on company',
      name: 'isBilledForCompany',
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

  /// `Choose captain profile photo`
  String get chooseCaptainProfile {
    return Intl.message(
      'Choose captain profile photo',
      name: 'chooseCaptainProfile',
      desc: '',
      args: [],
    );
  }

  /// `Please provide driving license image`
  String get pleaseProvideDrivingImage {
    return Intl.message(
      'Please provide driving license image',
      name: 'pleaseProvideDrivingImage',
      desc: '',
      args: [],
    );
  }

  /// `Please provide identity image`
  String get pleaseProvideIdentityImage {
    return Intl.message(
      'Please provide identity image',
      name: 'pleaseProvideIdentityImage',
      desc: '',
      args: [],
    );
  }

  /// `Please provide Mechanic image`
  String get pleaseProvideMechImage {
    return Intl.message(
      'Please provide Mechanic image',
      name: 'pleaseProvideMechImage',
      desc: '',
      args: [],
    );
  }

  /// `Please provide profile image`
  String get pleaseProvideProfileImage {
    return Intl.message(
      'Please provide profile image',
      name: 'pleaseProvideProfileImage',
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

  /// `Forgot password?`
  String get forgotPass {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPass',
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

  /// `Phone number invalid format , cause is more than 9`
  String get phoneNumberLong {
    return Intl.message(
      'Phone number invalid format , cause is more than 9',
      name: 'phoneNumberLong',
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

  /// `Chat With Captain`
  String get chatWithCaptain {
    return Intl.message(
      'Chat With Captain',
      name: 'chatWithCaptain',
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

  /// `Similar Products`
  String get similarProducts {
    return Intl.message(
      'Similar Products',
      name: 'similarProducts',
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

  /// `Notices`
  String get notices {
    return Intl.message(
      'Notices',
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

  /// `Captain Name`
  String get captainName {
    return Intl.message(
      'Captain Name',
      name: 'captainName',
      desc: '',
      args: [],
    );
  }

  /// `Control Panel`
  String get controlPanel {
    return Intl.message(
      'Control Panel',
      name: 'controlPanel',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `You can accept this order to deliver`
  String get acceptOrderHint {
    return Intl.message(
      'You can accept this order to deliver',
      name: 'acceptOrderHint',
      desc: '',
      args: [],
    );
  }

  /// `If you are arrived to the store`
  String get iArrivedAtTheStoreHint {
    return Intl.message(
      'If you are arrived to the store',
      name: 'iArrivedAtTheStoreHint',
      desc: '',
      args: [],
    );
  }

  /// `Ready to deliver the package`
  String get iGotThePackageHint {
    return Intl.message(
      'Ready to deliver the package',
      name: 'iGotThePackageHint',
      desc: '',
      args: [],
    );
  }

  /// `I delivered the package with a success`
  String get iFinishedDeliveringHint {
    return Intl.message(
      'I delivered the package with a success',
      name: 'iFinishedDeliveringHint',
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

  /// `Destination`
  String get destination {
    return Intl.message(
      'Destination',
      name: 'destination',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get destinationUnavailable {
    return Intl.message(
      'Unavailable',
      name: 'destinationUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Waiting you to accept this order`
  String get waitingToAccept {
    return Intl.message(
      'Waiting you to accept this order',
      name: 'waitingToAccept',
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

  /// `Paid`
  String get paid {
    return Intl.message(
      'Paid',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `Profile status updated successfully`
  String get profileStatusUpdatedSuccessfully {
    return Intl.message(
      'Profile status updated successfully',
      name: 'profileStatusUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Enquiry about order`
  String get canConnect {
    return Intl.message(
      'Enquiry about order',
      name: 'canConnect',
      desc: '',
      args: [],
    );
  }

  /// `By create chat room between you and store owner`
  String get canConnectHint {
    return Intl.message(
      'By create chat room between you and store owner',
      name: 'canConnectHint',
      desc: '',
      args: [],
    );
  }

  /// `You can't accept orders for this store any more , because It consumes all cars`
  String get storeCarsFinished {
    return Intl.message(
      'You can\'t accept orders for this store any more , because It consumes all cars',
      name: 'storeCarsFinished',
      desc: '',
      args: [],
    );
  }

  /// `Chat room created successfully`
  String get chatRoomCreated {
    return Intl.message(
      'Chat room created successfully',
      name: 'chatRoomCreated',
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

  /// `Your current rating by this store is`
  String get currentRating {
    return Intl.message(
      'Your current rating by this store is',
      name: 'currentRating',
      desc: '',
      args: [],
    );
  }

  /// `Branch Phone`
  String get branchPhone {
    return Intl.message(
      'Branch Phone',
      name: 'branchPhone',
      desc: '',
      args: [],
    );
  }

  /// `His Comment`
  String get HisComment {
    return Intl.message(
      'His Comment',
      name: 'HisComment',
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

  /// `Plan by hours`
  String get planByHours {
    return Intl.message(
      'Plan by hours',
      name: 'planByHours',
      desc: '',
      args: [],
    );
  }

  /// `Plan by orders`
  String get planByOrders {
    return Intl.message(
      'Plan by orders',
      name: 'planByOrders',
      desc: '',
      args: [],
    );
  }

  /// `Plan on order count`
  String get planByOrderCount {
    return Intl.message(
      'Plan on order count',
      name: 'planByOrderCount',
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
  String get chooseYourPlan {
    return Intl.message(
      'Please choose your plan',
      name: 'chooseYourPlan',
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

  /// `Salary`
  String get salary {
    return Intl.message(
      'Salary',
      name: 'salary',
      desc: '',
      args: [],
    );
  }

  /// `Please wait administration to accept`
  String get pleaseWaitAdministrationToAccept {
    return Intl.message(
      'Please wait administration to accept',
      name: 'pleaseWaitAdministrationToAccept',
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

  /// `You cannot choose new plan , because you have a running one`
  String get youHaveFinanceAccount {
    return Intl.message(
      'You cannot choose new plan , because you have a running one',
      name: 'youHaveFinanceAccount',
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

  /// `Did you pay order cost totally to store owner before taking the order`
  String get paidToProvider {
    return Intl.message(
      'Did you pay order cost totally to store owner before taking the order',
      name: 'paidToProvider',
      desc: '',
      args: [],
    );
  }

  /// `This order accepted by another captain`
  String get thisOrderAcceptedByAnotherCaptain {
    return Intl.message(
      'This order accepted by another captain',
      name: 'thisOrderAcceptedByAnotherCaptain',
      desc: '',
      args: [],
    );
  }

  /// `Paid to provider status`
  String get paidToProviderStatus {
    return Intl.message(
      'Paid to provider status',
      name: 'paidToProviderStatus',
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

  /// `Unlink SubOrders`
  String get unlinkSubOrders {
    return Intl.message(
      'Unlink SubOrders',
      name: 'unlinkSubOrders',
      desc: '',
      args: [],
    );
  }

  /// `Order removed successfully`
  String get orderRemovedSuccessfully {
    return Intl.message(
      'Order removed successfully',
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

  /// `You need to accept primary order first, before interact with suborders `
  String get youNeedToAcceptPrimaryOrderFirst {
    return Intl.message(
      'You need to accept primary order first, before interact with suborders ',
      name: 'youNeedToAcceptPrimaryOrderFirst',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get reject {
    return Intl.message(
      'Reject',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `Confirm removing suborder from group order `
  String get confirmRemoveSubOrder {
    return Intl.message(
      'Confirm removing suborder from group order ',
      name: 'confirmRemoveSubOrder',
      desc: '',
      args: [],
    );
  }

  /// `Are you want to accept this sub order, `
  String get confirmAcceptSubOrder {
    return Intl.message(
      'Are you want to accept this sub order, ',
      name: 'confirmAcceptSubOrder',
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

  /// `There is some suborders need your action , reject it or accept it or it will remain pending`
  String get thereIsSomeSubOrderNeedYouAttention {
    return Intl.message(
      'There is some suborders need your action , reject it or accept it or it will remain pending',
      name: 'thereIsSomeSubOrderNeedYouAttention',
      desc: '',
      args: [],
    );
  }

  /// `Captain plan not accepted from admin yet`
  String get captainPlanNotAcceptedFromAdminYet {
    return Intl.message(
      'Captain plan not accepted from admin yet',
      name: 'captainPlanNotAcceptedFromAdminYet',
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
