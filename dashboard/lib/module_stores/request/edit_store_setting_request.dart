// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EditStoreSettingRequest {
  int id;
  int storeOwnerProfile;
  int subscriptionCostLimit;

  EditStoreSettingRequest({
    required this.id,
    required this.storeOwnerProfile,
    required this.subscriptionCostLimit,
  });

  EditStoreSettingRequest copyWith({
    int? id,
    int? storeOwnerProfile,
    int? subscriptionCostLimit,
  }) {
    return EditStoreSettingRequest(
      id: id ?? this.id,
      storeOwnerProfile: storeOwnerProfile ?? this.storeOwnerProfile,
      subscriptionCostLimit:
          subscriptionCostLimit ?? this.subscriptionCostLimit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      if (storeOwnerProfile != null) 'storeOwnerProfile': storeOwnerProfile,
      if (subscriptionCostLimit != null)
        'subscriptionCostLimit': subscriptionCostLimit,
    };
  }

  factory EditStoreSettingRequest.fromMap(Map<String, dynamic> map) {
    return EditStoreSettingRequest(
      id: (map['id'] ?? 0) as int,
      storeOwnerProfile: (map['storeOwnerProfile'] ?? 0) as int,
      subscriptionCostLimit: (map['subscriptionCostLimit'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditStoreSettingRequest.fromJson(String source) =>
      EditStoreSettingRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'EditStoreSettingRequest(id: $id, storeOwnerProfile: $storeOwnerProfile, subscriptionCostLimit: $subscriptionCostLimit)';

  @override
  bool operator ==(covariant EditStoreSettingRequest other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.storeOwnerProfile == storeOwnerProfile &&
        other.subscriptionCostLimit == subscriptionCostLimit;
  }

  @override
  int get hashCode =>
      id.hashCode ^ storeOwnerProfile.hashCode ^ subscriptionCostLimit.hashCode;
}
