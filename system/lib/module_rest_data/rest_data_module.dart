import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_rest_data/rest_data_routes.dart';
import 'package:c4d/module_rest_data/ui/screen/rest_data_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class RestDataModule extends YesModule {
  final RestDataScreen _restDataScreen;
  RestDataModule(this._restDataScreen) {
    YesModule.RoutesMap.addAll({
      RestDataRoutes.ROUTE_REST_DATA: (context) => _restDataScreen,
    });
  }
}
