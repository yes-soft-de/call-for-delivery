import 'datum.dart';

class SubscriptionsResponse {
  List<Datum>? oldSubscription;
  List<Datum>? futureAndCurrentSubscription;

  SubscriptionsResponse(
      {this.futureAndCurrentSubscription, this.oldSubscription});

  factory SubscriptionsResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionsResponse(
      futureAndCurrentSubscription:
          (json['currentAndFutureSubscriptions'] as List<dynamic>?)
              ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
              .toList(),
      oldSubscription: (json['oldSubscriptions'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
