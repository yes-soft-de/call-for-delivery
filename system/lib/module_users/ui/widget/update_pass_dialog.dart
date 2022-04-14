import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String title;
  final String titleAction;
  final String hintText;
  final Function updatePass;

  const CustomDialogBox({required this.title,required this.updatePass,required this.titleAction,required this.hintText}) ;

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 12,right: 12,top: 30),
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.title,style: TextStyle(fontWeight: FontWeight.w600),),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomLoginFormField(
                  last: true,
                  controller: passwordController,
                  password: true,
                  contentPadding:
                  const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  hintText: widget.hintText,
                ),
              ),


              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                      widget.updatePass(passwordController.text);
                    },
                    child: Text(widget.titleAction,style: TextStyle(fontSize: 18,color: Theme.of(context).primaryColor),)),
              ),
            ],
          ),
        ),
        Positioned(
          left: 5,
          right: 5,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 30,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image.asset(ImageAsset.PASSWORD)
            ),
          ),
        ),
      ],
    );
  }
}


class CustomSendNotificationDialogBox extends StatefulWidget {
  final Function send;

  const CustomSendNotificationDialogBox({required this.send}) ;

  @override
  _CustomSendNotificationDialogBoxState createState() => _CustomSendNotificationDialogBoxState();
}

class _CustomSendNotificationDialogBoxState extends State<CustomSendNotificationDialogBox> {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 12,right: 12,top: 30),
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(S.of(context).sendNotification,style: TextStyle(fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomLoginFormField(
                    last: true,
                    controller: titleController,
                    contentPadding:
                    const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    hintText: S.of(context).notificationTitle,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomLoginFormField(
                    last: true,
                    controller: messageController,
                    contentPadding:
                    const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    hintText: S.of(context).notificationMessage,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                        widget.send(titleController.text ,messageController.text);
                      },
                      child: Text(S.of(context).send,style: TextStyle(fontSize: 18,color: Theme.of(context).primaryColor),)),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 5,
          right: 5,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 30,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image.asset(ImageAsset.BELL)
            ),
          ),
        ),
      ],
    );
  }
}