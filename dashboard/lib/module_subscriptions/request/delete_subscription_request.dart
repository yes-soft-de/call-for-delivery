class DeleteSubscriptionsRequest {
  int? id;
  int? deletePayment;

  DeleteSubscriptionsRequest({this.id, this.deletePayment});

  Map<String, dynamic> toJson() => {
        'id': id,
        'deletePayment': deletePayment,
      };
}
