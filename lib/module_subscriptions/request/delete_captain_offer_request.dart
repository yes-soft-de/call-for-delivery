class DeleteCaptainOfferSubscriptionsRequest {
  int? storeSubscriptionId;
  int? deleteEvenItIsBeingUsed;

  DeleteCaptainOfferSubscriptionsRequest(
      {this.storeSubscriptionId, this.deleteEvenItIsBeingUsed});

  Map<String, dynamic> toJson() => {
        'storeSubscriptionId': storeSubscriptionId,
        'deleteEvenItIsBeingUsed': deleteEvenItIsBeingUsed,
      };
}
