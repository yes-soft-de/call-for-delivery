import 'last_three_active_store.dart';

class CountStores {
  int? active;
  int? inactive;
  List<LastThreeActiveStore>? lastThreeActiveStores;

  CountStores({this.active, this.inactive, this.lastThreeActiveStores});

  factory CountStores.fromJson(Map<String, dynamic> json) => CountStores(
        active: json['active'] as int?,
        inactive: json['inactive'] as int?,
        lastThreeActiveStores: (json['lastThreeActiveStores'] as List<dynamic>?)
            ?.map(
                (e) => LastThreeActiveStore.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'inactive': inactive,
        'lastThreeActiveStores':
            lastThreeActiveStores?.map((e) => e.toJson()).toList(),
      };
}
