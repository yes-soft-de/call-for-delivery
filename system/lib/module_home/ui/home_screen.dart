import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_check_api/check_api_routes.dart';
import 'package:c4d/module_home/widget/home_card.dart';
import 'package:c4d/module_users/users_routes.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade200,
                Colors.grey.shade50,

               ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Text('SYSTEM APP',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),)
                              ],),
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.sms,color: Colors.white,),
                                SizedBox(width: 20,),
                                Icon(Icons.notifications_active,color: Colors.white,),
                              ],
                            )
                          ],),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 8,top: 25),
                            child: ListTile(
                              leading: Image.asset(ImageAsset.PROFILE),
                              title: Text('Super Admin',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),),subtitle: Text('you can manage C4D',style: TextStyle(color: Colors.white,fontSize: 13),),
                            ),
                          ),
                          SizedBox(height: 30,),
                        ],
                      ),
                    ),
                  ),
                ),
                Wrap(
                  children: [
                  HomeCard(title: S.of(context).checkServer,image: ImageAsset.CHECK_SERVER,onTap: (){
                    Navigator.pushNamed(context, CheckApiRoutes.ROUTE_CheckApi);
                  },),
                  HomeCard(title: S.of(context).changePassword,image: ImageAsset.PASSWORD,onTap: (){},),
                ],),
                Wrap(
                  children: [
                  HomeCard(title: S.of(context).manageMessages,image: ImageAsset.MESSAGES,onTap: (){},),
                    HomeCard(title: S.of(context).manageUser,image: ImageAsset.USERS,onTap: (){
                      Navigator.pushNamed(context, UsersRoutes.VIEW_ALL);
                    },),
                ],),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

