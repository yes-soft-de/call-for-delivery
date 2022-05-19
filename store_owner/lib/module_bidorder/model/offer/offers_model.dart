import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/offer_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bidorder/response/offer/offer_response.dart';
import 'package:c4d/utils/helpers/offer_status_helper.dart';
import 'package:intl/intl.dart';

import '../../../utils/helpers/date_converter.dart';

class OfferModel extends DataModel {
  late int id;
  late OfferStatusEnum state;
  late String details;

  late String deliveryDate;
  late String createdDate;

  num priceOfferValue = 0;
  late num transportationCount;
  num totalDeliveryCost = 0;
  num profitMargin = 0;
  late num totalPrice;

  late String carModel;

  OfferModel(
      {required this.details,
      required this.state,
      required this.totalDeliveryCost,
      required this.deliveryDate,
      required this.createdDate,
      required this.id,
      required this.priceOfferValue,
      required this.carModel,
      required this.transportationCount,
      required this.profitMargin,
      required this.totalPrice});
  List<OfferModel> _orders = [];
  OfferModel.withData(OffersResponse response) {
    var data = response.data;
    data?.forEach((element) {
      // date formatter
      // created At
      var create = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      // delivery date
      var delivery = DateFormat.jm()
              .format(DateHelper.convert(element.deliveryDate?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.deliveryDate?.timestamp));
      //
      _orders.add(new OfferModel(
          details: element.details ?? S.current.unknown,
          createdDate: create,
          deliveryDate: delivery,
          id: element.id ?? -1,
          totalDeliveryCost: element.totalDeliveryCost ?? 0,
          carModel: element.carModel ?? S.current.unknown,
          priceOfferValue: element.priceOfferValue ?? 0,
          profitMargin: element.profitMargin ?? 0,
          transportationCount: element.transportationCount ?? 0,
          totalPrice: _getTotalPrice(element),
          state:
              OfferStatusHelper.getOfferEnum(element.priceOfferStatus ?? '')));
    });
  }
  List<OfferModel> get data => _orders;

  num _getTotalPrice(Data m) {
    return m.priceOfferValue! + m.totalDeliveryCost! + m.profitMargin!;
  }
}
