import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_notice/model/notice_model.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String? title;
  final String? msg;
  final List<NoticeImage>? images;
  final Function() edit;

  NoteCard({
    required this.title,
    required this.msg,
    required this.edit,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: new BoxDecoration(
            border: BorderDirectional(
              start:
                  BorderSide(width: 8, color: Theme.of(context).primaryColor),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title ?? S.of(context).unknown,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    _EditButton(edit: edit)
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        msg ?? S.of(context).unknown,
                        // overflow: TextOverflow.,
                      ),
                    ),
                    _Images(images: images),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Images extends StatelessWidget {
  const _Images({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<NoticeImage>? images;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: images != null,
      child: Expanded(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 250,
          ),
          child: Swiper(
            itemCount: images?.length ?? 0,
            pagination: SwiperPagination(
              margin: EdgeInsets.only(bottom: 0),
              builder: SwiperPagination.dots,
              alignment: Alignment.bottomCenter,
            ),
            itemBuilder: (context, index) {
              print(images?[index]);
              return Column(
                children: [
                  Expanded(
                    child: CustomNetworkImage(
                      imageSource: images?[index].image ?? '',
                      height: 150,
                      width: 150,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({
    Key? key,
    required this.edit,
  }) : super(key: key);

  final Function() edit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: edit,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.background.withOpacity(0.8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.edit,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
