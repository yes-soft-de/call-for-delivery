class CancelOrderRequest {
  int? id;

  CancelOrderRequest({this.id});

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}
