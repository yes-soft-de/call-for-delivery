class AddBidOrderRequest{

  String? payment;

  String? title;
  String? description;
  String? image;
  int? supplierCategory;
  int? branch;

  AddBidOrderRequest({this.payment,this.image,   this.title, this.description,
      this.supplierCategory, this.branch});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment'] = this.payment;
    data['title'] = this.title;
    data['note'] = this.description;
    data['branch'] = this.branch;
    data['supplierCategory'] = this.supplierCategory;
    if (this.image != null) {
      var images= [];
      images.add(ImageRequest(image ?? null).toJson());
      data['images'] =images;
    }
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