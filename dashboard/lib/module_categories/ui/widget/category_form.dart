import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_categories/request/package_category_request.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/stacked_form.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';

class CategoryForm extends StatefulWidget {
  final Function(PackageCategoryRequest) onSave;
  final PackagesCategoryModel? request;
  @override
  _CategoryFormState createState() => _CategoryFormState();

  CategoryForm({required this.onSave, this.request});
}

class _CategoryFormState extends State<CategoryForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _decController = TextEditingController();

  int? id;

  @override
  void initState() {
    super.initState();

    if (widget.request != null) {
      print('notNull');
      _nameController.text = widget.request?.categoryName ?? '';
      _decController.text = widget.request?.description ?? '';
      id = widget.request?.id ?? -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context, title: S.of(context).addCategory),
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
                    SizedBox(
                      height: 100,
                    ),
                  ]),
            ),
          ),
          label: S.current.save,
          onTap: () {
            if (_key.currentState!.validate()) {
              Navigator.pop(context);
              widget.onSave(PackageCategoryRequest(
                  name: _nameController.text,
                  description: _decController.text,
                  id: id));
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
