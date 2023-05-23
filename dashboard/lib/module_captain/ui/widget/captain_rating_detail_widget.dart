// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../generated/l10n.dart';

class ItemRatingWidget extends StatelessWidget {
  final String storeOwnerName;
  final int orderId;
  final int rate;
  final String comment;
  const ItemRatingWidget({
    Key? key,
    required this.storeOwnerName,
    required this.rate,
    required this.comment,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        children: [
          CustomListTileRating(
            title: S.current.orderNumber,
            subTitle: orderId.toString(),
            iconData: FontAwesomeIcons.paperclip,
          ),
          CustomListTileRating(
            title: storeOwnerName,
            subTitle: '',
            iconData: Icons.store,
          ),
          CustomListTileRating(
            title: S.current.rateCaptainDetails,
            subTitle: '',
            iconData: Icons.star,
            leading: Container(
              child: RatingBarIndicator(
                rating: rate.toDouble(),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
            ),
          ),
          CustomListTileRating(
            title: comment == '' ? S.current.noComment : comment,
            subTitle: '',
            iconData: Icons.comment,
          ),
        ],
      ),
    );
  }
}

class CustomListTileRating extends StatelessWidget {
  final String title;
  String? subTitle;
  final IconData iconData;
  Widget? leading;
  CustomListTileRating(
      {required this.title,
      this.subTitle,
      required this.iconData,
      this.leading});
  @override
  Widget build(BuildContext context) {
    Widget? icon;
    return ListTile(
      leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(iconData, color: Theme.of(context).colorScheme.primary),
          )),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      trailing: leading ?? icon,
      subtitle: subTitle == ''
          ? null
          : Text(
              subTitle ?? S.current.unknown,
              style: TextStyle(color: Colors.white),
              textDirection: S.current.phoneNumber == title &&
                      Localizations.localeOf(context).languageCode == 'ar'
                  ? TextDirection.ltr
                  : null,
              textAlign: S.current.phoneNumber == title &&
                      Localizations.localeOf(context).languageCode == 'ar'
                  ? TextAlign.right
                  : null,
            ),
    );
  }
}
