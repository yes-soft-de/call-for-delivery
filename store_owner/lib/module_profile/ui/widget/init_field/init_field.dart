import 'package:c4d/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';

class InitField extends StatelessWidget {
  final IconData icon;
  final String title;
  final TextEditingController controller;
  final String hint;
  final bool last;
  final FormFieldValidator<String>? validator;
  final Function()? onChanged;
  const InitField(
      {Key? key,
      required this.icon,
      required this.title,
      required this.controller,
      required this.hint,
      this.last = false,
      this.validator,
      this.onChanged
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 85, right: 85, top: 8),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 0.0, right: 16.0, left: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CustomFormField(
                  controller: controller,
                  hintText: hint,
                  last: last,
                  validatorFunction: validator,
                  onChanged: onChanged,
                ),
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
