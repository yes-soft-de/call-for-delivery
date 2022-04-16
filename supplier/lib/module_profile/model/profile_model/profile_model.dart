import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/response/profile_response/profile_response.dart';

class ProfileModel extends DataModel {
  String? image;
  String? imageUrl;
  late String name;
  late String phone;
   bool status = false;
   String? categoryName;

  String? roomId;
  ProfileModel(
      {required this.image,
      required this.name,
    required  this.status,
      this.imageUrl,
      required this.roomId,required this.phone,this.categoryName});
  late ProfileModel _profile;
  ProfileModel.withData(ProfileResponse response) {
    var data = response.data;
    _profile = ProfileModel(
      categoryName: data?.supplierCategoryName ??  S.current.unknown,
      phone: data?.phone ??  S.current.unknown,
        image: data?.images?[0].image,
        imageUrl: data?.images?[0].imageUrl,
        name: data?.name ?? S.current.unknown,
        status: data?.status ?? false,
        roomId: data?.roomId);
  }
  ProfileModel get data => _profile;
}
