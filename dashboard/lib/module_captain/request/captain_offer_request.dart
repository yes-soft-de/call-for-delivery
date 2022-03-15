class CaptainOfferRequest{
  int? id;
  int? carCount;
  String? status;
  int? expired;
  num? price;


  CaptainOfferRequest( {this.id, this.price,this.status,this.carCount ,this.expired} );

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['expired'] = expired;
    map['status'] = status;
    map['carCount'] = carCount;
    map['price'] = price;
    return map;
  }

}