import 'package:c4d/module_supplier/response/supplier_profile_response.dart';
import 'package:intl/intl.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class ProfileSupplierModel extends DataModel {
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
  ProfileSupplierModel(
      {required this.id,
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
      this.createDate});

  ProfileSupplierModel? _models;

  ProfileSupplierModel.withData(DataSupplierProfile data) : super.withData() {
    _models = ProfileSupplierModel(
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
        createDate: DateFormat.jm()
                .format(DateHelper.convert(data.createDate?.timestamp)) +
            '   ' +
            DateFormat.yMd()
                .format(DateHelper.convert(data.createDate?.timestamp)));
  }

  ProfileSupplierModel get data => _models ?? ProfileSupplierModel(id: -1);
}
