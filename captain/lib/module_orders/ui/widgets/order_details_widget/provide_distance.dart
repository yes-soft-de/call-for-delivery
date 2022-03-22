import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';

class ProvideDistance extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) callBack;
  const ProvideDistance(
      {Key? key, required this.controller, required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomFormField(
            hintText: '${S.of(context).finishOrderProvideDistanceInKm} e.g 45',
            controller: controller,
            numbers: true,
            last: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green[700],
            ),
            child: IconButton(
                padding: EdgeInsets.zero,
                splashRadius: 20,
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    callBack(controller.text);
                  } else {
                    CustomFlushBarHelper.createError(
                            title: S.current.warnning,
                            message: S.of(context).pleaseProvideTheDistance)
                        .show(context);
                  }
                }),
          ),
        ),
      ],
    );
  }
}
