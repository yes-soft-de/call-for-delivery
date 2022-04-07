import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';

import '../response/notice_response.dart';

class NoticeModel extends DataModel {
  String? msg = '';
  String? title = '';
  String? appType = '';

  int id = -1;

  List<NoticeModel> _model = [];

  NoticeModel(
      {required this.title,
      required this.id,
      required this.msg,
      required this.appType});

  NoticeModel.withData(List<Data> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(NoticeModel(
          id: element.id ?? -1,
          title: element.title,
          appType: element.appType,
          msg: element.msg));
    }
  }
  List<NoticeModel> get data => _model;
}
