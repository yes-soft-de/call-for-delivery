import 'package:store_web/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomAuthFiled extends StatefulWidget {
  final String? title;
  final TextEditingController? controller;
  final String? hintText;
  final bool isPhone;
  final IconData? icon;
  final bool isPassword;
  final String? confirmPassword;
  final int? maxLength;
  final bool isLastFiled;
  final bool hidePassword;
  final bool numbers;
  final Function(bool hidePassword)? onHidePassWordChange;
  final String? Function(String?)? validator;
  final void Function(String value)? onChanged;

  const CustomAuthFiled({
    super.key,
    this.title,
    this.controller,
    this.hintText,
    this.isPhone = false,
    this.icon,
    this.isPassword = false,
    this.confirmPassword,
    this.maxLength,
    this.isLastFiled = false,
    this.hidePassword = false,
    this.onHidePassWordChange,
    this.numbers = false,
    this.validator, this.onChanged,
  });

  @override
  State<CustomAuthFiled> createState() => _CustomAuthFiledState();
}

class _CustomAuthFiledState extends State<CustomAuthFiled> {
  AutovalidateMode mode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.title != null,
            child: Text(
              widget.title ?? '',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  maxLength: widget.maxLength,
                  controller: widget.controller,
                  cursorColor: green,
                  autovalidateMode: mode,
                  onChanged: widget.onChanged,
                  validator: (value) {
                    if (mode == AutovalidateMode.disabled) {
                      mode = AutovalidateMode.onUserInteraction;
                    }
                    if (widget.validator != null) {
                      String? v = widget.validator!.call(value);
                      if (v != null) return v;
                    }
                    if (value == null) return S.current.pleaseCompleteField;

                    if (widget.isPhone) {
                      if (value.length < 9) {
                        return S.current.phoneNumbertooShort;
                      }

                      if (value.length > 9) return S.current.phoneNumberLong;

                      if (RegExp(r'[0-9]').allMatches(value).length !=
                          value.length) {
                        return S.current.pleaseEnterValidPhoneNumber;
                      }
                    }
                    if (widget.isPassword) {
                      if (value.length < 6) return S.current.passwordIsTooShort;

                      if (widget.confirmPassword != null &&
                          value != widget.confirmPassword) {
                        return S.current.passwordNotMatch;
                      }
                    }
                    if (widget.maxLength != null &&
                        value.length != widget.maxLength) {
                      return S.current.pleaseCompleteField;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: allFillColor,
                    focusColor: allFillColor,
                    hoverColor: allFillColor,
                    enabledBorder: allInputBorder,
                    focusedBorder: allInputBorder,
                    hintText: widget.hintText,
                    suffixIconConstraints: widget.isPassword
                        ? null
                        : BoxConstraints.loose(Size.zero),
                    suffixIcon: Visibility(
                      visible: widget.isPassword,
                      replacement: const SizedBox(height: 0, width: 0),
                      child: IconButton(
                        onPressed: () {
                          if (widget.onHidePassWordChange != null) {
                            widget.onHidePassWordChange!(!widget.hidePassword);
                          }
                        },
                        icon: Icon(
                          widget.hidePassword
                              ? Icons.remove_red_eye_rounded
                              : Icons.visibility_off_rounded,
                        ),
                      ),
                    ),
                  ),
                  keyboardType: keyboardType,
                  onEditingComplete:
                      widget.isLastFiled ? null : () => node.nextFocus(),
                  onFieldSubmitted:
                      widget.isLastFiled ? (_) => node.unfocus() : null,
                  textInputAction:
                      widget.isLastFiled ? null : TextInputAction.next,
                  obscureText: widget.isPassword && widget.hidePassword,
                ),
              ),
              const SizedBox(width: 5),
              Visibility(
                visible: widget.icon != null,
                child: Icon(
                  widget.icon,
                  size: 25,
                  color: green,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  TextInputType? get keyboardType {
    if (widget.numbers) return TextInputType.number;
    if (widget.isPhone) return TextInputType.phone;
    return null;
  }

  InputBorder get allInputBorder => UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: green,
        ),
      );

  Color get allFillColor => const Color.fromARGB(107, 217, 217, 217);

  Color get green => const Color(0xff03816A);
}
