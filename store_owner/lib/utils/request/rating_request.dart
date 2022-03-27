class RatingRequest {
  String? comment;
  int? rating;
  int? rated;
  int? orderId;
  RatingRequest({this.comment, this.rated, this.rating, this.orderId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['rated'] = this.rated;
    data['orderId'] = this.orderId;
    return data;
  }
}
