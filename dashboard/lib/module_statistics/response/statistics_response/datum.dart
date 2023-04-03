import 'captains.dart';
import 'orders.dart';
import 'stores.dart';

class Datum {
  Orders? orders;
  Stores? stores;
  Captains? captains;

  Datum({this.orders, this.stores, this.captains});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orders: json['orders'] == null
            ? null
            : Orders.fromJson(json['orders'] as Map<String, dynamic>),
        stores: json['stores'] == null
            ? null
            : Stores.fromJson(json['stores'] as Map<String, dynamic>),
        captains: json['captains'] == null
            ? null
            : Captains.fromJson(json['captains'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'orders': orders?.toJson(),
        'stores': stores?.toJson(),
        'captains': captains?.toJson(),
      };
}
