class StoreSubscribeToCaptainOfferRequest {
  int? storeOwner;
  int? captainOffer;

  StoreSubscribeToCaptainOfferRequest({this.captainOffer, this.storeOwner});

  Map<String, dynamic> toJson() => {
        'storeOwner': storeOwner,
        'captainOffer': captainOffer,
      };
}
