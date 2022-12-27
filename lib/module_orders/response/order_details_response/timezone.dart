import 'location.dart';
import 'transition.dart';

class Timezone {
  String? name;
  List<Transition>? transitions;
  Location? location;

  Timezone({this.name, this.transitions, this.location});

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'transitions': transitions?.map((e) => e.toJson()).toList(),
        'location': location?.toJson(),
      };
}
