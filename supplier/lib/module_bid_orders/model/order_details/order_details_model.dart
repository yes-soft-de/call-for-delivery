import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/model/order_details/offer_model.dart';
import 'package:c4d/module_bid_orders/response/order_details_response/order_details_reponse.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/offer_status_helper.dart';
import 'package:intl/intl.dart';

class OrderDetailsModel extends DataModel {
  late int id;
  late String description;
  late String createdDate;
  late String title;
  late List<String> images;
  late List<OfferModel> offers;
  late bool openToPriceOffer;

  OrderDetailsModel({
    required this.description,
    required this.title,
    required this.createdDate,
    required this.id,
    required this.offers,
    required this.images,
   required this.openToPriceOffer

  });

 late OrderDetailsModel _detailsModel;

  OrderDetailsModel.withData(OrderDetailsResponse response) {
    var data = response.data;
    List<OfferModel>  _offersModel = [];
    List<String>  imagesList = [];
    data?.images?.forEach((element) {
      imagesList.add(element.image ?? '');
    });
    data?.offers?.forEach((element) {
      var create = DateFormat.jm()
          .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));

      var deadLine =
          DateFormat.Md()
              .format(DateHelper.convert(element.offerDeadline?.timestamp));
      _offersModel.add(OfferModel(
          createAt: create,
          id: element.id ?? -1,
          priceOfferValue: element.priceOfferValue ?? 0,
          priceOfferStatus:
          OfferStatusHelper.getOfferEnum(element.priceOfferStatus ?? ''),
          offerDeadline: deadLine));
    });


    var createOrder = DateFormat.jm()
        .format(DateHelper.convert(data?.createdAt?.timestamp)) +
        ' 📅 ' +
        DateFormat.Md()
            .format(DateHelper.convert(data?.createdAt?.timestamp));
    _detailsModel = OrderDetailsModel(
      id: data?.id ?? 1,
      description: data?.description ?? S.current.unknown,
      offers: _offersModel  ,
      title: data?.title ?? S.current.unknown,
      createdDate: createOrder,
      images: imagesList,
      openToPriceOffer: data?.openToPriceOffer ?? false
    );
  }
  OrderDetailsModel get data => _detailsModel;
}


