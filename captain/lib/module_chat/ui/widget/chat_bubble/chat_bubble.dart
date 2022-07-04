import 'package:c4d/consts/urls.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:flutter/material.dart' as m;
import 'package:url_launcher/url_launcher.dart';

class ChatBubbleWidget extends StatefulWidget {
  final bool? showImage;
  final String message;
  final DateTime sentDate;
  final bool me;

  ChatBubbleWidget({
    Key? key,
    required this.message,
    required this.sentDate,
    required this.me,
    this.showImage,
  });

  @override
  State<StatefulWidget> createState() => ChatBubbleWidgetState();
}

class ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  bool focused = false;
  var reg = RegExp(
      r'[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc]');
  var format = DateFormat().add_jm();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.me ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              constraints: const BoxConstraints(
                minWidth: 100,
                maxWidth: 240,
              ),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: widget.me
                      ? Theme.of(context).primaryColor.withOpacity(0.25)
                      : Theme.of(context).backgroundColor),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: reg.hasMatch(widget.message)
                        ? m.TextDirection.rtl
                        : m.TextDirection.ltr,
                    children: [
                      widget.message.contains(Urls.IMAGES_ROOT)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CustomNetworkImage(
                                background: widget.me
                                    ? Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.25)
                                    : null,
                                imageSource: widget.message.replaceFirst(
                                    'uploadimage', 'upload/image'),
                                height: 250,
                                width: 240,
                              ),
                            )
                          : SelectableLinkify(
                              onOpen: (link) async {
                                if (await canLaunch(link.url)) {
                                  await launch(link.url);
                                } else {
                                  Fluttertoast.showToast(msg: 'Invalid link');
                                }
                              },
                              text: widget.message,
                              textAlign: reg.hasMatch(widget.message)
                                  ? TextAlign.right
                                  : TextAlign.left,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 4),
              child: Text(
                format.format(widget.sentDate),
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ])),
    );
  }
}
