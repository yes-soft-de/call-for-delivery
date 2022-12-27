import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_supplier/response/supplier_ads_response/ads_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:intl/intl.dart';

class SupplierAdsModel extends DataModel {
  int? id;
  num? price;
  num? quantity;
  String? details;
  bool? status;
  bool? administrationStatus;
  String? createdDate;
  List<String>? images;

  List<SupplierAdsModel> _model = [];

  SupplierAdsModel(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.details,
      this.images,
      this.status,
      this.administrationStatus,
      this.createdDate});

  SupplierAdsModel.withData(AdsResponse response) : super.withData() {
    var data = response.data;
    _model = [];
    data?.forEach((element) {
      var create = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      _model.add(SupplierAdsModel(
          id: element.id,
          details: element.details,
          price: element.price,
          quantity: element.quantity,
          status: element.status,
          administrationStatus: element.administrationStatus,
          createdDate: create));
    });
  }
  List<SupplierAdsModel> get data => _model;
}
