import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_notice/model/notice_model.dart';
import 'package:c4d/module_notice/ui/screen/notice_screen.dart';
import 'package:c4d/module_notice/ui/widget/filter_bar.dart';
import 'package:c4d/module_notice/ui/widget/note_card.dart';
import 'package:c4d/module_notice/ui/widget/notice_form.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
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
          child: Column(
            children: [
              Visibility(
                visible: model != null,
                child: FilterBar(
                  cursorRadius: BorderRadius.circular(25),
                  animationDuration: Duration(milliseconds: 350),
                  backgroundColor: Theme.of(context).colorScheme.background,
                  currentIndex: screenState.currentIndex,
                  borderRadius: BorderRadius.circular(25),
                  floating: true,
                  height: 40,
                  cursorColor: Theme.of(context).colorScheme.primary,
                  items: [
                    FilterItem(label: S.current.captain),
                    FilterItem(label: S.current.store),
                    FilterItem(label: S.current.suppliers),
                  ],
                  onItemSelected: (index) {
                    screenState.currentIndex = index;
                    screenState.refresh();
                  },
                  selectedContent:
                      Theme.of(context).textTheme.labelLarge!.color!,
                  unselectedContent:
                      Theme.of(context).textTheme.titleLarge!.color!,
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: model?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (model != null) {
                      if (screenState.currentIndex == 0 &&
                          (model![index].appType == 'captains' ||
                              model![index].appType == 'all')) {
                        return NoteCard(
                          title: model![index].title,
                          msg: model![index].msg,
                          images: model![index].images,
                          edit: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return NoticeForm(
                                    request: model![index],
                                    onSave: (request) {
                                      screenState.updateNotice(request);
                                    },
                                  );
                                });
                          },
                        );
                      } else if (screenState.currentIndex == 1 &&
                          (model![index].appType == 'stores' ||
                              model![index].appType == 'all')) {
                        return NoteCard(
                          images: model![index].images,
                          title: model![index].title,
                          msg: model![index].msg,
                          edit: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return NoticeForm(
                                  request: model![index],
                                  onSave: (request) {
                                    screenState.updateNotice(request);
                                  },
                                );
                              },
                            );
                          },
                        );
                      } else if (screenState.currentIndex == 2 &&
                          (model![index].appType == 'suppliers' ||
                              model![index].appType == 'all')) {
                        NoteCard(
                          images: model![index].images,
                          title: model![index].title,
                          msg: model![index].msg,
                          edit: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return NoticeForm(
                                  request: model![index],
                                  onSave: (request) {
                                    screenState.updateNotice(request);
                                  },
                                );
                              },
                            );
                          },
                        );
                      }
                    }
                    return SizedBox();
                  },
                ),
              ),
              SizedBox(height: 75),
            ],
          ),
        ),
      ),
    );
  }
}
