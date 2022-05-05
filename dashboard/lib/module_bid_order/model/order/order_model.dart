import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';

import '../../response/orders_response/orders_response.dart';

class OrderModel extends DataModel {
  late int id;
  late int bidDetailsId;
  late String description;
  late String createdDate;
  late String title;
  late bool openToPriceOffer;
  late OrderStatusEnum orderState;

  OrderModel({
    required this.description,
    required this.title,
    required this.createdDate,
    required this.id,
    required this.openToPriceOffer,
    required this.bidDetailsId,
    required this.orderState
  });
  List<OrderModel> _orders = [];
  OrderModel.withData(OrdersResponse response) {
    var data = response.data;
    data?.forEach((element) {
      // date formatter
      // created At
      var create = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      _orders.add(new OrderModel(
          description: element.description ?? S.current.unknown,
          createdDate: create,
          id: element.id ?? -1,
          title: element.title ??  S.current.unknown,
          openToPriceOffer: element.openToPriceOffer ?? false,
        bidDetailsId: element.bidDetailsId ?? -1,
        orderState: StatusHelper.getStatusEnum(element.state)

      ));
    });
  }
  List<OrderModel> get data => _orders;
}
