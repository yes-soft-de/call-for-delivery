import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';

import '../response/captain_rating_response/captin_rating_details_response.dart';

class CaptainRatingDetailsModel extends DataModel {
  late int id;
  late String comment;
  late int rating;
  late String storeOwnerName;
  late int orderID;

  List<CaptainRatingDetailsModel> _data = [];
  CaptainRatingDetailsModel({
    required this.id,
    required this.comment,
    required this.rating,
    required this.storeOwnerName,
    required this.orderID,
  });
  CaptainRatingDetailsModel.withData(CaptinRatingDetailsResponse response) {
    var datum = response.data;
    datum?.forEach((element) {
      _data.add(CaptainRatingDetailsModel(
          id: element.id ?? -1,
          comment: element.comment ?? S.current.unknown,
          storeOwnerName: element.storeOwnerName ?? '',
          rating: element.rating ?? 0,
          orderID: element.orderId ?? 0));
    });
  }
  List<CaptainRatingDetailsModel> get data => _data;
}
