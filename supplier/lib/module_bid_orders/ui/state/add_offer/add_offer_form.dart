import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/model/cars/cars_model.dart';
import 'package:c4d/module_bid_orders/request/add_offer_request.dart';
import 'package:c4d/module_bid_orders/ui/screens/add_offer_screen.dart';
import 'package:c4d/module_bid_orders/ui/widgets/chip_choose.dart';
import 'package:c4d/module_bid_orders/ui/widgets/label_text.dart';
import 'package:c4d/module_profile/ui/widget/init_field/init_field.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';


class AddOfferLoadedState extends States {
  final List<CarsModel> cars;
  final AddOfferScreenState screenState;
  AddOfferLoadedState(
      this.screenState, {
        required this.cars,
      }) : super(screenState) {
  }

  final _priceController =TextEditingController();
  final _deController =TextEditingController();

  @override
  Widget getUI(BuildContext context) {


    return  StackedForm(
      child:     CustomListView.custom(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomFormField(
              controller:_priceController,
              hintText: S.of(context).price,
              numbers: true,
              sufIcon:Icon(FontAwesomeIcons.coins,color: Theme.of(context).primaryColor,) ,
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).backgroundColor,
              ),
              child: Material(
                color: Colors.transparent,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  onTap: () {
                    _showDatePicker(context);

//                    showDatePicker(
//                        context: context,
//                        builder: (context, widget) {
//                          bool isDark =
//                          getIt<ThemePreferencesHelper>()
//                              .isDarkMode();
//
//                          if (isDark == false)
//                            return widget ?? SizedBox();
//                          return Theme(
//                              data: ThemeData.dark().copyWith(
//                                  primaryColor: Colors.indigo),
//                              child: widget ?? SizedBox());
//                        },
//                        initialDate: DateTime.now(),
//                        firstDate: DateTime.now(),
//                        lastDate: DateTime(2023))
//                        .then((value) {
//                      if(value != null)
//                        screenState.offerTime = value.toIso8601String();
//                      screenState.refresh();
//                    });
                  },
                  title: Text(screenState.offerTime != null
                      ? DateFormat('yyyy/M/d  -  HH:mm').format(DateTime.parse(
                      screenState.offerTime ??
                          DateTime.now().toIso8601String()))
                      : S.of(context).deadLine),
                  trailing: Icon(FontAwesomeIcons.solidCalendarAlt ,color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: LabelText(S.of(context).selectTheDeliveryCar),
          ),

          CustomListView.customGrid(children: carsList(),padding: EdgeInsets.all(8)),
        ],
      ),
      label: S.current.save,
      visible: true,
      onTap: (){
        screenState.addOffer(_priceController.text );
      },
    );
  }



  List<Widget> carsList() {
    List<Widget> widgets = [];
    for (CarsModel element in cars) {
      widgets.add(SizedBox(
        width: 150,
        child: ChipChoose(
          title:element.carModel,
          cost: element.cost,
          selected:
          screenState.selectedCardModel == element ? true : false,
          onTap: () {
            screenState.selectedCardModel = element;
            screenState.refresh();
          },
        ),
      ));
    }
    return widgets;
  }
  // Show the modal that contains the CupertinoDatePicker
  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (cont ) {
          return Container(
            height: 400,
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: CupertinoDatePicker(
                    backgroundColor: Theme.of(ctx).cardColor,
                      initialDateTime: DateTime.now(),
//                      minimumDate: DateTime.now(),
                      maximumYear: 2023,
                      onDateTimeChanged: (val) {
                        screenState.refresh();
                        screenState.offerTime = val.toIso8601String();
                      }),
                ),

                // Close the modal
//                CupertinoButton(
//                  child: const Text('OK'),
//                  onPressed: () => Navigator.of(ctx).pop(),
//                )
              ],
            ),
          );
        });
}
}