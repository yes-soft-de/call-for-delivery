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
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).textTheme.labelLarge?.color ??
                                    Colors.white),
                          )
                        : Text(
                            firstButtonTitle,
                            style: TextStyle(
                              color: firstButtonTab != null
                                  ? Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.color
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
              child: OutlinedButton(
                  onPressed: secondButtonTab,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
                          color: Color(0xff03816A),
                          width: 3,
                          style: BorderStyle.solid),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      secondButtonTitle,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Color(0xff03816A),
                          ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
