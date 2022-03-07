class Images {
  String? imageUrl;
  String? image;
  String? baseUrl;

  Images({this.imageUrl, this.image, this.baseUrl});

  factory Images.fromJson(Map<String, dynamic> json) {
    if (json['imageURL'] == null) json['image'] = null;
    return Images(
      imageUrl: json['imageURL'] as String?,
      image: json['image'] as String?,
      baseUrl: json['baseURL'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
        'imageURL': imageUrl,
        'image': image,
        'baseURL': baseUrl,
      };
}
