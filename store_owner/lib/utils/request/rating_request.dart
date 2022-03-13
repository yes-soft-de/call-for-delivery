class RatingRequest {
  String? comment;
  int? rating;
  int? rated;
  RatingRequest({this.comment, this.rated, this.rating});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['rated'] = this.rated;
    return data;
  }
}
