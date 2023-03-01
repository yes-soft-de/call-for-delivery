import 'package:c4d/consts/urls.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_chat/model/chat/chat_model.dart';
import 'package:c4d/module_chat/ui/widget/chat_bubble/chat_bubble.dart';
import 'package:c4d/utils/helpers/date_utilts.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

// ignore: must_be_immutable
class SubListChatWidget extends StatelessWidget {
  final String date;
  final String username;
  final List<ChatModel> messages;
  int index;
  final AutoScrollController controller;
  final Function(int) currentIndex;
  SubListChatWidget({
    Key? key,
    required this.date,
    required this.messages,
    required this.username,
    required this.index,
    required this.controller,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 8,
            top: 16,
            bottom: 16,
          ),
          child: Text(
            isDateToday(date, 'd MMM y')
                ? S.current.today
                : isDateYesterday(date, 'd MMM y')
                    ? S.current.yesterday
                    : date,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Theme.of(context).disabledColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: getChatBubble(context),
        ),
      ],
    );
  }

  List<Widget> getChatBubble(context) {
    List<Widget> widgets = [];
    int i = 0 + index;
    messages.forEach((message) {
      widgets.add(AutoScrollTag(
        controller: controller,
        key: ValueKey(message.sentDate),
        index: i,
        child: ChatBubbleWidget(
          message: message.msg ?? '',
          me: message.sender == username ? true : false,
          sentDate: message.sentDate,
          isAdmin:
              message.isAdmin ?? Urls.admins.contains(message.sender ?? ''),
          username: message.sender,
        ),
      ));
      i += 1;
    });
    currentIndex(i);
    return widgets;
  }
}
