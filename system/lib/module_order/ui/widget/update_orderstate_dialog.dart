import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_users/ui/widget/chip_choose.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';


class UpdateOrderInit extends StatefulWidget{
  final String title;
  final Function updateState;
  bool loading;


  UpdateOrderInit(  {required this.title,required this.updateState ,required this.loading}) ;

  @override
  State<UpdateOrderInit> createState() => _UpdateOrderInitState();
}

class _UpdateOrderInitState extends State<UpdateOrderInit> {
  TextEditingController idController = TextEditingController();

  String orderState = StatusHelper.getStatusString( OrderStatusEnum.WAITING);

  @override
  Widget build(BuildContext context) {
    // TODO: implement getUI
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomFormField(
                  last: true,
                  controller: idController,
                  contentPadding:
                  const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  hintText: 'Order ID',
                  numbers: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(S.of(context).state,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
              ),

              Wrap(
                spacing: 6,
                direction: Axis.horizontal,
                children: stateChips(context),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: TextStyle(color: Colors.white),
                          primary: Theme.of(context).primaryColor
                        ),
                        onPressed: (){
                          if(idController.text.isNotEmpty){
                            widget.loading = true;
                            setState(() {
                            });
                            widget.updateState(idController.text,orderState);
                          }
                        },
                        child:

                        widget.loading ? SizedBox(
                          height: 30,
                          child: LoadingIndicator(
                            indicatorType:
                            Indicator.ballTrianglePathColoredFilled,
                            colors: [Colors.white],
                          ),
                        ): Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(S.of(context).update,style: TextStyle(fontSize: 18,color: Colors.white),),
                        )),
                  ),
                ],
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
                child: Image.asset(ImageAsset.ORDER)
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> stateChips(BuildContext context) {
    List<Widget> widgets = [];
    for (OrderStatusEnum element in OrderStatusEnum.values) {
      widgets.add(
          ChipChoose(title: StatusHelper.getOrderStatusMessages(element),
            selected:orderState == StatusHelper.getStatusString(element) ? true : false,
            onTap: (){
            setState(() {

            });
              orderState =StatusHelper.getStatusString(element) ;
            },
          ));
    }
    return widgets;
  }
}


