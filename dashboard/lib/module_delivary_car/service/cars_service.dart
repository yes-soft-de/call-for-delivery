import 'package:c4d/module_delivary_car/manager/cars_manager.dart';
import 'package:c4d/module_delivary_car/model/car_model.dart';
import 'package:c4d/module_delivary_car/request/car_request.dart';
import 'package:c4d/module_delivary_car/response/cars_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';

@injectable
class CarsService {
  final CarsManager _manager;

  CarsService(this._manager);

  Future<DataModel> getCars() async {
    CarsResponse? _ordersResponse = await _manager.getCars();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return CarsModel.withData(_ordersResponse.data!);
  }

  Future<DataModel> addCars(CarRequest request) async {
    ActionResponse? actionResponse = await _manager.addCars(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
}
