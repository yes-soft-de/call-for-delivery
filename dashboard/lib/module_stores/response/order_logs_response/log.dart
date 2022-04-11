import 'created_at.dart';

class Log {
  int? id;
  CreatedAt? createdAt;
  String? orderState;
  bool? isCaptainArrived;

  Log({this.id, this.createdAt, this.orderState, this.isCaptainArrived});

  factory Log.fromJson(Map<String, dynamic> json) => Log(
        id: json['id'] as int?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        orderState: json['orderState'] as String?,
        isCaptainArrived: json['isCaptainArrived'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt?.toJson(),
        'orderState': orderState,
      };
}
