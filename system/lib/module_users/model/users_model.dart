import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/consts/role_status.dart';
import 'package:c4d/module_users/response/users_response.dart';
import 'package:c4d/utils/helpers/role_status_helper.dart';

class UsersModel extends DataModel {
int id = -1;
String userID = '';
RoleEnum? role;

List<UsersModel>? _model;

UsersModel(

    {
     required this.id,
      required this.userID,
     required this.role
    });

UsersModel.withData(List<Data> data) : super.withData() {
  _model = [];
  for(var element in data){
    _model?.add(
        UsersModel(
            id: element.id ?? -1,
            userID: element.userId ?? '',
        role:StatusRoleHelper.getStatusEnum(element.roles?.first ?? '') ));
  }
}

List<UsersModel> get data {
  if (_model != null) {
    return _model!;
  }
  else {
    throw Exception('There is no data');
  }
}
}