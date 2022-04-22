import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/response/orders_response/orders_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:intl/intl.dart';

class OrderModel extends DataModel {
  late int id;
  late String description;
  late String createdDate;
  late String title;
  late bool openToPriceOffer;
  OrderModel({
    required this.description,
    required this.title,
    required this.createdDate,
    required this.id,
    required this.openToPriceOffer
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
          openToPriceOffer: element.openToPriceOffer ?? false));
    });
  }
  List<OrderModel> get data => _orders;
}
