import 'package:intl/intl.dart';

import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_captain/response/captain_profile_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class ProfileModel extends DataModel {
  int id = -1;
  String? image;
  String? name;
  String? phone;
  String? stcPay;
  String? bankNumber;
  String? bankName;
  String? drivingLicence;
  String? car;
  String? identity;
  String? mechanicLicense;
  int? age;
  bool? isOnline;
  String? status;
  num? salary;
  num? bounce;
  String? createDate;
  OrderCountsSystemDetails? captainFinance;
  bool? verificationStatus;
  late int captainId;
  late String roomId;
  String? city;
  String? address;
  ProfileModel({
    required this.id,
    this.image,
    this.name,
    this.phone,
    this.stcPay,
    this.bankNumber,
    this.bankName,
    this.drivingLicence,
    this.car,
    this.identity,
    this.mechanicLicense,
    this.age,
    this.isOnline,
    this.status,
    this.bounce,
    this.salary,
    this.createDate,
    this.captainFinance,
    this.verificationStatus,
    required this.captainId,
    required this.roomId,
    this.address,
    this.city,
  });

  ProfileModel? _models;

  ProfileModel.withData(Data data) : super.withData() {
    _models = ProfileModel(
        captainFinance: getOrderCounts(data.financialSystemCaptainDetails),
        id: data.id ?? -1,
        image: data.image?.image,
        name: data.captainName,
        phone: data.phone,
        stcPay: data.stcPay,
        bankName: data.bankName,
        bankNumber: data.bankAccountNumber,
        car: data.car,
        age: data.age,
        mechanicLicense: data.mechanicLicense?.image,
        drivingLicence: data.drivingLicence?.image,
        identity: data.identity?.image,
        isOnline: data.isOnline,
        status: data.status,
        salary: data.salary,
        bounce: data.bounce,
        city: data.city,
        address: data.address,
        createDate: DateFormat.jm()
                .format(DateHelper.convert(data.createDate?.timestamp)) +
            '   ' +
            DateFormat.yMd()
                .format(DateHelper.convert(data.createDate?.timestamp)),
        verificationStatus: data.verificationStatus == 1 ? true : false,
        captainId: data.captainID ?? -1,
        roomId: data.roomID ?? '');
  }

  ProfileModel get data =>
      _models ?? ProfileModel(id: -1, captainId: -1, roomId: '');
  OrderCountsSystemDetails getOrderCounts(
      FinancialSystemCaptainDetails? finance) {
    return OrderCountsSystemDetails(
        captainFinancialSystemType: finance?.captainFinancialSystemType,
        compensationForEveryOrder: finance?.compensationForEveryOrder,
        countHours: finance?.countHours,
        createDate: DateFormat.jm()
                .format(DateHelper.convert(finance?.createDate?.timestamp)) +
            '   ' +
            DateFormat.yMd()
                .format(DateHelper.convert(finance?.createDate?.timestamp)),
        id: finance?.id,
        salary: finance?.salary,
        status: finance?.status,
        updateDate: DateFormat.jm()
                .format(DateHelper.convert(finance?.updateDate?.timestamp)) +
            '   ' +
            DateFormat.yMd()
                .format(DateHelper.convert(finance?.updateDate?.timestamp)),
        updatedBy: finance?.updatedBy,
        bounceMaxCountOrdersInMonth: finance?.bounceMaxCountOrdersInMonth,
        bounceMinCountOrdersInMonth: finance?.bounceMinCountOrdersInMonth,
        countOrdersInMonth: finance?.countOrdersInMonth,
        monthCompensation: finance?.monthCompensation);
  }
}

class OrderCountsSystemDetails {
  int? id;
  String? createDate;
  String? updateDate;
  int? captainFinancialSystemType;
  bool? status;
  String? updatedBy;
  num? countHours;
  num? compensationForEveryOrder;
  num? salary;
  num? countOrdersInMonth;
  num? monthCompensation;
  num? bounceMaxCountOrdersInMonth;
  num? bounceMinCountOrdersInMonth;
  OrderCountsSystemDetails({
    required this.id,
    required this.createDate,
    required this.updateDate,
    required this.captainFinancialSystemType,
    required this.status,
    required this.updatedBy,
    required this.countHours,
    required this.compensationForEveryOrder,
    required this.salary,
    required this.bounceMaxCountOrdersInMonth,
    required this.bounceMinCountOrdersInMonth,
    required this.monthCompensation,
    required this.countOrdersInMonth,
  });
}
