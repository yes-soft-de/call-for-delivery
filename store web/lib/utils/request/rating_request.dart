class RatingRequest {
  String? comment;
  int? rating;
  int? rated;
  int? orderId;
  RatingRequest({this.comment, this.rated, this.rating, this.orderId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = comment;
    data['rating'] = rating;
    data['rated'] = rated;
    data['orderId'] = orderId;
    return data;
  }
}
