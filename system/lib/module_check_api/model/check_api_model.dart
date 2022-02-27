import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_check_api/response/check_api.dart';

class CheckApiModel extends DataModel {
String result = '';

CheckApiModel? _model;

CheckApiModel(
    {required this.result,
    });

CheckApiModel.withData(CheckApiResponse data) : super.withData() {
  _model = CheckApiModel(
    result: data.toJson().toString(),
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