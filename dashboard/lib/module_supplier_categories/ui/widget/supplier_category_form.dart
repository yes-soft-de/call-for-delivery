import 'dart:io';

import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_supplier_categories/model/supplier_categories_model.dart';
import 'package:c4d/module_supplier_categories/request/supplier_category_request.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/effect/checked.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SupplierCategoryForm extends StatefulWidget {
  final Function(SupplierCategoryRequest) onSave;
  final SupplierCategoryModel? request;
  @override
  _CategoryFormState createState() => _CategoryFormState();

  SupplierCategoryForm({required this.onSave, this.request});
}

class _CategoryFormState extends State<SupplierCategoryForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _decController = TextEditingController();

  int? id;
  String? imagePath;
  String? imageSource;
  bool status = true;

  @override
  void initState() {
    super.initState();

    if (widget.request != null) {
      print('notNull');
      _nameController.text = widget.request?.name ?? '';
      _decController.text = widget.request?.description ?? '';
      id = widget.request?.id ?? -1;
      imagePath = widget.request?.image ?? '';
      imageSource = widget.request?.imageSource ?? '';
      status = widget.request?.status ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context, title: S.of(context).addCategory),
      body: StackedForm(
          visible: true,
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
                        S.current.categoryName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomFormField(
                      controller: _nameController,
                      hintText: S.current.category,
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
                        S.current.categoryImage,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ImagePicker()
                            .pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 70,
                        )
                            .then((value) {
                          if (value != null) {
                            imagePath = value.path;
                            setState(() {});
                          }
                        });
                      },
                      child: Checked(
                        child: Icon(
                          Icons.image,
                          size: 125,
                        ),
                        checked: imagePath != null,
                        checkedWidget: SizedBox(
                            height: 250,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: imagePath?.contains('http') == true
                                    ? Image.network(imagePath ?? '')
                                    : Image.file(
                                        File(imagePath ?? ''),
                                        fit: BoxFit.scaleDown,
                                      ))),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ]),
            ),
          ),
          label: S.current.save,
          onTap: () {
            if (_key.currentState!.validate() && imagePath != null) {
              if (imagePath!.contains('http')) {
                imagePath = imageSource;
              }
              Navigator.pop(context);
              widget.onSave(SupplierCategoryRequest(
                  name: _nameController.text,
                  description: _decController.text,
                  id: id,
                  image: imagePath,
                  status: status));
            } else {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.pleaseCompleteTheForm)
                  .show(context);
            }
          }),
    );
  }
}
