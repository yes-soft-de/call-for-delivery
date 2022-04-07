import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_notice/model/notice_model.dart';
import 'package:c4d/module_notice/ui/screen/notice_screen.dart';
import 'package:c4d/module_notice/ui/widget/filter_bar.dart';
import 'package:c4d/module_notice/ui/widget/note_card.dart';
import 'package:c4d/module_notice/ui/widget/notice_form.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';

class NoticeLoadedState extends States {
  final NoticeScreenState screenState;
  final String? error;
  final bool empty;
  final List<NoticeModel>? model;

  NoticeLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }

  String? search;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getNotice();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getNotice();
          });
    }
    return Container(
      width: double.maxFinite,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: CustomListView.custom(
              children: getCategories(screenState.currentIndex)),
        ),
      ),
    );
  }

  List<Widget> getCategories(int currentIndex) {
    var context = screenState.context;
    List<Widget> widgets = [];
    if (model == null) {
      return widgets;
    }
    if (model!.isEmpty) return widgets;
    for (var element in model ?? <NoticeModel>[]) {
      if (currentIndex == 0 &&
          (element.appType == 'captains' || element.appType == 'all')) {
        widgets.add(
          NoteCard(
            title: element.title,
            msg: element.msg,
            edit: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return NoticeForm(
                      request: element,
                      onSave: (request) {
                        screenState.updateNotice(request);
                      },
                    );
                  });
            },
          ),
        );
      } else if (currentIndex == 1 &&
          (element.appType == 'stores' || element.appType == 'all')) {
        widgets.add(
          NoteCard(
            title: element.title,
            msg: element.msg,
            edit: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return NoticeForm(
                      request: element,
                      onSave: (request) {
                        screenState.updateNotice(request);
                      },
                    );
                  });
            },
          ),
        );
      }
    }

    if (model != null) {
      widgets.insert(
        0,
        FilterBar(
          cursorRadius: BorderRadius.circular(25),
          animationDuration: Duration(milliseconds: 350),
          backgroundColor: Theme.of(context).backgroundColor,
          currentIndex: currentIndex,
          borderRadius: BorderRadius.circular(25),
          floating: true,
          height: 40,
          cursorColor: Theme.of(context).colorScheme.primary,
          items: [
            FilterItem(label: S.current.captain),
            FilterItem(label: S.current.store),
          ],
          onItemSelected: (index) {
            screenState.currentIndex = index;
            screenState.refresh();
          },
          selectedContent: Theme.of(context).textTheme.button!.color!,
          unselectedContent: Theme.of(context).textTheme.headline6!.color!,
        ),
      );
    }
    return widgets;
  }
}
