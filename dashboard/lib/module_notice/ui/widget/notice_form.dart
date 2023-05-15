import 'package:c4d/consts/app_type.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_notice/model/notice_model.dart';
import 'package:c4d/module_notice/request/notice_request.dart';
import 'package:c4d/module_notice/ui/widget/chip_choose.dart';
import 'package:c4d/module_notice/ui/widget/row_image_picker.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/helpers/app_type_helper.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';

class NoticeForm extends StatefulWidget {
  final Function(NoticeRequest) onSave;
  final NoticeModel? request;
  @override
  _CategoryFormState createState() => _CategoryFormState();

  NoticeForm({required this.onSave, this.request});
}

class _CategoryFormState extends State<NoticeForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _decController = TextEditingController();
  List<NoticeImage> _images = [];

  int? id;
  String appType = '';

  @override
  void initState() {
    super.initState();

    if (widget.request != null) {
      _nameController.text = widget.request?.title ?? '';
      _decController.text = widget.request?.msg ?? '';
      id = widget.request?.id ?? -1;
      appType = widget.request!.appType ?? '';
      _images =
          widget.request?.images?.map((e) => e..toDelete = false).toList() ??
              [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: widget.request == null ? S.current.addAds : S.current.editAds),
      body: StackedForm(
        child: Form(
          key: _key,
          child: FixedContainer(
            child: CustomListView.custom(
                padding: EdgeInsets.only(right: 16, left: 16),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, bottom: 8, right: 12, top: 16.0),
                    child: Text(
                      S.current.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  CustomFormField(
                    controller: _nameController,
                    hintText: S.current.title,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, bottom: 8, right: 12, top: 16.0),
                    child: Text(
                      S.current.description,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  CustomFormField(
                    maxLines: 8,
                    controller: _decController,
                    hintText: S.current.description,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, bottom: 8, right: 12, top: 16.0),
                    child: Text(
                      S.current.image,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    height: 150,
                    width: double.infinity,
                    child: RowImagePicker(
                      initImages: _images,
                      onChange: (images) {
                        _images = images;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, bottom: 8, right: 12, top: 16.0),
                    child: Text(
                      S.current.sendTo,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Wrap(children: appChips(context), spacing: 30),
                  SizedBox(
                    height: 100,
                  ),
                ]),
          ),
        ),
        label: S.current.save,
        onTap: () {
          if (_key.currentState!.validate() && appType.isNotEmpty) {
            Navigator.pop(context);
            widget.onSave(
              NoticeRequest(
                  title: _nameController.text,
                  msg: _decController.text,
                  id: id,
                  appType: appType,
                  images: _images),
            );
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm)
                .show(context);
          }
        },
      ),
    );
  }

  List<Widget> appChips(BuildContext context) {
    List<Widget> widgets = [];
    for (AppTypeEnum element in AppTypeEnum.values) {
      widgets.add(ChipChoose(
        title: AppTypeHelper.getAppTypeMessages(element),
        selected:
            appType == AppTypeHelper.getTypeString(element) ? true : false,
        onTap: () {
          setState(() {
            appType = AppTypeHelper.getTypeString(element);
          });
        },
      ));
    }
    return widgets;
  }
}
