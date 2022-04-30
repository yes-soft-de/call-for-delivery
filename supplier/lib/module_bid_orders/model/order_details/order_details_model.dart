import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/model/order_details/offer_model.dart';
import 'package:c4d/module_bid_orders/response/order_details_response/order_details_reponse.dart';
import 'package:c4d/module_bid_orders/response/order_details_response/order_logs_response/data.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/offer_status_helper.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';

class OrderDetailsModel extends DataModel {
  late int id;
  late String description;
  late String createdDate;
  late String? deliveryDate;
  late String title;
  late String payment;
  late List<String> images;
  late List<OfferModel> offers;
  late bool openToPriceOffer;
  late OrderStatusEnum orderState;
  late OrderTimeLine? orderLogs;
  OrderDetailsModel({
    required this.description,
    required this.title,
    required this.createdDate,
    required this.id,
    required this.offers,
    required this.images,
   required this.openToPriceOffer,
   required this.orderState,
    this.deliveryDate,
   required this.payment,
    this.orderLogs

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

    var deliveryDate = DateFormat.jm()
        .format(DateHelper.convert(data?.deliveryDate?.timestamp)) +
        ' 📅 ' +
        DateFormat.Md()
            .format(DateHelper.convert(data?.deliveryDate?.timestamp));
    _detailsModel = OrderDetailsModel(
      id: data?.id ?? 1,
      description: data?.description ?? S.current.unknown,
      offers: _offersModel  ,
      title: data?.title ?? S.current.unknown,
      createdDate: createOrder,
      images: imagesList,
      openToPriceOffer: data?.openToPriceOffer ?? false,
        orderState: StatusHelper.getStatusEnum(data?.state),
        deliveryDate: deliveryDate,
        payment: data?.payment ?? S.current.unknown,
        orderLogs: _getOrderLogs(data?.orderLogs)
    );
  }
  OrderTimeLine? _getOrderLogs(OrderLogsResponse? orderLogs) {
    if (orderLogs == null) {
      return null;
    }
    List<Step> steps = [];
    orderLogs.orderLogs?.logs?.forEach((element) {
      // step date
      var stepDate = DateFormat.jm()
          .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.yMd()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      steps.add(Step(
          state: StatusHelper.getStatusEnum(element.orderState),
          date: stepDate));
    });
    steps = steps.reversed.toList();
    OrderTimeLine orderTimeLine = OrderTimeLine(
        steps: steps,
        completionTime: orderLogs.orderLogs?.orderState?.completionTime,
        currentState: StatusHelper.getStatusEnum(
            orderLogs.orderLogs?.orderState?.currentStage));
    return orderTimeLine;
  }
  OrderDetailsModel get data => _detailsModel;
}
class OrderTimeLine {
  String? completionTime;
  OrderStatusEnum currentState;
  List<Step> steps;
  OrderTimeLine(
      {this.completionTime, required this.steps, required this.currentState});
}

class Step {
  OrderStatusEnum state;
  String date;
  Step({
    required this.state,
    required this.date,
  });
}


