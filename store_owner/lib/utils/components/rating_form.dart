import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class RatingForm extends StatefulWidget {
  final Function(int) onPressed;
  final String title;
  final String message;
  final TextEditingController controller;
  RatingForm(
      {required this.onPressed,
      required this.message,
      required this.title,
      required this.controller});

  @override
  State<RatingForm> createState() => _RatingFormState();
}

class _RatingFormState extends State<RatingForm> {
  double? _rate;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(context, title: widget.title),
        body: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).colorScheme.primary),
                    child: ListTile(
                      title: Text(
                        widget.message,
                        style: Theme.of(context).textTheme.button,
                      ),
                      leading: Icon(
                        Icons.info,
                        color: Theme.of(context).textTheme.button?.color,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Theme.of(context).backgroundColor,
                  indent: 32,
                  endIndent: 32,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    SvgAsset.ACCEPT_ORDER,
                    height: 200,
                    width: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(S.current.chooseYourRateFromFiveStar),
                ),
                RatingBar.builder(
                  initialRating: 0,
                  glowColor: Colors.amberAccent,
                  minRating: 0.0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  onRatingUpdate: (rating) {
                    _rate = rating;
                    setState(() {});
                  },
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amberAccent,
                  ),
                ),
                ListTile(
                  title: Text(S.current.comment),
                  subtitle: CustomFormField(
                    controller: widget.controller,
                    hintText: S.current.rateCommentReview,
                    maxLines: 3,
                    last: true,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),

                        onPressed: _rate == null
                            ? null
                            : () {
                                widget.onPressed(_rate?.toInt() ?? 0);
                              },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(S.current.submit,
                              style: Theme.of(context).textTheme.button),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
