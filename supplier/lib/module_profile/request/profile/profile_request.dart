import 'package:c4d/module_profile/response/profile_response/loaction.dart';
class ProfileRequest {
  String? name;
  String? phone;
  String? image;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  List<int>? supplierCategories;
  GeoJson? location;
  bool? allSupplierCategories;

  ProfileRequest(
      {this.name,
      this.phone,
      this.image,
      this.supplierCategories,this.location,this.allSupplierCategories,this.bankAccountNumber,this.bankName,this.stcPay
      });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['supplierName'] = this.name;
    data['phone'] = this.phone;
    if (this.image != null) {
      var images= [];
      images.add(ImageRequest(image ?? null).toJson());
      data['images'] =images;
    }
    data['allSupplierCategories'] = this.allSupplierCategories;
    data['bankName'] = this.bankName;
    data['bankAccountNumber'] = this.bankAccountNumber;
    data['stcPay'] = this.stcPay;
    data['location'] = {'lat': this.location?.lat, 'lon': this.location?.lon};
    data['supplierCategories'] = this.supplierCategories;
    data['supplierCategory'] = 8;
    return data;
  }
}

class ImageRequest{
  String? image;

  ImageRequest(this.image);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = this.image;
    return data;
  }
}
