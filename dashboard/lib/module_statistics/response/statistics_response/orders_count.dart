import 'delivered.dart';

class OrdersCount {
	int? allOrders;
	Delivered? delivered;
	int? pending;
	int? onGoing;

	OrdersCount({this.allOrders, this.delivered, this.pending, this.onGoing});

	factory OrdersCount.fromJson(Map<String, dynamic> json) => OrdersCount(
				allOrders: json['allOrders'] as int?,
				delivered: json['delivered'] == null
						? null
						: Delivered.fromJson(json['delivered'] as Map<String, dynamic>),
				pending: json['pending'] as int?,
				onGoing: json['onGoing'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'allOrders': allOrders,
				'delivered': delivered?.toJson(),
				'pending': pending,
				'onGoing': onGoing,
			};
}
