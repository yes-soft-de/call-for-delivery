import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/response/profile_response/profile_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';

class ProfileModel extends DataModel {
  String? image;
  String? imageUrl;
  late String name;
  late String phone;
  late String stcPay;
  late String bankNumber;
  late String bankName;
  late String city;
  late String? employeeCount;
  late String? status;
  late DateTime openingTime;
  late DateTime closingTime;
  String? roomId;
  ProfileModel(
      {required this.image,
      required this.name,
      required this.phone,
      required this.stcPay,
      required this.bankNumber,
      required this.bankName,
      required this.city,
      this.employeeCount,
      this.status,
      this.imageUrl,
      required this.closingTime,
      required this.openingTime,
      required this.roomId});
  late ProfileModel _profile;
  ProfileModel.withData(ProfileResponse response) {
    var data = response.data;
    _profile = ProfileModel(
        image: data?.images?.image,
        imageUrl: data?.images?.imageUrl,
        name: data?.storeOwnerName ?? S.current.unknown,
        phone: data?.phone ?? S.current.unknown,
        bankNumber: data?.bankNumber ?? '',
        bankName: data?.bankName ?? '',
        stcPay: '',
        city: data?.city ?? '',
        employeeCount: data?.employeeCount,
        status: data?.status ?? 'inActive',
        closingTime: DateHelper.convert(data?.closeTime?.timestamp),
        openingTime: DateHelper.convert(data?.openingTime?.timestamp),
        roomId: data?.roomId);
  }
  ProfileModel get data => _profile;
}
