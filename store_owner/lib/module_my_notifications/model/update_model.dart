import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_my_notifications/response/update_response/update_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:intl/intl.dart';

class UpdateModel extends DataModel {
  late int id;
  late String title;
  late String msg;
  late String date;
  late List<String> images;
  bool marked = false;

  List<UpdateModel> _model = [];
  UpdateModel({
    required this.id,
    required this.title,
    required this.msg,
    required this.date,
    required this.marked,
    required this.images,
  });

  UpdateModel.fromList(List<UpdateModel> updateModel) {
    updateModel.forEach((element) {
      _model.add(element);
    });
  }

  UpdateModel.withData(UpdateResponse response) {
    var data = response.data;

    data?.forEach((element) {
      String date = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));
      _model.add(UpdateModel(
        id: element.id ?? -1,
        title: element.title ?? '',
        msg: element.msg ?? '',
        date: date,
        marked: false,
        images: element.images ?? [],
      ));
    });
  }
  List<UpdateModel> get data => _model;
}
