import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/response/profile_response/profile_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileModel extends DataModel {
  String? image;
  String? imageUrl;
  late String name;
  late String phone;
  bool status = false;
  String? roomId;
  late String bankName;
  late String bankAccount;
  late String stc;
  late LatLng location;

  List<CategoryModel> categories = [];

  ProfileModel(
      {required this.image,
      required this.name,
      required this.status,
      this.imageUrl,
      required this.roomId,
      required this.phone,
      required this.categories,
      required this.location,
      required this.bankName,
      required this.bankAccount,
      required this.stc});
  late ProfileModel _profile;
  ProfileModel.withData(ProfileResponse response) {
    var data = response.data;
    var categories = <CategoryModel>[];
    data?.supplierCategories?.forEach((element) {
      categories.add(
          CategoryModel(element.id ?? -1, element.name ?? S.current.unknown));
    });
    _profile = ProfileModel(
        phone: data?.phone ?? S.current.unknown,
        image: data?.images?[0].image,
        imageUrl: data?.images?[0].imageUrl,
        name: data?.name ?? S.current.unknown,
        status: data?.status ?? false,
        roomId: data?.roomId,
        categories: categories,
        location: LatLng(
          data?.location?.lat?.toDouble() ?? 0,
          data?.location?.lon?.toDouble() ?? 0,
        ),
        bankName: data?.bankName ?? S.current.unknown,
        bankAccount: data?.bankAccountNumber ?? S.current.unknown,
        stc: data?.stcPay ?? S.current.unknown,
    );
  }
  ProfileModel get data => _profile;
}

class CategoryModel {
  int id;
  String name;

  CategoryModel(this.id, this.name);
}
