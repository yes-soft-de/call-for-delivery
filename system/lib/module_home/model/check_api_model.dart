import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_home/response/check_api.dart';

class CheckApiModel extends DataModel {
String result = '';

CheckApiModel? _model;

CheckApiModel(
    {required this.result,
    });

CheckApiModel.withData(Data data) : super.withData() {
  _model = CheckApiModel(
    result: data.result ?? '',
  );
}

CheckApiModel get data {
  if (_model != null) {
    return _model!;
  }
  else {
    throw Exception('There is no data');
  }
}
}