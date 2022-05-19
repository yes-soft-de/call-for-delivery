import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bidorder/response/bidorders_response/orders_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:intl/intl.dart';

class BidOrderModel extends DataModel {
  late int id;
  late int bidOrderId;
  late OrderStatusEnum state;
  late String note;
  late String deliveryDate;
  late String createdDate;
  late String branchName;
  late String title;
  late String description;
  late String payment;
  late String supplierCategoryName;
  BidOrderModel(
      {required this.branchName,
      required this.state,
      required this.note,
      required this.deliveryDate,
      required this.createdDate,
      required this.id,
      required this.title,
      required this.description,
      required this.payment,
      required this.bidOrderId,
      required this.supplierCategoryName});
  List<BidOrderModel> _orders = [];
  BidOrderModel.withData(BidOrdersResponse response) {
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
      _orders.add(new BidOrderModel(
          branchName: element.branchName ?? S.current.unknown,
          createdDate: create,
          deliveryDate: delivery,
          id: element.id ?? -1,
          note: element.note ?? '',
          title: element.title ?? '',
          description: element.description ?? '',
          payment: element.payment ?? S.current.unknown,
          bidOrderId: element.bidDetailsId ?? -1,
          supplierCategoryName:
              element.supplierCategoryName ?? S.current.unknown,
          state: StatusHelper.getStatusEnum(element.state)));
    });
  }
  List<BidOrderModel> get data => _orders;
}
