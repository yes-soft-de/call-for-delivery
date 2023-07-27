// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/selectable_item.dart';
import 'package:flutter/material.dart';

enum AddDistanceType {
  addKilometer,
  addCoordinates,
  addCoordinatesViaLink,
}

class Coordinates {
  num? lat;
  num? lon;

  Coordinates({
    required this.lat,
    required this.lon,
  });
}

Color get _red => Colors.red;
Color get _black => Colors.black;
Color get _yellow => Color(0xffFFD43A);

class AddDistanceDialog extends StatefulWidget {
  final Function(num kilometer) onKilometerAdd;
  final Function(Coordinates coordinates) onCoordinatesAdd;

  const AddDistanceDialog(
      {super.key,
      required this.onKilometerAdd,
      required this.onCoordinatesAdd});

  @override
  State<AddDistanceDialog> createState() => _AddDistanceDialogState();
}

class _AddDistanceDialogState extends State<AddDistanceDialog> {
  var type = AddDistanceType.addKilometer;
  var key = GlobalKey<FormState>();
  var kilometerController = TextEditingController();
  var coordinatesController = TextEditingController();
  var linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.current.editDistance,
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 10),
              // selectable items
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SelectableItem(
                          onTap: () {
                            type = AddDistanceType.addKilometer;
                            setState(() {});
                          },
                          selectedValue: type,
                          title: S.current.editKilometer,
                          value: AddDistanceType.addKilometer,
                        ),
                        SelectableItem(
                          onTap: () {
                            type = AddDistanceType.addCoordinates;
                            setState(() {});
                          },
                          selectedValue: type,
                          title: S.current.editCoordinates,
                          value: AddDistanceType.addCoordinates,
                        ),
                        // SelectableItem(
                        //   onTap: () {
                        //     type = AddDistanceType.addCoordinatesViaLink;
                        //     setState(() {});
                        //   },
                        //   selectedValue: type,
                        //   title: S.current.enterLink,
                        //   value: AddDistanceType.addCoordinatesViaLink,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              // filed
              Column(
                children: [
                  // kilometer filed
                  Visibility(
                    visible: type == AddDistanceType.addKilometer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(S.current.kiloMeterNumber),
                        ),
                        CustomFormField(
                          hintText: '10',
                          controller: kilometerController,
                          numbers: true,
                          validator: type == AddDistanceType.addKilometer,
                        ),
                      ],
                    ),
                  ),
                  // Coordinates filed
                  Visibility(
                    visible: type == AddDistanceType.addCoordinates,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(S.current.newCoordinates),
                        ),
                        CustomFormField(
                          hintText: '12,34',
                          controller: coordinatesController,
                          validator: type == AddDistanceType.addCoordinates,
                          validatorFunction: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.split(',').length != 2) {
                              return S.current.pleaseCompleteField;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: _red),
                        child: Text(S.current.cancel),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(backgroundColor: _yellow),
                        child: Text(
                          S.current.updateDistance,
                          style: textTheme.bodyMedium?.copyWith(color: _black),
                        ),
                        onPressed: () {
                          if (key.currentState?.validate() ?? false) {
                            if (type == AddDistanceType.addKilometer) {
                              widget.onKilometerAdd(
                                  num.tryParse(kilometerController.text) ?? 0);
                            }
                            if (type == AddDistanceType.addCoordinates) {
                              var co = coordinatesController.text.split(',');
                              var lat = num.tryParse(co[0]);
                              var lon = num.tryParse(co[1]);
                              var coo = Coordinates(lat: lat, lon: lon);
                              widget.onCoordinatesAdd(coo);
                            }
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
