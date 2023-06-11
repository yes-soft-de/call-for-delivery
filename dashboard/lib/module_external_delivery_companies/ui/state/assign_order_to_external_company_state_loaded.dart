import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/company_model.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/assign_order_to_external_company_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/selectable_item.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/show_confirm_dialog.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';

class AssignOrderToExternalCompanyStateLoaded extends States {
  final AssignOrderToExternalCompanyScreenState _screenState;
  final List<CompanyModel> _companies;
  CompanyModel? pikedCompany;

  AssignOrderToExternalCompanyStateLoaded(this._screenState, this._companies)
      : super(_screenState);

  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(S.current.pickCompany),
            SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.7,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SelectableItem<CompanyModel>(
                        onTap: () {
                          pikedCompany = _companies[index];
                          _screenState.refresh();
                        },
                        selectedValue: pikedCompany ?? CompanyModel.empty(),
                        title: _companies[index].name,
                        value: _companies[index],
                        selectedColor: Color(0xff60CF86),
                      );
                    },
                    itemCount: _companies.length,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.75,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff024D92),
                ),
                child: Text(S.current.send),
                onPressed: () {
                  if (pikedCompany != null) {
                    showConfirmDialog(
                      context,
                      title:
                          '${S.current.areYouSureThatYouWantToAssignThisOrderTo} ${pikedCompany?.name} ؟',
                      message: '',
                      confirmButtonColor: Colors.amber,
                      onConfirm: () {
                        _screenState
                            .assignOrderToExternalCompany(pikedCompany!.id);
                      },
                      confirmButtonTitle: Text(
                        S.current.yes,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.black),
                      ),
                      hasCancelButton: true,
                    );
                  } else {
                    CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.pleasePickCompany,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
