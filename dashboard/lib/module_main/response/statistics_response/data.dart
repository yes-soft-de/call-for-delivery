import 'captains.dart';
import 'orders.dart';
import 'stores.dart';

class Data {
  Orders? orders;
  Stores? stores;
  Captains? captains;

  Data({this.orders, this.stores, this.captains});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
