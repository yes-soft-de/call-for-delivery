import 'store.dart';

class StoresCounts {
  int? active;
  int? inactive;
  List<Store>? lastThreeActive;
  List<Store>? lastFiveCreatedOrderStores;

  StoresCounts({
    this.active,
    this.inactive,
    this.lastThreeActive,
    this.lastFiveCreatedOrderStores,
  });

  factory StoresCounts.fromJson(Map<String, dynamic> json) => StoresCounts(
        active: json['active'] as int?,
        inactive: json['inactive'] as int?,
        // lastThreeActive: (json['lastThreeActive'] as List<dynamic>?)
        //     ?.map((e) => Store.fromJson(e as Map<String, dynamic>))
        //     .toList(),
        lastFiveCreatedOrderStores: (json['lastFiveCreatedOrderStores'] as List<dynamic>?)
            ?.map((e) => Store.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'inactive': inactive,
        'lastThreeActive': lastThreeActive?.map((e) => e.toJson()).toList(),
        'lastFiveCreatedOrderStores':
            lastFiveCreatedOrderStores?.map((e) => e.toJson()).toList(),
      };
}
