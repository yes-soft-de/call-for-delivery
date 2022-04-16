class ProfileRequest {
  String? name;
  String? phone;
  String? image;
  int? supplierCategoryID;
  ProfileRequest.empty();

  ProfileRequest(
      {this.name,
      this.phone,
      this.image,
      this.supplierCategoryID
      });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['supplierName'] = this.name;
    data['phone'] = this.phone;
    if (this.image != null) {
      List<ImageRequest> images= [];
      images.add(ImageRequest(image ?? null));
      data['images'] =images;
    }
    data['supplierCategory'] = this.supplierCategoryID;
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
