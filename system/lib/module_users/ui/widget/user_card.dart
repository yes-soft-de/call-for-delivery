import 'package:c4d/module_users/model/users_model.dart';
import 'package:c4d/utils/helpers/role_status_helper.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserCard extends StatelessWidget {
  final UsersModel usersModel;
  final VoidCallback updatePassword;


  UserCard({required this.usersModel,required this.updatePassword});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3.0,
       color: StatusRoleHelper.getRoleColor(usersModel.role!),
        child:
          Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Image.asset(ImageAsset.PROFILE,height: 40,),
              InkWell(
                  onTap: updatePassword,
                  child: Icon(FontAwesomeIcons.edit,color: Colors.black,))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Icon(FontAwesomeIcons.addressCard),
              SizedBox(width: 10,),
              Text(usersModel.userID)
            ],),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Icon(FontAwesomeIcons.volumeUp),
              SizedBox(width: 10,),
              Text(StatusRoleHelper.getOrderStatusMessages(usersModel.role))
            ],),
          ),
        ],),
      ),),
    );
  }
}
