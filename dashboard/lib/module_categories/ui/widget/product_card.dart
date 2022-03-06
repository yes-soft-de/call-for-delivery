import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/customIcon/mandob_icons_icons.dart';
import 'package:c4d/utils/effect/hidder.dart';

class ProductComponent extends StatelessWidget {
  final String productId;
  final String title;
  final String image;
  final String price;
  final String discount;
  final String commission;
  final bool isCommission;
  ProductComponent(
      {required this.title,
      required this.image,
      required this.discount,
      required this.productId,
      required this.price,
      required this.commission,
      required this.isCommission});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(
                    height: 8,
                  ),
                  Hider(
                    active: isCommission,
                    child: Row(
                      children: [
                        Text(
                          S.current.tax + '  ',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          commission,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [],
                        ),
                        Column(
                          children: [
                            Text(
                              S.current.discount,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Icon(
                                  MandobIcons.discount,
                                  size: 15,
                                  color: discount == '0'
                                      ? Colors.red
                                      : Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '$discount',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, left: 8.0, bottom: 18),
                          child: Text(
                            '|',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              S.current.privateOrder,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.shoppingBag,
                                  size: 12,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '$price',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            )),
            SizedBox(
              width: 16,
            ),
            SizedBox(
              height: 125,
              width: 125,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CustomNetworkImage(
                      height: 125, width: 125, imageSource: image),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
