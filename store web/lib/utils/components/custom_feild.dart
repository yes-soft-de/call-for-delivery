import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_web/di/di_config.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:store_web/module_localization/service/localization_service/localization_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:store_web/utils/global/screen_type.dart';

class CustomFormField extends StatefulWidget {
  final double height;
  final EdgeInsetsGeometry contentPadding;
  final String? hintText;
  final Widget? preIcon;
  final Widget? sufIcon;
  final TextEditingController? controller;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final int? maxLines;
  final bool numbers;
  final bool last;
  final bool validator;
  final bool phone;
  final Function()? onChanged;
  final FormFieldValidator<String>? validatorFunction;
  final TextInputAction? keyAction;
  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();

  const CustomFormField(
      {super.key, this.height = 50,
      this.contentPadding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
      this.hintText,
      this.preIcon,
      this.sufIcon,
      this.controller,
      this.readOnly = false,
      this.onTap,
      this.maxLines,
      this.numbers = false,
      this.last = false,
      this.validator = true,
      this.phone = false,
      this.onChanged,
      this.validatorFunction,
      this.keyAction});
}

class _CustomFormFieldState extends State<CustomFormField> {
  AutovalidateMode mode = AutovalidateMode.disabled;
  bool clean = true;
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Padding(
          padding: !clean ? const EdgeInsets.only(bottom: 8.0) : EdgeInsets.zero,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  autovalidateMode: mode,
                  toolbarOptions: const ToolbarOptions(
                      copy: true, paste: true, selectAll: true, cut: true),
                  onTap: widget.onTap,
                  controller: widget.controller,
                  readOnly: widget.readOnly,
                  maxLines: widget.maxLines ?? 1,
                  cursorHeight:
                      getIt<LocalizationService>().getLanguage() == 'ar' &&
                              kIsWeb
                          ? 16
                          : null,
                  keyboardType: widget.numbers
                      ? const TextInputType.numberWithOptions(decimal: true)
                      : null,
                  onEditingComplete:
                      widget.maxLines != null ? null : () => node.nextFocus(),
                  onFieldSubmitted: widget.maxLines == null && widget.last
                      ? (_) => node.unfocus()
                      : null,
                  textInputAction: widget.maxLines == null && widget.last
                      ? null
                      : (widget.keyAction ?? TextInputAction.next),
                  inputFormatters: widget.numbers
                      ? <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                          FilteringTextInputFormatter.deny(RegExp('[٠-٩]')),
                        ]
                      : [],
                  onChanged: (v) {
                    if (widget.onChanged != null) {
                      widget.onChanged!();
                    }
                    setState(() {});
                  },
                  validator: widget.validatorFunction ?? (widget.validator
                          ? (value) {
                              if (mode == AutovalidateMode.disabled) {
                                setState(() {
                                  mode = AutovalidateMode.onUserInteraction;
                                  clean = false;
                                });
                              }
                              if (value == null) {
                                clean = false;
                                return S.of(context).pleaseCompleteField;
                              } else if (value.isEmpty) {
                                clean = false;
                                return S.of(context).pleaseCompleteField;
                              } else if (widget.numbers &&
                                  num.tryParse(value) == null) {
                                clean = false;
                                return S.current.InvalidInput;
                              } else if (value.length < 8 &&
                                  widget.numbers &&
                                  widget.phone) {
                                clean = false;
                                return S.of(context).phoneNumbertooShort;
                              } else {
                                clean = true;
                                return null;
                              }
                            }
                          : null),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    prefixIcon: widget.preIcon,
                    enabledBorder: InputBorder.none,
                    contentPadding: widget.contentPadding,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              Visibility(
                  child: Material(
                      color: Colors.transparent,
                      child: widget.sufIcon ?? const SizedBox.shrink())),
            ],
          )),
    );
  }
}

class CustomFormFieldWithTranslate extends StatefulWidget {
  final double height;
  final EdgeInsetsGeometry contentPadding;
  final String? hintText;
  final Widget? preIcon;
  final Widget? sufIcon;
  final TextEditingController? controller;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final int? maxLines;
  final bool numbers;
  final bool last;
  final bool validator;
  final bool phone;
  final Function()? onChanged;
  final Function(String)? onSelected;
  final List<String> languages;
  final String initLanguage;
  bool canReChoose;
  @override
  _CustomFormFieldWithTranslateState createState() =>
      _CustomFormFieldWithTranslateState();

  CustomFormFieldWithTranslate(
      {super.key, this.height = 50,
      this.canReChoose = true,
      this.contentPadding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
      this.hintText,
      this.preIcon,
      this.sufIcon,
      this.controller,
      this.readOnly = false,
      this.onTap,
      this.maxLines,
      this.numbers = false,
      this.last = false,
      this.validator = true,
      this.phone = false,
      this.onChanged,
      required this.languages,
      required this.initLanguage,
      this.onSelected});
}

class _CustomFormFieldWithTranslateState
    extends State<CustomFormFieldWithTranslate> {
  AutovalidateMode mode = AutovalidateMode.disabled;
  bool clean = true;
  late bool enabled;
  var lan;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).colorScheme.background,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      !clean ? const EdgeInsets.only(bottom: 8.0) : EdgeInsets.zero,
                  child: TextFormField(
                    autovalidateMode: mode,
                    toolbarOptions: const ToolbarOptions(
                        copy: true, paste: true, selectAll: true, cut: true),
                    onTap: widget.onTap,
                    controller: widget.controller,
                    readOnly: widget.readOnly,
                    maxLines: widget.maxLines ?? 1,
                    cursorHeight:
                        getIt<LocalizationService>().getLanguage() == 'ar' &&
                                kIsWeb
                            ? 16
                            : null,
                    keyboardType: widget.numbers ? TextInputType.phone : null,
                    textInputAction: widget.maxLines == null && widget.last
                        ? null
                        : TextInputAction.next,
                    inputFormatters: widget.numbers
                        ? <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
                          ]
                        : [],
                    onChanged: (v) {
                      if (widget.onChanged != null) {
                        widget.onChanged!();
                      }
                      setState(() {});
                    },
                    validator: widget.validator
                        ? (value) {
                            if (mode == AutovalidateMode.disabled) {
                              setState(() {
                                mode = AutovalidateMode.onUserInteraction;
                                clean = false;
                              });
                            }
                            if (value == null) {
                              clean = false;
                              return S.of(context).pleaseCompleteField;
                            } else if (value.isEmpty) {
                              clean = false;
                              return S.of(context).pleaseCompleteField;
                            } else if (value.length < 8 &&
                                widget.numbers &&
                                widget.phone) {
                              clean = false;
                              return S.of(context).phoneNumbertooShort;
                            } else {
                              clean = true;
                              return null;
                            }
                          }
                        : null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      prefixIcon: widget.preIcon,
                      suffixIcon: widget.sufIcon,
                      enabledBorder: InputBorder.none,
                      contentPadding: widget.contentPadding,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.languages.length > 1,
                replacement: Text(lan),
                child: PopupMenuButton<String>(
                  initialValue: widget.initLanguage,
                  enabled: enabled,
                  onSelected: (c) {
                    if (widget.onSelected != null) {
                      widget.onSelected!(c);
                    }
                    setState(() {
                      lan = c;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Text(lan),
                      enabled ? const Icon(Icons.arrow_drop_down) : Container(),
                    ],
                  ),
                  itemBuilder: (context) => widget.languages
                      .map((c) => PopupMenuItem(value: c, child: Text(c)))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    lan = widget.initLanguage;
    enabled = widget.languages.length == 1 ? false : true;
  }
}
