import 'package:c4d/module_profile/request/profile/profile_request.dart';

class CreateAdsRequest{
  int? id;
  num? price;
  num? quantity;
  String? details;
  List<ImageRequest>? images;

  CreateAdsRequest(
  {this.price, this.quantity, this.details, this.images});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']=this.id;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['details'] = this.details;
    if(images != null){
      var imageList = [];
      images?.forEach((element) {
        imageList.add(element.toJson());
      });
      data['imagesArray'] = imageList;
    }
    return data;
  }
}