import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/offer_status.dart';
import 'package:c4d/module_bid_orders/response/order_details_response/offer_reponse.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/offer_status_helper.dart';
import 'package:intl/intl.dart';

class OfferModel extends DataModel {
  late int id;
  late num priceOfferValue;
  late OfferStatusEnum priceOfferStatus;
  late String createAt;
  late String offerDeadline;

  OfferModel(
      {required this.createAt,
      required this.priceOfferValue,
      required this.priceOfferStatus,
      required this.id,
      required this.offerDeadline});
}
