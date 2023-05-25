import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/response/order/order_captain_not_arrived/orders_not_arrived_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:intl/intl.dart';

class OrderCaptainNotArrivedModel extends DataModel {
  late int id;
  late String branchName;
  late String storeName;
  late String captainName;
  late String createdDate;
  OrderCaptainNotArrivedModel(
      {required this.branchName,
      required this.createdDate,
      required this.id,
      required this.captainName,
      required this.storeName});
  List<OrderCaptainNotArrivedModel> _orders = [];
  OrderCaptainNotArrivedModel.withData(OrderCaptainResponse response) {
    var data = response.data;
    data?.forEach((element) {
      // date formatter
      // created At
      var create = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      _orders.add(new OrderCaptainNotArrivedModel(
          branchName: element.branchName ?? S.current.unknown,
          createdDate: create,
          storeName: element.storeOwnerName ?? S.current.unknown,
          id: element.id ?? -1,
          captainName: element.captainName ?? S.current.unknown));
    });
  }
  List<OrderCaptainNotArrivedModel> get data => _orders;
}
