import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  final String firstButtonTitle;
  final String secondButtonTitle;
  final VoidCallback? firstButtonTab;
  final VoidCallback secondButtonTab;
  final bool? loading;
  AuthButtons(
      {required this.firstButtonTitle,
      required this.secondButtonTitle,
      this.firstButtonTab,
      required this.secondButtonTab,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor,
            ]),
      ),
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 8.0),
            child: Container(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                  onPressed: firstButtonTab,
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: loading!
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            firstButtonTitle,
                            style: TextStyle(
                              color: firstButtonTab != null
                                  ? Colors.white
                                  : Theme.of(context).disabledColor,
                            ),
                          ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 16.0, left: 16, bottom: 8.0, top: 8.0),
            child: Container(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                  onPressed: secondButtonTab,
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    primary: Theme.of(context).colorScheme.secondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      secondButtonTitle,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
