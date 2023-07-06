import 'package:store_web/generated/l10n.dart';
import 'package:store_web/utils/components/custom_app_bar.dart';
import 'package:store_web/utils/components/custom_feild.dart';
import 'package:store_web/utils/components/custom_list_view.dart';
import 'package:store_web/utils/components/progresive_image.dart';
import 'package:store_web/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class RatingForm extends StatefulWidget {
  final Function(int) onPressed;
  final String title;
  final String message;
  final TextEditingController controller;
  const RatingForm(
      {super.key, required this.onPressed,
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
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomListView.custom(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.amber),
                  child: ListTile(
                    title: Text(
                      widget.message,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    leading: Icon(
                      Icons.info,
                      color: Theme.of(context).textTheme.labelLarge?.color,
                    ),
                  ),
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.background,
                indent: 32,
                endIndent: 32,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  SvgAsset.RATE_SVG,
                  height: 200,
                  width: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Center(child: Text(S.current.chooseYourRateFromFiveStar)),
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: 0,
                  glowColor: Colors.amberAccent,
                  minRating: 0.0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  onRatingUpdate: (rating) {
                    _rate = rating;
                    setState(() {});
                  },
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amberAccent,
                  ),
                ),
              ),
              ListTile(
                title: Text(S.current.comment),
                subtitle: CustomFormField(
                  keyAction: TextInputAction.done,
                  controller: widget.controller,
                  hintText: S.current.rateCommentReview,
                  maxLines: 3,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                      onPressed: _rate == null
                          ? null
                          : () {
                              widget.onPressed(_rate?.toInt() ?? 0);
                            },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(S.current.submit,
                            style: Theme.of(context).textTheme.labelLarge),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
