import 'package:c4d/utils/effect/op_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/effect/hidder.dart';

class CustomLoginFormField extends StatefulWidget {
  final double? height;
  final EdgeInsetsGeometry contentPadding;
  final String? hintText;
  final Widget? preIcon;
  final Widget? sufIcon;
  final TextEditingController? controller;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final bool last;
  final bool password;
  final bool phone;
  final double? borderRadius;
  final bool validator;
  final bool phoneHint;
  final TextStyle? style;
  @override
  _CustomLoginFormFieldState createState() => _CustomLoginFormFieldState();

  const CustomLoginFormField(
      {this.height,
      this.contentPadding = const EdgeInsets.fromLTRB(16, 0, 16, 0),
      this.hintText,
      this.preIcon,
      this.sufIcon,
      this.controller,
      this.readOnly = false,
      this.onTap,
      this.last = false,
      this.password = false,
      this.phone = false,
      this.borderRadius,
      this.validator = true,
      this.phoneHint = true,
      this.style
      });
}

class _CustomLoginFormFieldState extends State<CustomLoginFormField> {
  AutovalidateMode mode = AutovalidateMode.disabled;
  bool showPassword = false;
  bool clean = true;
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
            color: Theme.of(context).backgroundColor,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      !clean ? EdgeInsets.only(bottom: 8.0) : EdgeInsets.zero,
                  child: SizedBox(
                    height: widget.height,
                    child: TextFormField(
                      style: widget.style,
                      autovalidateMode: mode,
                      onChanged: (s) {
                        setState(() {});
                      },
                      toolbarOptions: ToolbarOptions(
                          copy: true, paste: true, selectAll: true, cut: true),
                      validator: widget.validator
                          ? (value) {
                              if (mode == AutovalidateMode.disabled) {
                                setState(() {
                                  mode = AutovalidateMode.onUserInteraction;
                                });
                              }
                              if (value == null) {
                                clean = false;
                                return S.of(context).pleaseCompleteField;
                              } else if (value.isEmpty) {
                                clean = false;
                                return S.of(context).pleaseCompleteField;
                              } else if (value.length < 6 && widget.password) {
                                clean = false;
                                return S.of(context).passwordIsTooShort;
                              } else if (widget.phone && value.length < 9) {
                                clean = false;
                                return S.of(context).phoneNumbertooShort;
                              } else if (widget.phone && value.length > 9) {
                                return S.current.phoneNumberLong;
                              } else {
                                clean = true;
                                return null;
                              }
                            }
                          : null,
                      onTap: widget.onTap,
                      controller: widget.controller,
                      readOnly: widget.readOnly,
                      keyboardType: widget.phone ? TextInputType.phone : null,
                      inputFormatters: widget.phone
                          ? <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp('^[5|9][0-9]*')),
                            ]
                          : [],
                      obscureText: widget.password && !showPassword,
                      onEditingComplete:
                          widget.last ? null : () => node.nextFocus(),
                      onFieldSubmitted:
                          widget.last ? (_) => node.unfocus() : null,
                      textInputAction:
                          widget.last ? null : TextInputAction.next,
                      maxLength: widget.phone ? 9 : null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                        hintText: widget.hintText,
                        prefixIcon: widget.preIcon,
                        enabledBorder: InputBorder.none,
                        contentPadding: widget.contentPadding,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              OptionalWidget(
                effect: widget.password,
                effectiveWidget: IconButton(
                  splashRadius: 18,
                    splashColor: Theme.of(context).colorScheme.secondaryContainer,
                    onPressed: () {
                      if (showPassword) {
                        showPassword = false;
                      } else {
                        showPassword = true;
                      }
                      setState(() {});
                    },
                    icon: Icon(!showPassword
                        ? Icons.remove_red_eye_rounded
                        : Icons.visibility_off_rounded,color: Theme.of(context).disabledColor,)),
                widget: widget.sufIcon,
              )
            ],
          ),
        ),
        Hider(
          active: widget.phoneHint && widget.phone,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                '${widget.controller?.text.length ?? 0}/9',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Theme.of(context).disabledColor),
              ),
            ),
          ),
        )
      ],
    );
  }
}
