import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';

import '../response/captain_rating_response/captain_rating_response.dart';

class CaptainRatingModel extends DataModel {
  late int id;
  late String captainName;
  late String rating;
  late String image;

  List<CaptainRatingModel> _data = [];
  CaptainRatingModel({
    required this.id,
    required this.captainName,
    required this.rating,
    required this.image,
  });
  CaptainRatingModel.withData(CaptainRatingResponse response) {
    var datum = response.data;
    datum?.forEach((element) {
      _data.add(CaptainRatingModel(
        id: element.id ?? -1,
        captainName: element.captainName ?? S.current.unknown,
        image: element.image?.image ?? '',
        rating: element.avgRating ?? '0',
      ));
    });
  }
  List<CaptainRatingModel> get data => _data;
}
